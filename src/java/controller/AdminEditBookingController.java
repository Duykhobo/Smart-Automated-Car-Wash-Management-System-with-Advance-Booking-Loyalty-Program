package controller;

import dao.BookingDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminEditBookingController", urlPatterns = {"/admin/update-booking-time"})
public class AdminEditBookingController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        
        String bookingIdStr = request.getParameter("bookingId");
        String newDateStr = request.getParameter("newDate");
        String newTimeStr = request.getParameter("newTime");
        
        if (bookingIdStr == null || newDateStr == null || newTimeStr == null) {
            session.setAttribute("toastMessage", "error|Thiếu thông tin đổi giờ!");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            Date newDate = Date.valueOf(newDateStr); // Format YYYY-MM-DD
            Time newTime = Time.valueOf(newTimeStr + ":00"); // Format HH:mm:00
            
            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            java.time.LocalDateTime scheduledDateTime = java.time.LocalDateTime.of(newDate.toLocalDate(), newTime.toLocalTime());
            
            if (scheduledDateTime.isBefore(now)) {
                session.setAttribute("toastMessage", "error|Không thể dời lịch về quá khứ!");
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
                return;
            }
            
            BookingDAO bookingDAO = new BookingDAO();
            
            // Validate double booking
            dao.SystemConfigDAO configDao = new dao.SystemConfigDAO();
            int maxCapacity = configDao.getMaxSlotCapacity();
            java.util.List<dto.BookingSlotCapacity> slots = bookingDAO.getSlotsByDate(newDate);
            boolean isFull = false;
            for (dto.BookingSlotCapacity slot : slots) {
                if (slot.getTimeSlot().toString().startsWith(newTimeStr)) {
                    if (slot.getCurrentBooked() >= maxCapacity) {
                        isFull = true;
                    }
                    break;
                }
            }
            
            if (isFull) {
                session.setAttribute("toastMessage", "error|Khung giờ này đã kín chỗ (vượt quá " + maxCapacity + " xe)!");
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
                return;
            }

            boolean success = bookingDAO.updateBookingTimeOnly(bookingId, newDate, newTime);
            
            if (success) {
                session.setAttribute("toastMessage", "success|Đã dời lịch thành công!");
            } else {
                session.setAttribute("toastMessage", "error|Dời lịch thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastMessage", "error|Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }
}
