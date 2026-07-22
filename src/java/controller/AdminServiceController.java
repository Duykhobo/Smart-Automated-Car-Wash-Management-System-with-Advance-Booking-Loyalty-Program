package controller;

import dao.ServiceDAO;
import dto.Service;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.ValidationUtil;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AdminServiceController", urlPatterns = {"/admin/services"})
public class AdminServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        ServiceDAO serviceDAO = new ServiceDAO();
        try {
            List<Service> services = serviceDAO.getAllServicesForAdmin();
            request.setAttribute("serviceList", services);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách dịch vụ.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/manage_services.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        ServiceDAO serviceDAO = new ServiceDAO();
        
        Map<String, String> errors = new HashMap<>();

        try {
            if ("create".equalsIgnoreCase(action) || "update".equalsIgnoreCase(action)) {
                String name = request.getParameter("name");
                String basePriceStr = request.getParameter("basePrice");
                String durationStr = request.getParameter("duration");
                String serviceType = request.getParameter("serviceType");

                if (name == null || name.trim().isEmpty()) {
                    errors.put("name", "Tên dịch vụ không được để trống");
                } else if (name.length() > 100) {
                    errors.put("name", "Tên dịch vụ không được vượt quá 100 ký tự");
                }

                double basePrice = 0;
                if (basePriceStr == null || basePriceStr.trim().isEmpty()) {
                    errors.put("basePrice", "Giá cơ bản không được để trống");
                } else {
                    try {
                        basePrice = Double.parseDouble(basePriceStr);
                        if (basePrice < 0) errors.put("basePrice", "Giá cơ bản phải lớn hơn hoặc bằng 0");
                    } catch (NumberFormatException e) {
                        errors.put("basePrice", "Giá cơ bản không hợp lệ");
                    }
                }

                int duration = 0;
                if (durationStr == null || durationStr.trim().isEmpty()) {
                    errors.put("duration", "Thời gian không được để trống");
                } else {
                    try {
                        duration = Integer.parseInt(durationStr);
                        if (duration <= 0) errors.put("duration", "Thời gian phải lớn hơn 0 phút");
                    } catch (NumberFormatException e) {
                        errors.put("duration", "Thời gian không hợp lệ");
                    }
                }

                if (serviceType == null || serviceType.trim().isEmpty()) {
                    errors.put("serviceType", "Loại dịch vụ không được để trống");
                } else if (serviceType.length() > 30) {
                    errors.put("serviceType", "Loại dịch vụ không được vượt quá 30 ký tự");
                }

                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("errorMessage", "Vui lòng kiểm tra lại thông tin dịch vụ!");
                    request.setAttribute("action", action);
                    request.setAttribute("name", name);
                    request.setAttribute("basePrice", basePriceStr);
                    request.setAttribute("duration", durationStr);
                    request.setAttribute("serviceType", serviceType);
                    if ("update".equalsIgnoreCase(action)) {
                        request.setAttribute("serviceId", request.getParameter("serviceId"));
                    }
                    
                    // Reload list for JSP
                    try {
                        List<Service> services = serviceDAO.getAllServicesForAdmin();
                        request.setAttribute("serviceList", services);
                    } catch (Exception e) {}
                    
                    request.getRequestDispatcher("/WEB-INF/views/admin/manage_services.jsp").forward(request, response);
                    return;
                }
                
                if ("create".equalsIgnoreCase(action)) {
                    Service newService = new Service(0, name, basePrice, duration);
                    newService.setServiceType(serviceType);
                    serviceDAO.createServiceWithPrices(newService);
                    request.getSession().setAttribute("successMessage", "Đã thêm dịch vụ thành công!");
                } else {
                    int id = Integer.parseInt(request.getParameter("serviceId"));
                    boolean isActive = request.getParameter("isActive") != null;
                    Service editService = new Service(id, name, basePrice, duration, isActive, null, serviceType);
                    serviceDAO.updateServiceWithPrices(editService);
                    request.getSession().setAttribute("successMessage", "Đã cập nhật dịch vụ thành công!");
                }
            } 
            else if ("toggle".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("serviceId"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                serviceDAO.toggleServiceStatus(id, isActive);
                request.getSession().setAttribute("successMessage", "Đã thay đổi trạng thái dịch vụ!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/services");
    }
}
