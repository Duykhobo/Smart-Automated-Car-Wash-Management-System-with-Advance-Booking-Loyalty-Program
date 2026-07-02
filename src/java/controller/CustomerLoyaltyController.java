package controller;

import dao.CustomerDAO;
import dao.RewardCatalogDAO;
import dao.VoucherDAO;
import dto.Customer;
import dto.RewardCatalog;
import dto.User;
import dto.Voucher;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AppConstants;

@WebServlet(name = "CustomerLoyaltyController", urlPatterns = {"/customer/loyalty"})
public class CustomerLoyaltyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            // 1. Fetch Customer Info
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByAccountId(user.getUserId());
            
            if (customer == null) {
                session.setAttribute(AppConstants.SESSION_MSG_ERROR, "Không tìm thấy thông tin khách hàng.");
                response.sendRedirect(request.getContextPath() + "/account/dashboard");
                return;
            }
            
            // 2. Fetch Active Rewards
            RewardCatalogDAO rewardDAO = new RewardCatalogDAO();
            List<RewardCatalog> activeRewards = rewardDAO.getAllActiveRewards();
            
            // 3. Fetch User's Vouchers
            VoucherDAO voucherDAO = new VoucherDAO();
            List<Voucher> userVouchers = voucherDAO.getAvailableVouchers(customer.getCustomerId());
            
            request.setAttribute("customer", customer);
            request.setAttribute("activeRewards", activeRewards);
            request.setAttribute("userVouchers", userVouchers);
            
            request.getRequestDispatcher("/WEB-INF/views/customer/customer_loyalty.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute(AppConstants.SESSION_MSG_ERROR, "Đã xảy ra lỗi khi tải dữ liệu loyalty: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/account/dashboard");
        }
    }
}
