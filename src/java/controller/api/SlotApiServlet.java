package controller.api;

import dao.BookingDAO;
import dto.BookingSlotCapacity;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
import utils.AppConstants;
import dto.User;

/**
 * API Servlet cung cấp dữ liệu về các khung giờ (slots) và sức chứa (capacity).
 * Trả về danh sách các slot (08:00 đến 17:30) dưới định dạng JSON.
 * Endpoint này chỉ cho phép người dùng đã đăng nhập truy cập để tránh scraping.
 */
@WebServlet(name = "SlotApiServlet", urlPatterns = {"/api/slots"})
public class SlotApiServlet extends HttpServlet {

    private static final int SLOT_DURATION_MINS = 30;
    private static final int DEFAULT_MAX_CAPACITY = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Kiểm tra bảo mật: Ngăn chặn truy cập API trái phép (Scraping)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute(AppConstants.SESSION_USER_ACCOUNT) == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Unauthorized access. Please login first.\"}");
            return;
        }
        
        String dateParam = request.getParameter("date");
        if (dateParam == null || dateParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing date parameter\"}");
            return;
        }

        try {
            Date bookingDate = Date.valueOf(dateParam);
            
            String durationParam = request.getParameter("duration");
            int duration = (durationParam != null && !durationParam.isEmpty()) ? Integer.parseInt(durationParam) : 30;
            int slotsNeeded = (int) Math.ceil(duration / (double) SLOT_DURATION_MINS);
            if (slotsNeeded < 1) slotsNeeded = 1;

            BookingDAO bookingDAO = new BookingDAO();
            
            // Lấy dữ liệu công suất đã được đặt cho từng khung giờ trong ngày
            List<BookingSlotCapacity> dbSlots = bookingDAO.getSlotsByDate(bookingDate);
            
            // Map DB slots by time để tra cứu O(1)
            Map<String, BookingSlotCapacity> dbSlotMap = new HashMap<>();
            for (BookingSlotCapacity slot : dbSlots) {
                // Time from DB: HH:mm:ss
                String timeStr = slot.getTimeSlot().toString().substring(0, 5); 
                dbSlotMap.put(timeStr, slot);
            }

            dao.SystemConfigDAO configDao = new dao.SystemConfigDAO();
            int openingHour = configDao.getOpeningHour();
            int closingHour = configDao.getClosingHour();
            int minAdvanceBookingMinutes = configDao.getMinAdvanceBookingMinutes();

            LocalTime openTime = LocalTime.of(openingHour, 0);
            LocalTime closeTime = LocalTime.of(closingHour, 0);

            List<Map<String, Object>> responseSlots = new ArrayList<>();
            LocalTime currentTime = openTime;
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            java.time.LocalDate requestedDate = bookingDate.toLocalDate();

            while (!currentTime.isAfter(closeTime)) {
                String timeStr = currentTime.format(formatter);
                java.time.LocalDateTime slotDateTime = java.time.LocalDateTime.of(requestedDate, currentTime);
                
                // Xác định xem slot đã quá hạn cho phép đặt chưa
                boolean isPast = slotDateTime.isBefore(now.plusMinutes(minAdvanceBookingMinutes));

                Map<String, Object> slotData = new HashMap<>();
                slotData.put("time", timeStr);
                
                // Nạp thông số Booked/Capacity
                if (dbSlotMap.containsKey(timeStr)) {
                    BookingSlotCapacity dbSlot = dbSlotMap.get(timeStr);
                    slotData.put("currentBooked", dbSlot.getCurrentBooked());
                    slotData.put("maxCapacity", dbSlot.getMaxCapacity());
                } else {
                    slotData.put("currentBooked", 0);
                    slotData.put("maxCapacity", DEFAULT_MAX_CAPACITY);
                }

                slotData.put("isPast", isPast);
                
                int currentBooked = (int) slotData.get("currentBooked");
                int maxCapacity = (int) slotData.get("maxCapacity");
                
                boolean isFull = currentBooked >= maxCapacity;
                
                // Thuật toán: Check khả năng phục vụ liên tiếp (Look-ahead)
                if (!isPast && !isFull && slotsNeeded > 1) {
                    LocalTime lookAheadTime = currentTime;
                    for (int i = 1; i < slotsNeeded; i++) {
                        lookAheadTime = lookAheadTime.plusMinutes(SLOT_DURATION_MINS);
                        if (lookAheadTime.isAfter(closeTime)) {
                            isFull = true; // Tràn ra ngoài giờ đóng cửa
                            break;
                        }
                        String lookAheadStr = lookAheadTime.format(formatter);
                        if (dbSlotMap.containsKey(lookAheadStr)) {
                            BookingSlotCapacity lookAheadDbSlot = dbSlotMap.get(lookAheadStr);
                            if (lookAheadDbSlot.getCurrentBooked() >= lookAheadDbSlot.getMaxCapacity()) {
                                isFull = true; // Một slot tương lai bị đầy
                                break;
                            }
                        }
                    }
                }
                
                // Nếu bị Full do look-ahead, ta fake currentBooked = maxCapacity để frontend xử lý như cũ
                if (isFull && currentBooked < maxCapacity) {
                    slotData.put("currentBooked", maxCapacity);
                }
                
                // Cờ nearlyFull: true nếu chỉ còn đúng 1 chỗ trống
                boolean nearlyFull = (maxCapacity - currentBooked) == 1;
                slotData.put("nearlyFull", nearlyFull);
                
                responseSlots.add(slotData);
                // Advance by 30 mins
                currentTime = currentTime.plusMinutes(SLOT_DURATION_MINS);
            }

            StringBuilder jsonBuilder = new StringBuilder("[");
            for (int i = 0; i < responseSlots.size(); i++) {
                Map<String, Object> slotDataMap = responseSlots.get(i);
                jsonBuilder.append("{")
                           .append("\"time\":\"").append(slotDataMap.get("time")).append("\",")
                           .append("\"currentBooked\":").append(slotDataMap.get("currentBooked")).append(",")
                           .append("\"maxCapacity\":").append(slotDataMap.get("maxCapacity")).append(",")
                           .append("\"isPast\":").append(slotDataMap.get("isPast")).append(",")
                           .append("\"nearlyFull\":").append(slotDataMap.get("nearlyFull"))
                           .append("}");
                if (i < responseSlots.size() - 1) {
                    jsonBuilder.append(",");
                }
            }
            jsonBuilder.append("]");
            
            String json = jsonBuilder.toString();
            
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();

        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid date format. Expected YYYY-MM-DD\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Server error\"}");
        }
    }
}
