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

@WebServlet(name = "AdminEditBookingServlet", urlPatterns = {"/admin/update-booking-time"})
public class AdminEditBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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
            
            BookingDAO bookingDAO = new BookingDAO();
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
