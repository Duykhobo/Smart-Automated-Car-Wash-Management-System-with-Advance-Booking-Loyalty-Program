package controller;

import dao.BookingDAO;
import dao.CarDao;
import dao.CustomerDAO;
import dao.ServiceDAO;
import dto.Cars;
import dto.Customer;
import dto.Service;
import dto.User;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.AppConstants;

@WebServlet(name = "BookingController", urlPatterns = {"/BookingController"})
public class BookingController extends HttpServlet {

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
                // Fetch cars
                CarDao carDao = new CarDao();
                List<Cars> vehicles = carDao.getAllCars(customer.getCustomerId());
                request.setAttribute("vehicles", vehicles);
                
                // Fetch services
                ServiceDAO serviceDAO = new ServiceDAO();
                List<Service> services = serviceDAO.getAllActiveServices();
                request.setAttribute("services", services);
                
                // Generate next 7 days
                List<LocalDate> next7Days = new ArrayList<>();
                LocalDate today = LocalDate.now();
                for (int i = 0; i < 7; i++) {
                    next7Days.add(today.plusDays(i));
                }
                request.setAttribute("next7Days", next7Days);
                
                // Generate time slots (08:00 to 17:00)
                List<String> timeSlots = new ArrayList<>();
                for (int i = 8; i <= 17; i++) {
                    timeSlots.add(String.format("%02d:00", i));
                }
                request.setAttribute("timeSlots", timeSlots);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/booking.jsp").forward(request, response);
            
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu đặt lịch.");
            request.getRequestDispatcher("/WEB-INF/views/booking.jsp").forward(request, response);
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
            // String promoCode = request.getParameter("promoCode"); // Ignore for now
            
            Date bookingDate = Date.valueOf(LocalDate.parse(dateStr));
            Time scheduledTime = Time.valueOf(LocalTime.parse(timeStr + ":00"));

            ServiceDAO serviceDAO = new ServiceDAO();
            List<Service> services = serviceDAO.getAllActiveServices();
            Service selectedService = null;
            for (Service s : services) {
                if (s.getServiceId() == serviceId) {
                    selectedService = s;
                    break;
                }
            }

            if (selectedService == null) {
                throw new Exception("Dịch vụ không hợp lệ.");
            }

            double originalPrice = selectedService.getBasePrice();
            double discountAmount = 0; // handle promo code later
            double finalPrice = originalPrice - discountAmount;

            BookingDAO bookingDAO = new BookingDAO();
            boolean success = bookingDAO.createBookingTransaction(
                    customer.getCustomerId(),
                    serviceId,
                    vehicleId,
                    null, // voucherId
                    bookingDate,
                    scheduledTime,
                    originalPrice,
                    discountAmount,
                    finalPrice
            );

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
