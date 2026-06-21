package controller;

import dao.VoucherDAO;
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

@WebServlet(name = "RedeemVoucherServlet", urlPatterns = { "/redeemVoucher" })
public class RedeemVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/customer/loyalty");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute(AppConstants.SESSION_CUSTOMER_INFO) == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            Customer cus = (Customer) session.getAttribute(AppConstants.SESSION_CUSTOMER_INFO);
            int customerID = cus.getCustomerId();

            String rewardType = request.getParameter("rewardType");

            if (rewardType == null || rewardType.trim().isEmpty()) {
                throw new Exception("Loại voucher không hợp lệ.");
            }

            int pointsCost = Integer.parseInt(request.getParameter("pointsCost"));

            if (pointsCost <= 0) {
                throw new Exception("Số điểm đổi voucher không hợp lệ.");
            }

            VoucherDAO dao = new VoucherDAO();
            dao.redeemVoucher(customerID, rewardType, pointsCost);
            cus.setPointsBalance(cus.getPointsBalance() - pointsCost);

            session.setAttribute(AppConstants.SESSION_CUSTOMER_INFO, cus);
            session.setAttribute("successMessage", "Đổi Voucher thành công!");
            response.sendRedirect(request.getContextPath() + "/customer/loyalty");
            return;

        } catch (NumberFormatException e) {
            Logger.getLogger(RedeemVoucherServlet.class.getName()).log(Level.SEVERE, null, e);

            session.setAttribute("errorMessage", "Số điểm đổi Voucher không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/customer/loyalty");
            return;

        } catch (Exception e) {
            Logger.getLogger(RedeemVoucherServlet.class.getName()).log(Level.SEVERE, null, e);

            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/customer/loyalty");
            return;
        }
    }

    @Override
    public String getServletInfo() {
        return "Redeem Voucher Servlet";
    }
}