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
import java.util.HashMap;
import dao.SystemConfigDAO;

/**
 * AdminConfigServlet điều hướng trang Cấu Hình Hệ Thống.
 */
@WebServlet(name = "AdminConfigController", urlPatterns = {"/admin/config"})
public class AdminConfigController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
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
        response.setContentType("text/html; charset=UTF-8");
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
        
        String vehicleMultiplierSedan = request.getParameter("VehicleMultiplier_SEDAN");
        String vehicleMultiplierSuv = request.getParameter("VehicleMultiplier_SUV");
        String vehicleMultiplierXlarge = request.getParameter("VehicleMultiplier_XLARGE");
        
        Map<String, String> errors = new HashMap<>();

        // Valdation 
        if (openingHour != null && !openingHour.isEmpty()) {
            try {
                int oh = Integer.parseInt(openingHour.substring(0, 2));
                if (oh < 0 || oh > 23) errors.put("OpeningHour", "Giờ mở cửa phải từ 0-23");
            } catch (Exception e) { errors.put("OpeningHour", "Giờ mở cửa không hợp lệ"); }
        }
        
        if (closingHour != null && !closingHour.isEmpty()) {
            try {
                int ch = Integer.parseInt(closingHour.substring(0, 2));
                if (ch < 0 || ch > 23) errors.put("ClosingHour", "Giờ đóng cửa phải từ 0-23");
            } catch (Exception e) { errors.put("ClosingHour", "Giờ đóng cửa không hợp lệ"); }
        }
        
        if (maxSlotCapacity != null && !maxSlotCapacity.isEmpty()) {
            try {
                int cap = Integer.parseInt(maxSlotCapacity);
                if (cap < 1) errors.put("MaxSlotCapacity", "Số xe/khung giờ tối thiểu là 1");
            } catch (NumberFormatException e) { errors.put("MaxSlotCapacity", "Không hợp lệ"); }
        }
        
        if (gracePeriod != null && !gracePeriod.isEmpty()) {
            try {
                int gp = Integer.parseInt(gracePeriod);
                if (gp < 0) errors.put("GracePeriodMinutes", "Thời gian trễ không được âm");
            } catch (NumberFormatException e) { errors.put("GracePeriodMinutes", "Không hợp lệ"); }
        }
        
        try {
            if (multiplierSilver != null && !multiplierSilver.isEmpty() && Double.parseDouble(multiplierSilver) < 1.0) errors.put("Multiplier_Silver", "Hệ số >= 1.0");
            if (multiplierGold != null && !multiplierGold.isEmpty() && Double.parseDouble(multiplierGold) < 1.0) errors.put("Multiplier_Gold", "Hệ số >= 1.0");
            if (multiplierPlatinum != null && !multiplierPlatinum.isEmpty() && Double.parseDouble(multiplierPlatinum) < 1.0) errors.put("Multiplier_Platinum", "Hệ số >= 1.0");
            
            if (vehicleMultiplierSedan != null && !vehicleMultiplierSedan.isEmpty() && Double.parseDouble(vehicleMultiplierSedan) < 1.0) errors.put("VehicleMultiplier_SEDAN", "Hệ số >= 1.0");
            if (vehicleMultiplierSuv != null && !vehicleMultiplierSuv.isEmpty() && Double.parseDouble(vehicleMultiplierSuv) < 1.0) errors.put("VehicleMultiplier_SUV", "Hệ số >= 1.0");
            if (vehicleMultiplierXlarge != null && !vehicleMultiplierXlarge.isEmpty() && Double.parseDouble(vehicleMultiplierXlarge) < 1.0) errors.put("VehicleMultiplier_XLARGE", "Hệ số >= 1.0");
        } catch (NumberFormatException e) {
            errors.put("System", "Một số hệ số không hợp lệ");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("errorMessage", "Vui lòng kiểm tra lại các thông tin cấu hình");
            
            // Re-populate submitted values so user doesn't lose them
            Map<String, String> configs = new HashMap<>();
            configs.put("OpeningHour", openingHour);
            configs.put("ClosingHour", closingHour);
            configs.put("MaxSlotCapacity", maxSlotCapacity);
            configs.put("GracePeriodMinutes", gracePeriod);
            configs.put("PointsPerCurrencyUnit", pointsPerCurrencyUnit);
            configs.put("Multiplier_Silver", multiplierSilver);
            configs.put("Multiplier_Gold", multiplierGold);
            configs.put("Multiplier_Platinum", multiplierPlatinum);
            configs.put("MaintenanceMode", maintenanceMode);
            configs.put("VehicleMultiplier_SEDAN", vehicleMultiplierSedan);
            configs.put("VehicleMultiplier_SUV", vehicleMultiplierSuv);
            configs.put("VehicleMultiplier_XLARGE", vehicleMultiplierXlarge);
            
            request.setAttribute("configs", configs);
            request.getRequestDispatcher("/WEB-INF/views/admin/manage_config.jsp").forward(request, response);
            return;
        }

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
                try { configDAO.updateTierMultiplier("Silver", Double.parseDouble(multiplierSilver) - 1.0); } catch(Exception e){}
            }
            if (multiplierGold != null && !multiplierGold.isEmpty()) {
                configDAO.updateConfigValue("Multiplier_Gold", multiplierGold);
                try { configDAO.updateTierMultiplier("Gold", Double.parseDouble(multiplierGold) - 1.0); } catch(Exception e){}
            }
            if (multiplierPlatinum != null && !multiplierPlatinum.isEmpty()) {
                configDAO.updateConfigValue("Multiplier_Platinum", multiplierPlatinum);
                try { configDAO.updateTierMultiplier("Platinum", Double.parseDouble(multiplierPlatinum) - 1.0); } catch(Exception e){}
            }
            configDAO.updateConfigValue("MaintenanceMode", maintenanceMode);
            
            boolean priceChanged = false;
            if (vehicleMultiplierSedan != null && !vehicleMultiplierSedan.isEmpty()) {
                configDAO.updateConfigValue("VehicleMultiplier_SEDAN", vehicleMultiplierSedan);
                priceChanged = true;
            }
            if (vehicleMultiplierSuv != null && !vehicleMultiplierSuv.isEmpty()) {
                configDAO.updateConfigValue("VehicleMultiplier_SUV", vehicleMultiplierSuv);
                priceChanged = true;
            }
            if (vehicleMultiplierXlarge != null && !vehicleMultiplierXlarge.isEmpty()) {
                configDAO.updateConfigValue("VehicleMultiplier_XLARGE", vehicleMultiplierXlarge);
                priceChanged = true;
            }
            
            if (priceChanged) {
                dao.ServiceDAO serviceDao = new dao.ServiceDAO();
                serviceDao.syncAllServicePrices();
            }
            
            request.getSession().setAttribute("successMessage", "Đã lưu cấu hình hệ thống thành công.");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Lỗi khi lưu cấu hình: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/config");
    }
}
