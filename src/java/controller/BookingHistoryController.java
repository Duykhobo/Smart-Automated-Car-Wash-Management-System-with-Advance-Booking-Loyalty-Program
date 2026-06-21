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
 *
 * @author thien
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
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
                        String tierName = "Member";
                        int maxBookingDays = 7;
                        String badgeClass = "badge-member";
                        String bannerBorder = "border-slate-500";
                        String bannerBg = "bg-slate-500/20";
                        String bannerIcon = "text-slate-500";
                        String bannerText = "text-slate-400";
                        
                        if ("SILVER".equalsIgnoreCase(tierStatus)) {
                            tierName = "Silver";
                            maxBookingDays = 10;
                            badgeClass = "badge-silver";
                            bannerBorder = "border-slate-400";
                            bannerBg = "bg-slate-400/20";
                            bannerIcon = "text-slate-400";
                            bannerText = "text-slate-300";
                        } else if ("GOLD".equalsIgnoreCase(tierStatus)) {
                            tierName = "Gold";
                            maxBookingDays = 12;
                            badgeClass = "badge-gold";
                            bannerBorder = "border-amber-500";
                            bannerBg = "bg-amber-500/20";
                            bannerIcon = "text-amber-500";
                            bannerText = "text-amber-400";
                        } else if ("PLATINUM".equalsIgnoreCase(tierStatus)) {
                            tierName = "Platinum";
                            maxBookingDays = 14;
                            badgeClass = "badge-platinum";
                            bannerBorder = "border-[#00d4ff]";
                            bannerBg = "bg-[#00d4ff]/20";
                            bannerIcon = "text-[#00d4ff]";
                            bannerText = "text-cyan-400";
                        }
                        
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

                        // Generate time slots (08:00 to 17:00)
                        List<String> timeSlots = new ArrayList<>();
                        for (int i = 8; i <= 17; i++) {
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

                // Server-side validation: Check if selected time is in the past
                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                java.time.LocalDate newLocalDate = newDate.toLocalDate();
                java.time.LocalTime newLocalTime = newTime.toLocalTime();
                if (newLocalDate.isBefore(now.toLocalDate()) || 
                   (newLocalDate.isEqual(now.toLocalDate()) && newLocalTime.isBefore(now.toLocalTime()))) {
                    throw new Exception("Không thể cập nhật lịch hẹn vào khung giờ đã trôi qua!");
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
                            bookingId, vehicleId, serviceId,
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
