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

@WebServlet(name = "AdminServiceServlet", urlPatterns = {"/admin/services"})
public class AdminServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
        String action = request.getParameter("action");
        ServiceDAO serviceDAO = new ServiceDAO();
        
        try {
            if ("create".equalsIgnoreCase(action)) {
                String name = request.getParameter("name");
                double basePrice = Double.parseDouble(request.getParameter("basePrice"));
                int duration = Integer.parseInt(request.getParameter("duration"));
                String serviceType = request.getParameter("serviceType");
                
                Service newService = new Service(0, name, basePrice, duration);
                newService.setServiceType(serviceType);
                
                serviceDAO.createServiceWithPrices(newService);
            } 
            else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("serviceId"));
                String name = request.getParameter("name");
                double basePrice = Double.parseDouble(request.getParameter("basePrice"));
                int duration = Integer.parseInt(request.getParameter("duration"));
                boolean isActive = request.getParameter("isActive") != null;
                String serviceType = request.getParameter("serviceType");
                
                Service editService = new Service(id, name, basePrice, duration, isActive, null, serviceType);
                
                serviceDAO.updateServiceWithPrices(editService);
            } 
            else if ("toggle".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("serviceId"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                serviceDAO.toggleServiceStatus(id, isActive);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Vui lòng nhập đúng định dạng số.");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/services");
    }
}