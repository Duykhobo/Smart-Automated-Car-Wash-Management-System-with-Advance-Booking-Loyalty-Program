/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.User;
import dto.Booking;
import dto.Customer;
import dao.BookingDAO;
import dao.CustomerDAO;
import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.AppConstants;

/**
 * Controller xử lý Quản lý Lịch Sử Đặt Lịch (Booking History).
 * - Phương thức GET: Lấy danh sách lịch sử (sắp tới và đã qua) hoặc load giao diện Chỉnh sửa lịch hẹn.
 * - Phương thức POST: Xử lý 2 luồng thao tác từ người dùng là Dời Lịch (update) và Hủy Lịch (cancel).
 *   Kèm theo các logic xác thực thời gian chuẩn xác lấy từ SystemConfig.
 */
@WebServlet(name = "BookingHistoryController", urlPatterns = {"/BookingHistoryController"})
public class BookingHistoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Xử lý HTTP GET method.
     * - Nếu tham số action = "edit": Chuyển hướng người dùng sang giao diện Chỉnh sửa với thông số và config đã được truyền sẵn.
     * - Ngược lại: Hiển thị danh sách Lịch sắp tới và Lịch sử.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
        } else {
            String action = request.getParameter("action");
            CustomerDAO cusDao = new CustomerDAO();
            Customer cus = cusDao.getCustomerByAccountId(user.getUserId());
            BookingDAO bookDao = new BookingDAO();
            // Nếu người dùng bấm nút Sửa (action=edit)
            if ("edit".equals(action)) {
                try {
                    int bookingId = Integer.parseInt(request.getParameter("id"));
                    Booking bookingInfo = bookDao.getBookingById(bookingId);
                    // Kiểm tra bảo mật: Chỉ cho phép sửa nếu booking này đúng là của User đang đăng nhập và đang Pending
                    if (bookingInfo != null && bookingInfo.getCustomerId() == cus.getCustomerId() && "Pending".equalsIgnoreCase(bookingInfo.getStatus())) {
                        // Lấy danh sách Xe và Dịch vụ truyền sang trang Edit để điền vào Form
                        dao.CarDao carDao = new dao.CarDao();
                        request.setAttribute("vehicles", carDao.getAllCars(cus.getCustomerId()));

                        dao.ServiceDAO serviceDao = new dao.ServiceDAO();
                        request.setAttribute("services", serviceDao.getAllActiveServices());

                        // Determine Tier Name and Max Booking Days
                        String tierStatus = cus.getTierStatus();
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

                        // Truyền thông tin Booking cũ sang
                        request.setAttribute("bookingInfo", bookingInfo);
                        
                        // Chuyển hướng sang trang Edit
                        request.getRequestDispatcher("/WEB-INF/views/customer/edit_booking.jsp").forward(request, response);
                        return; // Dừng tại đây, không chạy xuống phần hiển thị danh sách nữa
                    } else {
                        response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                    return;
                }
            }
            cus.setTotalWashes(bookDao.getTotalWashes(cus.getCustomerId()));
            List<Booking> upcomingBookings = bookDao.getUpcomingBookings(cus.getCustomerId());
            List<Booking> historyBookings = bookDao.getHistoryBookings(cus.getCustomerId());
            request.setAttribute("upcomingBookings", upcomingBookings);
            request.setAttribute("historyBookings", historyBookings);
            request.setAttribute("customer", cus);
            request.getRequestDispatcher("/WEB-INF/views/customer/booking_history.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý HTTP POST method (Dành cho việc Dời Lịch hoặc Hủy Lịch).
     * @param request: Yêu cầu chứa `action` ("update" hoặc "cancel").
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                int serviceId = Integer.parseInt(request.getParameter("service"));
                String dateStr = request.getParameter("date");
                String timeStr = request.getParameter("time");

                if (dateStr == null || timeStr == null) {
                    throw new Exception("Vui lòng chọn ngày và giờ hợp lệ.");
                }

                java.sql.Date newDate = java.sql.Date.valueOf(dateStr);
                java.sql.Time newTime = java.sql.Time.valueOf(timeStr + ":00");

                // ==========================================
                // VALIDATION: CHECK TRAVEL TIME FOR UPDATE
                // Đảm bảo thời gian lịch dời không quá sát hiện tại.
                // ==========================================
                dao.SystemConfigDAO configDao = new dao.SystemConfigDAO();
                int minAdvanceBookingMinutes = configDao.getMinAdvanceBookingMinutes();

                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                java.time.LocalDateTime scheduledDateTime = java.time.LocalDateTime.of(newDate.toLocalDate(), newTime.toLocalTime());
                
                // Nếu dời lịch quá gấp -> Chặn
                if (scheduledDateTime.isBefore(now.plusMinutes(minAdvanceBookingMinutes))) {
                    throw new Exception("Vui lòng dời lịch trước giờ đến ít nhất " + minAdvanceBookingMinutes + " phút để chúng tôi chuẩn bị.");
                }

                BookingDAO bookDao = new BookingDAO();
                CustomerDAO cusDao = new CustomerDAO();
                Customer cus = cusDao.getCustomerByAccountId(user.getUserId());

                Booking oldBooking = bookDao.getBookingById(bookingId);
                if (oldBooking != null && oldBooking.getCustomerId() == cus.getCustomerId() && "Pending".equalsIgnoreCase(oldBooking.getStatus())) {
                    // Cập nhật giá dựa trên dịch vụ mới
                    ServiceDAO serviceDAO = new ServiceDAO();
                    dto.Service selectedService = null;
                    for (dto.Service s : serviceDAO.getAllActiveServices()) {
                        if (s.getServiceId() == serviceId) {
                            selectedService = s;
                            break;
                        }
                    }

                    if (selectedService == null) {
                        throw new Exception("Dịch vụ không hợp lệ.");
                    }

                    double originalPrice = selectedService.getBasePrice();
                    double oldOriginalPrice = oldBooking.getOriginalPrice();
                    double discountAmount = 0;
                    
                    // Tính lại số tiền giảm giá dựa trên TỈ LỆ (%) thay vì giữ nguyên con số tuyệt đối
                    if (oldOriginalPrice > 0 && oldBooking.getDiscountAmount() > 0) {
                        double discountPercent = oldBooking.getDiscountAmount() / oldOriginalPrice;
                        discountAmount = originalPrice * discountPercent;
                    }
                    
                    double finalPrice = originalPrice - discountAmount;
                    if (finalPrice < 0) finalPrice = 0;

                    boolean success = bookDao.updateBookingTransaction(
                            bookingId, vehicleId,
                            new java.sql.Date(oldBooking.getBookingDate().getTime()), 
                            new java.sql.Time(oldBooking.getScheduledTime().getTime()),
                            newDate, newTime,
                            originalPrice, discountAmount, finalPrice
                    );

                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/customer/booking_history?msg=UpdateSuccess");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/customer/booking_history?msg=UpdateFailed");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                }
            } catch (Exception e) {
                e.printStackTrace();
                String errMsg = e.getMessage() != null ? e.getMessage() : e.getClass().getName();
                try {
                    errMsg = java.net.URLEncoder.encode(errMsg, "UTF-8");
                } catch (Exception ex) {}
                response.sendRedirect(request.getContextPath() + "/customer/booking_history?msg=UpdateError&err=" + errMsg);
            }
        } else if ("cancel".equals(action)) {
            try {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                BookingDAO bookDao = new BookingDAO();
                CustomerDAO cusDao = new CustomerDAO();
                Customer cus = cusDao.getCustomerByAccountId(user.getUserId());
                
                // ==========================================
                // VALIDATION: CHECK CANCELLATION TIME
                // Không cho phép hủy lịch khi giờ hủy nằm quá gần giờ hẹn thực tế.
                // ==========================================
                dao.SystemConfigDAO configDao = new dao.SystemConfigDAO();
                int minCancellationMinutes = configDao.getMinCancellationMinutes();

                Booking oldBooking = bookDao.getBookingById(bookingId);
                if (oldBooking != null) {
                    java.time.LocalDateTime now = java.time.LocalDateTime.now();
                    // Do bookingDate và scheduledTime là Timestamp, nên gọi toLocalDateTime() trước.
                    java.time.LocalDateTime scheduledDateTime = java.time.LocalDateTime.of(oldBooking.getBookingDate().toLocalDateTime().toLocalDate(), oldBooking.getScheduledTime().toLocalDateTime().toLocalTime());
                    
                    // Nếu thời điểm "hiện tại + thời gian chuẩn bị hủy" đã đi qua mốc Lịch hẹn -> Chặn hủy
                    if (now.plusMinutes(minCancellationMinutes).isAfter(scheduledDateTime)) {
                        request.getSession().setAttribute("errorMessage", "Không thể hủy lịch trình quá sát giờ. (Ít nhất " + minCancellationMinutes + " phút trước lịch hẹn).");
                        response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                        return;
                    }
                }
                
                boolean success = bookDao.cancelBookingTransaction(bookingId, cus.getCustomerId());
                if (success) {
                    request.getSession().setAttribute("successMessage", "Hủy lịch thành công!");
                    response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                } else {
                    request.getSession().setAttribute("errorMessage", "Hủy lịch thất bại. Bạn chỉ có thể hủy các lịch đang chờ xử lý.");
                    response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMessage", "Lỗi hệ thống khi hủy lịch.");
                response.sendRedirect(request.getContextPath() + "/customer/booking_history");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/customer/booking_history");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
