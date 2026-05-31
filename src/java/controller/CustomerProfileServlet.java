/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.Customer;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.CustomerService;
import utils.AppConstants;

@WebServlet(name = "CustomerProfileServlet", urlPatterns = {"/CustomerProfileServlet"})
public class CustomerProfileServlet extends HttpServlet {

    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else {
            Customer customer = customerService.getCustomerByAccountId(user.getUserId());
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        String fullname = request.getParameter("txtfullname");
        String email = request.getParameter("email");
        
        try {
            Customer customer = customerService.getCustomerByAccountId(user.getUserId());
            Customer updatedCustomer = customerService.updateProfile(user.getUserId(), fullname, email);
            
            if (updatedCustomer != customer) { // If there were changes
                request.getSession().setAttribute("successMessage", "Cập nhật thông tin thành công!");
                request.getSession().setAttribute(AppConstants.SESSION_CUSTOMER_INFO, updatedCustomer);
            }
        } catch (Exception ex) {
            request.getSession().setAttribute("errorMessage", ex.getMessage());
        }

        // Forward về lại trang hiển thị profile (thông qua redirect)
        response.sendRedirect(request.getContextPath() + "/account/profile");
    }

    @Override
    public String getServletInfo() {
        return "Customer Profile Servlet";
    }
}
