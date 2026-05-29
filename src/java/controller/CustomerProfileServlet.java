/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dto.Customer;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.ValidationUtil;

/**
 *
 * @author Quan
 */
@WebServlet(name = "CustomerProfileServlet", urlPatterns = {"/CustomerProfileServlet"})
public class CustomerProfileServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
        } else {
            CustomerDAO c = new CustomerDAO();
            Customer customer = c.getCustomerByAccountId(user.getUserId());

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("CustomerProfile.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String fullname = request.getParameter("txtfullname");
        String phone = request.getParameter("txtphone");
        String password = request.getParameter("txtpassword");
        CustomerDAO c = new CustomerDAO();
        ValidationUtil validate = new ValidationUtil();
        Customer customer = c.getCustomerByAccountId(user.getUserId());
        // nếu mà khách hàng cố tình để trống thì hiển thị lỗi
        if (validate.isAnyEmpty(fullname, phone)) {
            request.setAttribute("errorMessage", "Không được để trống");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("edit_profile.jsp").forward(request, response);
            return;
        }
        // trường hợp khác hàng để trống password thì ko thay đổi password
        if (password.isEmpty()) {
            if (phone.equalsIgnoreCase(user.getUsername())) {
                if (c.updateProfile(customer.getCustomerId(), fullname, phone) == 1) {
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("CustomerProfile.jsp").forward(request, response);
                }
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
