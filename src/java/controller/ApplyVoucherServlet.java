package controller;

import dao.BookingDAO;
import dto.Customer;
import dto.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AppConstants;

@WebServlet(name = "ApplyVoucherServlet", urlPatterns = {"/api/apply-voucher"})
public class ApplyVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute(AppConstants.SESSION_CUSTOMER_INFO) == null) {
                out.print("{\"valid\": false, \"message\": \"Vui lòng đăng nhập để sử dụng Voucher.\"}");
                return;
            }

            Customer cus = (Customer) session.getAttribute(AppConstants.SESSION_CUSTOMER_INFO);
            String voucherCode = request.getParameter("code");

            if (voucherCode == null || voucherCode.trim().isEmpty()) {
                out.print("{\"valid\": false, \"message\": \"Vui lòng nhập mã Voucher.\"}");
                return;
            }

            BookingDAO dao = new BookingDAO();
            Voucher voucher = dao.getActiveVoucherByCode(voucherCode.trim(), cus.getCustomerId());

            if (voucher == null) {
                out.print("{\"valid\": false, \"message\": \"Mã Voucher không hợp lệ hoặc đã hết hạn.\"}");
            } else {
                // Voucher is valid
                out.print("{\"valid\": true, \"rewardType\": \"" + voucher.getRewardType() + "\", \"message\": \"Áp dụng Voucher thành công!\"}");
            }
        } catch (Exception ex) {
            Logger.getLogger(ApplyVoucherServlet.class.getName()).log(Level.SEVERE, null, ex);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"valid\": false, \"message\": \"Lỗi hệ thống: " + ex.getMessage() + "\"}");
            }
        }
    }
}
