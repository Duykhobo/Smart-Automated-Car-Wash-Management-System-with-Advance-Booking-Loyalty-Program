package controller;

import dao.CustomerDAO;
import dto.Customer;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCustomerServlet", urlPatterns = {"/admin/customers"})
public class AdminCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String search = request.getParameter("search");
        if (search == null) search = "";
        
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        int pageSize = 10;
        CustomerDAO customerDAO = new CustomerDAO();
        
        int totalRecords = customerDAO.getTotalAdminCustomers(search);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;
        
        List<Customer> customerList = customerDAO.getAdminCustomers(search, page, pageSize);
        
        int totalMembers = customerDAO.getTotalCustomersCount();
        int newMembersThisMonth = customerDAO.getNewCustomersThisMonth();
        double goldPlatPercentage = customerDAO.getGoldPlatPercentage();
        int totalPointsCapped = customerDAO.getTotalPointsCapped();
        
        request.setAttribute("customerList", customerList);
        request.setAttribute("totalMembers", totalMembers);
        request.setAttribute("newMembersThisMonth", newMembersThisMonth);
        request.setAttribute("goldPlatPercentage", goldPlatPercentage);
        request.setAttribute("totalPointsCapped", totalPointsCapped);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("currentSearch", search);
        request.setAttribute("encodedSearch", java.net.URLEncoder.encode(search, "UTF-8"));
        
        request.getRequestDispatcher("/WEB-INF/views/admin/manage_customers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}