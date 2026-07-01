package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerDAO;
import dto.Customer;
import dto.Service;
import dto.User;
import service.BookingService;
import utils.AppConstants;

/**
 * Controller xử lý luồng nghiệp vụ Đặt Lịch (Booking).
 * - Phương thức GET: Gọi BookingService chuẩn bị dữ liệu và hiển thị giao diện booking.jsp.
 * - Phương thức POST: Nhận dữ liệu đặt lịch, gọi BookingService kiểm tra tính hợp lệ và lưu vào cơ sở dữ liệu.
 */
@WebServlet(name = "BookingController", urlPatterns = { "/BookingController" })
public class BookingController extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByAccountId(user.getUserId());

            if (customer != null) {
                Map<String, Object> pageData = bookingService.prepareBookingPageData(customer);
                for (Map.Entry<String, Object> entry : pageData.entrySet()) {
                    request.setAttribute(entry.getKey(), entry.getValue());
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/customer/booking.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu đặt lịch.");
            request.getRequestDispatcher("/WEB-INF/views/customer/booking.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByAccountId(user.getUserId());
            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }

            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            int serviceId = Integer.parseInt(request.getParameter("service"));
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");

            Date bookingDate = Date.valueOf(LocalDate.parse(dateStr));
            Time scheduledTime = Time.valueOf(LocalTime.parse(timeStr + ":00"));

            // Validation travel time
            bookingService.validateTravelTime(bookingDate, scheduledTime);

            Service selectedService = bookingService.getServiceById(serviceId);
            
            double originalPrice = selectedService.getBasePrice();
            double discountAmount = 0; 
            double finalPrice = originalPrice - discountAmount;

            boolean success = bookingService.createBooking(
                    customer.getCustomerId(),
                    serviceId,
                    vehicleId,
                    bookingDate,
                    scheduledTime,
                    originalPrice,
                    discountAmount,
                    finalPrice);

            if (success) {
                request.getSession().setAttribute("successMessage", "Đặt lịch thành công!");
                response.sendRedirect(request.getContextPath() + "/account/dashboard");
            } else {
                throw new Exception("Đặt lịch thất bại.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.getSession().setAttribute("errorMessage", ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/bookings");
        }
    }
}
