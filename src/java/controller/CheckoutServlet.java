package controller;

import dao.BookingDAO;
import dao.CustomerDAO;
import dao.ServiceDAO;
import dto.Customer;
import dto.Service;
import dto.User;
import dto.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.AppConstants;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Xác thực trạng thái đăng nhập
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            sendErrorResponse(request, response, "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại.");
            return;
        }

        try {
            // 2. Lấy thông tin khách hàng từ DB
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByAccountId(user.getUserId());
            if (customer == null) {
                sendErrorResponse(request, response, "Không tìm thấy thông tin khách hàng trên hệ thống.");
                return;
            }

            // 3. Nhận các tham số đặt lịch từ Frontend
            String vehicleIdStr = request.getParameter("vehicleId");
            String serviceIdStr = request.getParameter("serviceId");
            if (serviceIdStr == null) {
                serviceIdStr = request.getParameter("service"); // Dự phòng trường hợp thẻ select tên là "service"
            }
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");
            String voucherCode = request.getParameter("voucherCode");

            if (vehicleIdStr == null || serviceIdStr == null || dateStr == null || timeStr == null) {
                sendErrorResponse(request, response, "Thông tin đặt lịch không đầy đủ. Vui lòng kiểm tra lại.");
                return;
            }
            if (timeStr.length() == 5) { // Chỉ có HH:mm
                timeStr += ":00";
            }
            Time scheduledTime = Time.valueOf(LocalTime.parse(timeStr));
            int vehicleId = Integer.parseInt(vehicleIdStr);
            int serviceId = Integer.parseInt(serviceIdStr);
            Date bookingDate = Date.valueOf(LocalDate.parse(dateStr));

            // 4. Lấy thông tin gói dịch vụ từ DB để xác định giá gốc
            ServiceDAO serviceDAO = new ServiceDAO();
            Service selectedService = serviceDAO.getServiceById(serviceId);
            if (selectedService == null) {
                sendErrorResponse(request, response, "Dịch vụ đã chọn không hợp lệ.");
                return;
            }

            double originalPrice = selectedService.getBasePrice();
            double discountAmount = 0.0;
            Integer voucherId = null;
            BookingDAO bookingDAO = new BookingDAO();
            // 5. Kiểm tra và áp dụng Voucher giảm giá nếu khách hàng có điền
            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                
                Voucher voucher = bookingDAO.getActiveVoucherByCode(voucherCode.trim(), customer.getCustomerId());
                
                if (voucher == null) {
                    sendErrorResponse(request, response, "Mã Voucher không hợp lệ hoặc đã hết hạn sử dụng.");
                    return;
                }
                
                voucherId = voucher.getVoucherId();
                String rewardType = voucher.getRewardType();

                // Áp dụng luật giảm giá theo đặc tả hệ thống
                if ("DISCOUNT_10".equalsIgnoreCase(rewardType)) {
                    // Giảm giá 10% cho lần rửa tiếp theo (tối đa 50,000 VND)
                    discountAmount = originalPrice * 0.10;
                    if (discountAmount > 50000) {
                        discountAmount = 50000;
                    }
                } else if ("FREE_WAX".equalsIgnoreCase(rewardType)) {
                    // Voucher phủ sáp Wax miễn phí (tối đa 150,000 VND)
                    discountAmount = Math.min(originalPrice, 150000);
                } else if ("FREE_WASH".equalsIgnoreCase(rewardType)) {
                    // Voucher rửa xe gói Tiêu chuẩn miễn phí (tối đa 200,000 VND)
                    discountAmount = Math.min(originalPrice, 200000);
                }
            }

            double finalPrice = originalPrice - discountAmount;
            if (finalPrice < 0) {
                finalPrice = 0;
            }

            // 6. Thực thi Booking Transaction
            boolean success = bookingDAO.createBookingTransaction(
                    customer.getCustomerId(),
                    serviceId,
                    vehicleId,
                    voucherId,
                    bookingDate,
                    scheduledTime,
                    originalPrice,
                    discountAmount,
                    finalPrice
            );

            if (success) {
                sendSuccessResponse(request, response, "Đặt lịch thành công!");
            } else {
                sendErrorResponse(request, response, "Hệ thống không thể lưu lịch đặt của bạn lúc này.");
            }

        } catch (NumberFormatException e) {
            sendErrorResponse(request, response, "Định dạng dữ liệu đầu vào không hợp lệ.");
        } catch (Exception ex) {
            // QUAN TRỌNG: Bẫy lỗi và bắt chuỗi lỗi cụ thể từ Stored Procedure văng ra
            // Ví dụ: "Khung giờ này đã đầy, vui lòng chọn giờ khác."
            LOGGER.log(Level.SEVERE, "Lỗi xảy ra trong quá trình thực hiện Checkout:", ex);
            
            String errMsg = ex.getMessage();
            if (errMsg == null || errMsg.trim().isEmpty()) {
                errMsg = "Lỗi hệ thống khi tạo lịch đặt.";
            }
            
            // Trả lỗi ngược về phía giao diện (Frontend)
            sendErrorResponse(request, response, errMsg);
        }
    }

    /**
     * Gửi phản hồi lỗi về Frontend. Hỗ trợ tự động chuyển đổi JSON (nếu là AJAX) hoặc Redirect (nếu là Form submit thường).
     */
    private void sendErrorResponse(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        
        String acceptHeader = request.getHeader("Accept");
        String requestedWith = request.getHeader("X-Requested-With");
        
        if ((acceptHeader != null && acceptHeader.contains("application/json")) 
                || "XMLHttpRequest".equals(requestedWith)) {
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"success\": false, \"message\": \"" + escapeJson(message) + "\"}");
                out.flush();
            }
        } else {
            request.getSession().setAttribute("errorMessage", message);
            response.sendRedirect(request.getContextPath() + "/BookingController");
        }
    }

    /**
     * Gửi phản hồi thành công về Frontend.
     */
    private void sendSuccessResponse(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        
        String acceptHeader = request.getHeader("Accept");
        String requestedWith = request.getHeader("X-Requested-With");
        
        if ((acceptHeader != null && acceptHeader.contains("application/json")) 
                || "XMLHttpRequest".equals(requestedWith)) {
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"success\": true, \"message\": \"" + escapeJson(message) + "\"}");
                out.flush();
            }
        } else {
            request.getSession().setAttribute("successMessage", message);
            response.sendRedirect(request.getContextPath() + "/account/dashboard");
        }
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}