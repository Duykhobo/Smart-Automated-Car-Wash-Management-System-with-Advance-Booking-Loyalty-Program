package controller;

import dao.BookingDAO;
import dto.Customer;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AppConstants;

@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/cancelBooking"})
public class CancelBookingServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CancelBookingServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Không cho phép hủy booking bằng phương thức GET
        response.sendRedirect(request.getContextPath() + "/account/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Bước 1: Lấy session hiện tại để xác định khách hàng đang đăng nhập
        HttpSession session = request.getSession(false);

        // Bước 2: Nếu chưa đăng nhập hoặc không có thông tin Customer thì chuyển về trang login
        if (session == null || session.getAttribute(AppConstants.SESSION_CUSTOMER_INFO) == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Bước 3: Lấy Customer từ session, không nhận customerId từ form để tránh giả mạo
        Customer customer = (Customer) session.getAttribute(AppConstants.SESSION_CUSTOMER_INFO);

        try {
            // Bước 4: Nhận mã booking mà khách hàng muốn hủy từ form
            String bookingIdRaw = request.getParameter("bookingId");
            int bookingId = Integer.parseInt(bookingIdRaw);

            // Bước 5: Booking ID phải là số nguyên dương
            if (bookingId <= 0) {
                throw new NumberFormatException();
            }

            // Bước 6: Gọi DAO để DB kiểm tra quyền sở hữu, trạng thái, trả slot và voucher
            BookingDAO dao = new BookingDAO();
            boolean success = dao.cancelBookingTransaction(bookingId, customer.getCustomerId());

            // Bước 7: Nếu DB không hủy được booking thì xử lý như một lỗi nghiệp vụ
            if (!success) {
                throw new Exception("Không thể hủy booking.");
            }

            // Bước 8: Xóa thông báo lỗi cũ và lưu thông báo thành công
            session.removeAttribute("errorMessage");
            session.setAttribute("successMessage", "Hủy lịch thành công!");

        } catch (NumberFormatException e) {
            // Booking ID bị thiếu, không phải số hoặc không hợp lệ
            session.removeAttribute("successMessage");
            session.setAttribute("errorMessage", "Mã lịch đặt không hợp lệ!");

        } catch (Exception e) {
            // Stored Procedure từ chối hủy hoặc xảy ra lỗi database
            LOGGER.log(Level.SEVERE, "Cancel booking failed", e);
            session.removeAttribute("successMessage");
            session.setAttribute("errorMessage", "Không thể hủy lịch đặt!");
        }

        // Bước 9: Quay về dashboard và tránh gửi lại request POST khi refresh
        response.sendRedirect(request.getContextPath() + "/account/dashboard");
    }
}