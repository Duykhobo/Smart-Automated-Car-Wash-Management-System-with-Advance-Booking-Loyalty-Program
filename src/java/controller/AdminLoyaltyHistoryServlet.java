package controller;

import dao.CustomerDAO;
import dto.Customer;
import dto.PointLedger;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminLoyaltyHistoryServlet", urlPatterns = {"/admin/loyalty/history"})
public class AdminLoyaltyHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String customerIdStr = request.getParameter("customerId");
        
        if (customerIdStr != null && !customerIdStr.trim().isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr);
                CustomerDAO customerDAO = new CustomerDAO();
                
                Customer customer = customerDAO.getCustomerById(customerId);
                List<PointLedger> historyList = customerDAO.getPointLedgerByCustomerId(customerId);
                
                request.setAttribute("cust", customer);
                request.setAttribute("historyList", historyList);
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/admin/point_history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}