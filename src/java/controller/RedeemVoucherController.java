package controller;

import dao.RewardCatalogDAO;
import dao.VoucherDAO;
import dto.Customer;
import dto.RewardCatalog;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AppConstants;

@WebServlet(name = "RedeemVoucherController", urlPatterns = {"/voucher/redeem"})
public class RedeemVoucherController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            int rewardId = Integer.parseInt(request.getParameter("rewardId"));
            
            // 1. Get Reward Info
            RewardCatalogDAO rewardDAO = new RewardCatalogDAO();
            RewardCatalog reward = rewardDAO.getRewardById(rewardId);
            
            if (reward == null || !reward.isIsActive()) {
                session.setAttribute(AppConstants.SESSION_MSG_ERROR, "Gói quà tặng không tồn tại hoặc đã hết hạn.");
                response.sendRedirect(request.getContextPath() + "/account/dashboard");
                return;
            }
            
            // 2. Get Customer ID
            dao.CustomerDAO cusDAO = new dao.CustomerDAO();
            Customer cus = cusDAO.getCustomerByAccountId(user.getUserId());
            
            if (cus == null) {
                session.setAttribute(AppConstants.SESSION_MSG_ERROR, "Không tìm thấy thông tin khách hàng.");
                response.sendRedirect(request.getContextPath() + "/account/dashboard");
                return;
            }
            
            // 3. Redeem
            VoucherDAO voucherDAO = new VoucherDAO();
            voucherDAO.redeemVoucher(cus.getCustomerId(), reward.getRewardType(), reward.getPointsCost());
            
            session.setAttribute(AppConstants.SESSION_MSG_SUCCESS, "Đổi mã " + reward.getRewardName() + " thành công!");
            
        } catch (Exception e) {
            session.setAttribute(AppConstants.SESSION_MSG_ERROR, "Đổi quà thất bại: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/account/dashboard");
    }
}
