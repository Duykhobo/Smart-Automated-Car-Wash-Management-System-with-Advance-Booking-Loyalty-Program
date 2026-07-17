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
                
                double priceSedan = Double.parseDouble(request.getParameter("priceSedan"));
                double priceSuv = Double.parseDouble(request.getParameter("priceSuv"));
                double priceXlarge = Double.parseDouble(request.getParameter("priceXlarge"));
                
                Service newService = new Service(0, name, basePrice, duration);
                newService.setPriceSedan(priceSedan);
                newService.setPriceSuv(priceSuv);
                newService.setPriceXlarge(priceXlarge);
                
                serviceDAO.createServiceWithPrices(newService);
            } 
            else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("serviceId"));
                String name = request.getParameter("name");
                double basePrice = Double.parseDouble(request.getParameter("basePrice"));
                int duration = Integer.parseInt(request.getParameter("duration"));
                boolean isActive = request.getParameter("isActive") != null;
                
                double priceSedan = Double.parseDouble(request.getParameter("priceSedan"));
                double priceSuv = Double.parseDouble(request.getParameter("priceSuv"));
                double priceXlarge = Double.parseDouble(request.getParameter("priceXlarge"));
                
                Service editService = new Service(id, name, basePrice, duration, isActive, null);
                editService.setPriceSedan(priceSedan);
                editService.setPriceSuv(priceSuv);
                editService.setPriceXlarge(priceXlarge);
                
                serviceDAO.updateServiceWithPrices(editService);
            } 
            else if ("toggle".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("serviceId"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                serviceDAO.toggleServiceStatus(id, isActive);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/services");
    }
}