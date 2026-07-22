package controller;

import dao.BookingDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminUpdateBookingStatusController", urlPatterns = {"/admin/update-booking-status"})
public class AdminUpdateBookingStatusController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String bookingIdStr = request.getParameter("bookingId");
        String newStatus = request.getParameter("newStatus");
        String currentFilterStatus = request.getParameter("currentFilterStatus");
        String currentFilterDate = request.getParameter("currentFilterDate");
        String currentSearch = request.getParameter("currentSearch");
        String currentPage = request.getParameter("currentPage");
        
        if (bookingIdStr != null && !bookingIdStr.trim().isEmpty() && newStatus != null && !newStatus.trim().isEmpty()) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bookingDAO = new BookingDAO();
                
                if ("Completed".equalsIgnoreCase(newStatus)) {
                    // Xử lý hoàn thành (giải phóng slot, trigger SQL server tự cộng điểm)
                    bookingDAO.completeBookingTransaction(bookingId);
                } else if ("Cancelled".equalsIgnoreCase(newStatus) || "No Show".equalsIgnoreCase(newStatus)) {
                    // Hủy hoặc khách không đến -> giải phóng slot
                    bookingDAO.adminCancelBookingTransaction(bookingId, newStatus);
                } else if ("Pending".equalsIgnoreCase(newStatus) || 
                           "Confirmed".equalsIgnoreCase(newStatus) || 
                           "InProgress".equalsIgnoreCase(newStatus) || 
                           "Waitlisted".equalsIgnoreCase(newStatus)) {
                    // Cập nhật trạng thái bình thường
                    bookingDAO.updateBookingStatus(bookingId, newStatus);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // Quay lại trang quản lý (giữ nguyên filter)
        String redirectUrl = request.getContextPath() + "/admin/bookings";
        boolean hasQuery = false;
        if (currentFilterStatus != null && !currentFilterStatus.isEmpty()) {
            redirectUrl += "?status=" + currentFilterStatus;
            hasQuery = true;
        }
        if (currentFilterDate != null && !currentFilterDate.isEmpty()) {
            redirectUrl += (hasQuery ? "&" : "?") + "date=" + currentFilterDate;
            hasQuery = true;
        }
        if (currentSearch != null && !currentSearch.trim().isEmpty()) {
            redirectUrl += (hasQuery ? "&" : "?") + "search=" + java.net.URLEncoder.encode(currentSearch, "UTF-8");
            hasQuery = true;
        }
        if (currentPage != null && !currentPage.trim().isEmpty()) {
            redirectUrl += (hasQuery ? "&" : "?") + "page=" + currentPage;
        }
        
        response.sendRedirect(redirectUrl);
    }
}
