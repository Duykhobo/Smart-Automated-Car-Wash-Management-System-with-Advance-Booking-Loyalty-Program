package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Map;
import java.util.HashMap;
import utils.ValidationUtil;

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
@WebServlet(name = "BookingController", urlPatterns = { "/BookingController", "/bookings" })
public class BookingController extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

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
        response.setContentType("text/html; charset=UTF-8");
        
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

            String vehicleIdStr = request.getParameter("vehicleId");
            String[] serviceIds = request.getParameterValues("services");
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");
            String voucherCode = request.getParameter("voucherCode");

            Map<String, String> errors = new HashMap<>();

            if (vehicleIdStr == null || vehicleIdStr.trim().isEmpty()) {
                errors.put("vehicleId", "Vui lòng chọn xe");
            }
            if (serviceIds == null || serviceIds.length == 0) {
                errors.put("services", "Vui lòng chọn ít nhất một dịch vụ");
            }
            if (dateStr == null || dateStr.trim().isEmpty()) {
                errors.put("date", "Vui lòng chọn ngày");
            }
            if (timeStr == null || timeStr.trim().isEmpty()) {
                errors.put("time", "Vui lòng chọn giờ");
            }
            if (voucherCode != null && !voucherCode.trim().isEmpty() && !ValidationUtil.isValidVoucherCode(voucherCode)) {
                errors.put("voucherCode", "Mã voucher không hợp lệ (Chữ IN HOA, số, dấu - _)");
            }

            if (!errors.isEmpty()) {
                request.getSession().setAttribute("errors", errors);
                request.getSession().setAttribute("errorMessage", "Vui lòng kiểm tra lại thông tin đặt lịch");

                Map<String, String> formValues = new HashMap<>();
                formValues.put("vehicleId", vehicleIdStr);
                formValues.put("date", dateStr);
                formValues.put("time", timeStr);
                formValues.put("voucherCode", voucherCode);
                if (serviceIds != null) {
                    formValues.put("services", String.join(",", serviceIds));
                }
                request.getSession().setAttribute("formValues", formValues);

                response.sendRedirect(request.getContextPath() + "/bookings");
                return;
            }

            int vehicleId = Integer.parseInt(vehicleIdStr);
            Date bookingDate = Date.valueOf(LocalDate.parse(dateStr));
            Time scheduledTime = Time.valueOf(LocalTime.parse(timeStr + ":00"));

            // Validation travel time and max booking date
            bookingService.validateMaxBookingDate(customer.getTierStatus(), bookingDate);
            bookingService.validateTravelTime(bookingDate, scheduledTime);

            java.util.List<Service> selectedServices = bookingService.getServicesByIds(serviceIds);
            double originalPrice = 0;
            int totalDurationMinutes = 0;
            for (Service s : selectedServices) {
                originalPrice += s.getBasePrice();
                totalDurationMinutes += s.getDurationMinutes();
            }
            
            // Validate if total duration exceeds closing hour
            bookingService.validateWorkingHours(scheduledTime, totalDurationMinutes);

            // Validate double booking
            bookingService.validateVehicleDoubleBooking(vehicleId, bookingDate, scheduledTime, totalDurationMinutes);

            String serviceIdsStr = String.join(",", serviceIds);
            
            Integer voucherId = null;
            double discountAmount = 0;
            
            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                dao.BookingDAO dao = new dao.BookingDAO();
                dto.Voucher v = dao.getActiveVoucherByCode(voucherCode.trim(), customer.getCustomerId());
                if (v != null) {
                    voucherId = v.getVoucherId();
                    if (v.getDiscountPercent() > 0) {
                        discountAmount = originalPrice * (v.getDiscountPercent() / 100.0);
                    } else if ("PERCENT_10".equals(v.getRewardType())) discountAmount = originalPrice * 0.10;
                    else if ("PERCENT_20".equals(v.getRewardType())) discountAmount = originalPrice * 0.20;
                    else if ("FREE_WASH".equals(v.getRewardType())) discountAmount = originalPrice;
                    else if ("UPGRADE_WAX".equals(v.getRewardType())) discountAmount = 50000; // Assume 50k for wax upgrade
                }
            }
            
            double finalPrice = originalPrice - discountAmount;
            if (finalPrice < 0) finalPrice = 0;

            boolean success = bookingService.createBooking(
                    customer.getCustomerId(),
                    serviceIdsStr,
                    vehicleId,
                    voucherId,
                    bookingDate,
                    scheduledTime,
                    originalPrice,
                    discountAmount,
                    finalPrice,
                    totalDurationMinutes);

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

