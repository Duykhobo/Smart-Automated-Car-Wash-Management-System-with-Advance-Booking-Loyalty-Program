package controller;

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

import dao.BookingDAO;
import dao.CarDao;
import dao.CustomerDAO;
import dao.ServiceDAO;
import dto.Cars;
import dto.Customer;
import dto.Service;
import dto.User;
import utils.AppConstants;

/**
 * Controller xử lý luồng nghiệp vụ Đặt Lịch (Booking).
 * - Phương thức GET: Lấy thông tin cấu hình, danh sách xe, dịch vụ, và hiển thị giao diện booking.jsp.
 * - Phương thức POST: Nhận dữ liệu đặt lịch từ form, kiểm tra tính hợp lệ (Validation) về mặt thời gian,
 *   tính toán giá tiền và lưu thông tin vào cơ sở dữ liệu.
 */
@WebServlet(name = "BookingController", urlPatterns = { "/BookingController" })
public class BookingController extends HttpServlet {

    /**
     * Xử lý yêu cầu HTTP GET.
     * Chuẩn bị tất cả dữ liệu (Xe, Dịch vụ, Hạng thành viên, Cấu hình thời gian) để render màn hình Đặt Lịch.
     * Dữ liệu thời gian được lấy động từ SystemConfig thông qua SystemConfigDAO.
     */
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

                // Determine Tier Name and Max Booking Days
                String tierStatus = customer.getTierStatus();
                String cleanTier = (tierStatus != null) ? tierStatus.trim() : "";
                
                dao.MemberTierDAO tierDao = new dao.MemberTierDAO();
                dto.MemberTier memberTier = tierDao.getTierByName(cleanTier);

                String tierName = memberTier != null ? memberTier.getTierName() : "Member";
                int maxBookingDays = memberTier != null ? memberTier.getMaxBookingDays() : 7;
                String badgeClass = memberTier != null ? memberTier.getBadgeClass() : "badge-member";
                String bannerBorder = memberTier != null ? memberTier.getBannerBorder() : "border-slate-500";
                String bannerBg = memberTier != null ? memberTier.getBannerBg() : "bg-slate-500/20";
                String bannerIcon = memberTier != null ? memberTier.getBannerIcon() : "text-slate-500";
                String bannerText = memberTier != null ? memberTier.getBannerText() : "text-slate-400";

                request.setAttribute("tierName", tierName);
                request.setAttribute("maxBookingDays", maxBookingDays);
                request.setAttribute("badgeClass", badgeClass);
                request.setAttribute("bannerBorder", bannerBorder);
                request.setAttribute("bannerBg", bannerBg);
                request.setAttribute("bannerIcon", bannerIcon);
                request.setAttribute("bannerText", bannerText);

                // Generate dynamic days
                List<LocalDate> dynamicDays = new ArrayList<>();
                LocalDate today = LocalDate.now();
                for (int i = 0; i < maxBookingDays; i++) {
                    dynamicDays.add(today.plusDays(i));
                }
                request.setAttribute("dynamicDays", dynamicDays);
                
                // Fetch System Config for Opening/Closing hours
                dao.SystemConfigDAO configDao = new dao.SystemConfigDAO();
                int openingHour = configDao.getOpeningHour();
                int closingHour = configDao.getClosingHour();

                // Generate time slots
                List<String> timeSlots = new ArrayList<>();
                for (int i = openingHour; i <= closingHour; i++) {
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

    /**
     * Xử lý yêu cầu HTTP POST.
     * Nhận submit từ form Đặt Lịch, kiểm tra các ràng buộc về thời gian di chuyển (Travel Time),
     * tính toán thành tiền và thực hiện Insert vào DB thông qua Transaction.
     */
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

            // ==========================================
            // VALIDATION: TRAVEL TIME (Thời gian di chuyển)
            // Lấy thời gian yêu cầu đặt trước từ cấu hình, so sánh với khoảng cách từ hiện tại đến lúc hẹn.
            // ==========================================
            dao.SystemConfigDAO configDao = new dao.SystemConfigDAO();
            int minAdvanceBookingMinutes = configDao.getMinAdvanceBookingMinutes();

            java.time.LocalDateTime now = java.time.LocalDateTime.now();
            java.time.LocalDateTime scheduledDateTime = java.time.LocalDateTime.of(bookingDate.toLocalDate(), scheduledTime.toLocalTime());
            
            // Nếu Hiện tại + Thời gian di chuyển tối thiểu vượt quá Thời gian hẹn -> Chặn
            if (scheduledDateTime.isBefore(now.plusMinutes(minAdvanceBookingMinutes))) {
                throw new Exception("Vui lòng đặt lịch trước giờ đến ít nhất " + minAdvanceBookingMinutes + " phút để chúng tôi chuẩn bị.");
            }

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
