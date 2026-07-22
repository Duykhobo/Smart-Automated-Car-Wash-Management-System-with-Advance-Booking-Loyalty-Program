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
import java.util.HashMap;
import java.util.Map;
import utils.ValidationUtil;

@WebServlet(name = "AdminRewardActionController", urlPatterns = {"/admin/loyalty/reward"})
public class AdminRewardActionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        RewardCatalogDAO dao = new RewardCatalogDAO();
        
        try {
            if ("add".equals(action) || "edit".equals(action)) {
                String rewardIdStr = request.getParameter("rewardId");
                String rewardName = request.getParameter("rewardName");
                String description = request.getParameter("description");
                String rewardType = request.getParameter("rewardType");
                String pointsCostStr = request.getParameter("pointsCost");
                String discountPercentStr = request.getParameter("discountPercent");
                String imageIcon = request.getParameter("imageIcon");
                
                Map<String, String> errors = new HashMap<>();
                
                if (rewardName == null || rewardName.trim().isEmpty()) {
                    errors.put("rewardName", "Tên phần thưởng không được để trống");
                } else if (!ValidationUtil.isValidRewardName(rewardName)) {
                    errors.put("rewardName", "Tên phần thưởng không hợp lệ");
                }
                
                if (rewardType != null && !rewardType.trim().isEmpty() && !ValidationUtil.isValidRewardType(rewardType)) {
                    errors.put("rewardType", "Mã phân loại không hợp lệ");
                }
                
                int pointsCost = 0;
                if (pointsCostStr == null || pointsCostStr.trim().isEmpty()) {
                    errors.put("pointsCost", "Điểm đổi không được để trống");
                } else {
                    try {
                        pointsCost = Integer.parseInt(pointsCostStr);
                        if (pointsCost < 0) errors.put("pointsCost", "Điểm đổi không được âm");
                    } catch (NumberFormatException e) {
                        errors.put("pointsCost", "Điểm đổi không hợp lệ");
                    }
                }
                
                double discountPercent = 0;
                if (discountPercentStr != null && !discountPercentStr.trim().isEmpty()) {
                    try {
                        discountPercent = Double.parseDouble(discountPercentStr);
                        if (discountPercent < 0 || discountPercent > 100) errors.put("discountPercent", "Phần trăm giảm giá phải từ 0-100");
                    } catch (NumberFormatException e) {
                        errors.put("discountPercent", "Phần trăm giảm giá không hợp lệ");
                    }
                }
                
                if (imageIcon == null || imageIcon.trim().isEmpty()) {
                    imageIcon = "ticket";
                }
                
                if (!errors.isEmpty()) {
                    session.setAttribute("errors", errors);
                    session.setAttribute("toastMessage", "error|Vui lòng kiểm tra lại thông tin phần thưởng!");
                    
                    // PRG Sticky form fallback
                    Map<String, String> formValues = new HashMap<>();
                    formValues.put("rewardId", rewardIdStr);
                    formValues.put("rewardName", rewardName);
                    formValues.put("description", description);
                    formValues.put("rewardType", rewardType);
                    formValues.put("pointsCost", pointsCostStr);
                    formValues.put("discountPercent", discountPercentStr);
                    formValues.put("imageIcon", imageIcon);
                    session.setAttribute("formValues", formValues);
                    session.setAttribute("activeModal", "edit".equals(action) ? "editRewardModal" : "addRewardModal");
                    
                    response.sendRedirect(request.getContextPath() + "/admin/loyalty");
                    return;
                }
                
                if ("add".equals(action)) {
                    RewardCatalog newReward = new RewardCatalog(0, rewardName, description, pointsCost, rewardType, imageIcon, true, null, null, discountPercent);
                    dao.addReward(newReward);
                    session.setAttribute("toastMessage", "success|Đã tạo Voucher mới thành công!");
                } else {
                    int rewardId = Integer.parseInt(rewardIdStr);
                    RewardCatalog updatedReward = new RewardCatalog(rewardId, rewardName, description, pointsCost, rewardType, imageIcon, true, null, null, discountPercent);
                    dao.updateReward(updatedReward);
                    session.setAttribute("toastMessage", "success|Đã cập nhật Voucher thành công!");
                }
                
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
