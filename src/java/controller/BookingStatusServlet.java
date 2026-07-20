package controller;

import dao.BookingDAO;
import dto.Booking;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingStatusServlet", urlPatterns = {"/api/booking-status"})
public class BookingStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String bookingIdStr = request.getParameter("id");
        if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            int bookingId = Integer.parseInt(bookingIdStr);
            BookingDAO bookingDAO = new BookingDAO();
            Booking booking = bookingDAO.getBookingById(bookingId);

            if (booking != null) {
                out.print("{\"status\":\"" + booking.getStatus() + "\"}");
            } else {
                out.print("{\"status\":\"Unknown\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

