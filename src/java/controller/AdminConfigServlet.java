package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SystemConfigDAO;
import java.util.Map;

import java.sql.SQLException;
import java.util.Map;
import java.util.List;
import dao.SystemConfigDAO;

/**
 * AdminConfigServlet điều hướng trang Cấu Hình Hệ Thống.
 */
@WebServlet(name = "AdminConfigServlet", urlPatterns = {"/admin/config"})
public class AdminConfigServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        SystemConfigDAO configDAO = new SystemConfigDAO();
        dao.MemberTierDAO tierDAO = new dao.MemberTierDAO();
        try {
            Map<String, String> configs = configDAO.getAllConfigs();
            
            // Lấy dữ liệu thật từ bảng MemberTiers để hiển thị lên UI cho chính xác
            List<dto.MemberTier> tiers = tierDAO.getAllTiers();
            for (dto.MemberTier t : tiers) {
                if (t.getTierName().equals("Silver")) {
                    configs.put("Multiplier_Silver", String.valueOf(t.getPointsModifier() + 1.0));
                } else if (t.getTierName().equals("Gold")) {
                    configs.put("Multiplier_Gold", String.valueOf(t.getPointsModifier() + 1.0));
                } else if (t.getTierName().equals("Platinum")) {
                    configs.put("Multiplier_Platinum", String.valueOf(t.getPointsModifier() + 1.0));
                }
            }
            
            request.setAttribute("configs", configs);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Không thể tải cấu hình hệ thống: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/manage_config.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        SystemConfigDAO configDAO = new SystemConfigDAO();
        
        String openingHour = request.getParameter("OpeningHour");
        String closingHour = request.getParameter("ClosingHour");
        String maxSlotCapacity = request.getParameter("MaxSlotCapacity");
        String gracePeriod = request.getParameter("GracePeriodMinutes");
        String pointsPerCurrencyUnit = request.getParameter("PointsPerCurrencyUnit");
        String multiplierSilver = request.getParameter("Multiplier_Silver");
        String multiplierGold = request.getParameter("Multiplier_Gold");
        String multiplierPlatinum = request.getParameter("Multiplier_Platinum");
        String maintenanceMode = request.getParameter("MaintenanceMode") != null ? "true" : "false";

        try {
            if (openingHour != null && !openingHour.isEmpty()) configDAO.updateConfigValue("OpeningHour", openingHour.substring(0, 2));
            if (closingHour != null && !closingHour.isEmpty()) configDAO.updateConfigValue("ClosingHour", closingHour.substring(0, 2));
            if (maxSlotCapacity != null && !maxSlotCapacity.isEmpty()) {
                configDAO.updateConfigValue("MaxSlotCapacity", maxSlotCapacity);
                try {
                    configDAO.updateFutureSlotCapacities(Integer.parseInt(maxSlotCapacity));
                } catch (NumberFormatException ignored) {}
            }
            if (gracePeriod != null && !gracePeriod.isEmpty()) configDAO.updateConfigValue("GracePeriodMinutes", gracePeriod);
            if (pointsPerCurrencyUnit != null && !pointsPerCurrencyUnit.isEmpty()) configDAO.updateConfigValue("PointsPerCurrencyUnit", pointsPerCurrencyUnit);
            if (multiplierSilver != null && !multiplierSilver.isEmpty()) {
                configDAO.updateConfigValue("Multiplier_Silver", multiplierSilver);
                try { configDAO.updateTierMultiplier("Silver", Double.parseDouble(multiplierSilver)); } catch(Exception e){}
            }
            if (multiplierGold != null && !multiplierGold.isEmpty()) {
                configDAO.updateConfigValue("Multiplier_Gold", multiplierGold);
                try { configDAO.updateTierMultiplier("Gold", Double.parseDouble(multiplierGold)); } catch(Exception e){}
            }
            if (multiplierPlatinum != null && !multiplierPlatinum.isEmpty()) {
                configDAO.updateConfigValue("Multiplier_Platinum", multiplierPlatinum);
                try { configDAO.updateTierMultiplier("Platinum", Double.parseDouble(multiplierPlatinum)); } catch(Exception e){}
            }
            configDAO.updateConfigValue("MaintenanceMode", maintenanceMode);
            
            request.getSession().setAttribute("successMessage", "Đã lưu cấu hình hệ thống thành công.");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi khi lưu cấu hình: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/config");
    }
}
