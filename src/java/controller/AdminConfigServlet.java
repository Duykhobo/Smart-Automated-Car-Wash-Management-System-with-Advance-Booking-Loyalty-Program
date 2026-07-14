package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SystemConfigDAO;
import java.util.Map;

/**
 * AdminConfigServlet điều hướng trang Cấu Hình Hệ Thống.
 */
@WebServlet(name = "AdminConfigServlet", urlPatterns = {"/admin/config"})
public class AdminConfigServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SystemConfigDAO d = new SystemConfigDAO();
            Map<String, String> config = d.getAllConfigs();
            request.setAttribute("config", config);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/manage_config.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SystemConfigDAO d = new SystemConfigDAO();

            String openingHour = request.getParameter("OpeningHour");
            if (openingHour != null && openingHour.contains(":")) {
                String hour = String.valueOf(Integer.parseInt(openingHour.split(":")[0]));
                d.updateConfigValue("OpeningHour", hour);
            }
            
            String closingHour = request.getParameter("ClosingHour");
            if(closingHour != null && closingHour.contains(":")){
                String closed = String.valueOf(Integer.parseInt(closingHour.split(":")[0]));
                d.updateConfigValue("ClosingHour", closed);
            }
            
            String maxCapacity = request.getParameter("MaxCapacity");
            if(maxCapacity != null) d.updateConfigValue("MaxCapacity", maxCapacity);
            
            String gracePeriod = request.getParameter("GracePeriod");
            if(gracePeriod != null) d.updateConfigValue("GracePeriod", gracePeriod);
            
            String pointPerCurrencyUnit = request.getParameter("PointsPerCurrencyUnit");
            if(pointPerCurrencyUnit != null) d.updateConfigValue("PointsPerCurrencyUnit", pointPerCurrencyUnit);
            
            String silverMultiplier = request.getParameter("SilverMultiplier");
            if(silverMultiplier != null) d.updateConfigValue("SilverMultiplier", silverMultiplier);
            
            String goldMultiplier = request.getParameter("GoldMultiplier");
            if(goldMultiplier != null) d.updateConfigValue("GoldMultiplier", goldMultiplier);
            
            String platinumMultiplier = request.getParameter("PlatinumMultiplier");
            if(platinumMultiplier != null) d.updateConfigValue("PlatinumMultiplier", platinumMultiplier);
            
            String MaintenanceMode = request.getParameter("MaintenanceMode");
            if(MaintenanceMode != null){
                d.updateConfigValue("MaintenanceMode", "on");
            }else{
                d.updateConfigValue("MaintenanceMode", "off");
            }
            
            request.getSession().setAttribute("SUCCESS", "Cập nhật cấu hình thành công");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Lỗi cập nhật cấu hình");
        }
        response.sendRedirect(request.getContextPath() + "/admin/config");
    }
}
