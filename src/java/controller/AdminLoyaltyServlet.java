package controller;

import dao.MemberTierDAO;
import dao.RewardCatalogDAO;
import dto.MemberTier;
import dto.RewardCatalog;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminLoyaltyServlet", urlPatterns = {"/admin/loyalty"})
public class AdminLoyaltyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        RewardCatalogDAO catalogDAO = new RewardCatalogDAO();
        MemberTierDAO tierDAO = new MemberTierDAO();
        try {
            List<RewardCatalog> list = catalogDAO.getAllRewardsForAdmin();
            List<MemberTier> tiers = tierDAO.getAllTiers();
            int activeVouchersCount = catalogDAO.getActiveVouchersCount();
            int redemptionsThisMonth = catalogDAO.getRedemptionsThisMonth();
            int totalPointsSpent = catalogDAO.getTotalPointsSpent();
            
            request.setAttribute("rewardList", list);
            request.setAttribute("tierList", tiers);
            request.setAttribute("activeVouchersCount", activeVouchersCount);
            request.setAttribute("redemptionsThisMonth", redemptionsThisMonth);
            request.setAttribute("totalPointsSpent", totalPointsSpent);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/manage_loyalty.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        MemberTierDAO tierDAO = new MemberTierDAO();
        
        if ("update_tier".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("tierId"));
                int minWashes = Integer.parseInt(request.getParameter("minWashes"));
                double minSpend = Double.parseDouble(request.getParameter("minSpend"));
                double modifier = Double.parseDouble(request.getParameter("pointsModifier"));
                int maxBookingDays = Integer.parseInt(request.getParameter("maxBookingDays"));
                
                MemberTier tier = new MemberTier(id, null, minWashes, minSpend, modifier, 0, maxBookingDays, null, null, null, null, null);
                boolean success = tierDAO.updateMemberTier(tier);
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Cập nhật hạng thành viên thành công!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Cập nhật hạng thành viên thất bại.");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Vui lòng nhập đúng định dạng số.");
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/loyalty");
    }
}