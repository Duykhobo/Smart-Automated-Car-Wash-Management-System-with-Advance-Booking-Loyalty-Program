package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.sql.Date;
import dao.BookingDAO;
import dto.BookingDetailDTO;

/**
 * AdminBookingServlet điều hướng trang Quản lý Đặt Lịch của Admin.
 */
@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String status = request.getParameter("status");
        String date = request.getParameter("date");
        
        if (status == null || status.trim().isEmpty()) {
            status = "All";
        }
        
        if (date == null) {
            date = "";
        }
        
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 10;
        
        BookingDAO bookingDAO = new BookingDAO();
        
        int totalRecords = bookingDAO.getTotalAdminBookings(date, status, search);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;
        
        List<BookingDetailDTO> bookingList = bookingDAO.getAdminBookings(date, status, search, page, pageSize);
        
        request.setAttribute("bookingList", bookingList);
        request.setAttribute("currentStatus", status);
        request.setAttribute("currentDate", date);
        request.setAttribute("currentSearch", search);
        request.setAttribute("encodedSearch", java.net.URLEncoder.encode(search, "UTF-8"));
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/manage_bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
