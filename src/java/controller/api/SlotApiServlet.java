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

@WebServlet(name = "SlotApiServlet", urlPatterns = {"/api/slots"})
public class SlotApiServlet extends HttpServlet {

    private static final LocalTime OPEN_TIME = LocalTime.of(8, 0);
    private static final LocalTime CLOSE_TIME = LocalTime.of(18, 0);
    private static final int SLOT_DURATION_MINS = 30;
    private static final int DEFAULT_MAX_CAPACITY = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String dateParam = request.getParameter("date");
        if (dateParam == null || dateParam.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Missing date parameter\"}");
            return;
        }

        try {
            Date bookingDate = Date.valueOf(dateParam);
            BookingDAO bookingDAO = new BookingDAO();
            List<BookingSlotCapacity> dbSlots = bookingDAO.getSlotsByDate(bookingDate);
            
            // Map DB slots by time for fast lookup
            Map<String, BookingSlotCapacity> dbSlotMap = new HashMap<>();
            for (BookingSlotCapacity slot : dbSlots) {
                // Time from DB: HH:mm:ss
                String timeStr = slot.getTimeSlot().toString().substring(0, 5); 
                dbSlotMap.put(timeStr, slot);
            }

            List<Map<String, Object>> responseSlots = new ArrayList<>();
            LocalTime currentTime = OPEN_TIME;
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

            while (!currentTime.isAfter(CLOSE_TIME.minusMinutes(SLOT_DURATION_MINS))) {
                String timeStr = currentTime.format(formatter);
                Map<String, Object> slotData = new HashMap<>();
                slotData.put("time", timeStr);
                
                if (dbSlotMap.containsKey(timeStr)) {
                    BookingSlotCapacity dbSlot = dbSlotMap.get(timeStr);
                    slotData.put("currentBooked", dbSlot.getCurrentBooked());
                    slotData.put("maxCapacity", dbSlot.getMaxCapacity());
                } else {
                    slotData.put("currentBooked", 0);
                    slotData.put("maxCapacity", DEFAULT_MAX_CAPACITY);
                }
                
                responseSlots.add(slotData);
                currentTime = currentTime.plusMinutes(SLOT_DURATION_MINS);
            }

            StringBuilder jsonBuilder = new StringBuilder("[");
            for (int i = 0; i < responseSlots.size(); i++) {
                Map<String, Object> slotDataMap = responseSlots.get(i);
                jsonBuilder.append("{")
                           .append("\"time\":\"").append(slotDataMap.get("time")).append("\",")
                           .append("\"currentBooked\":").append(slotDataMap.get("currentBooked")).append(",")
                           .append("\"maxCapacity\":").append(slotDataMap.get("maxCapacity"))
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
