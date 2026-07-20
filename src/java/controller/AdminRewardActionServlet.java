package controller;

import dao.RewardCatalogDAO;
import dto.RewardCatalog;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminRewardActionServlet", urlPatterns = {"/admin/loyalty/reward"})
public class AdminRewardActionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        RewardCatalogDAO dao = new RewardCatalogDAO();
        
        try {
            if ("add".equals(action)) {
                String rewardName = request.getParameter("rewardName");
                String description = request.getParameter("description");
                String rewardType = request.getParameter("rewardType");
                int pointsCost = Integer.parseInt(request.getParameter("pointsCost"));
                double discountPercent = 0;
                try {
                    discountPercent = Double.parseDouble(request.getParameter("discountPercent"));
                } catch (Exception e) {}
                String imageIcon = request.getParameter("imageIcon");
                
                // Set default icon if empty
                if (imageIcon == null || imageIcon.trim().isEmpty()) {
                    imageIcon = "ticket"; // lucide icon default
                }
                
                RewardCatalog newReward = new RewardCatalog(0, rewardName, description, pointsCost, rewardType, imageIcon, true, null, null, discountPercent);
                dao.addReward(newReward);
                
                session.setAttribute("toastMessage", "success|Đã tạo Voucher mới thành công!");
            } else if ("edit".equals(action)) {
                int rewardId = Integer.parseInt(request.getParameter("rewardId"));
                String rewardName = request.getParameter("rewardName");
                String description = request.getParameter("description");
                String rewardType = request.getParameter("rewardType");
                int pointsCost = Integer.parseInt(request.getParameter("pointsCost"));
                double discountPercent = 0;
                try {
                    discountPercent = Double.parseDouble(request.getParameter("discountPercent"));
                } catch (Exception e) {}
                String imageIcon = request.getParameter("imageIcon");
                
                if (imageIcon == null || imageIcon.trim().isEmpty()) {
                    imageIcon = "ticket";
                }
                
                RewardCatalog updatedReward = new RewardCatalog(rewardId, rewardName, description, pointsCost, rewardType, imageIcon, true, null, null, discountPercent);
                dao.updateReward(updatedReward);
                
                session.setAttribute("toastMessage", "success|Đã cập nhật Voucher thành công!");
                
            } else if ("toggle".equals(action)) {
                int rewardId = Integer.parseInt(request.getParameter("rewardId"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                
                dao.toggleRewardStatus(rewardId, isActive);
                
                session.setAttribute("toastMessage", "success|Đã thay đổi trạng thái Voucher!");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "error|" + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/loyalty");
    }
}
