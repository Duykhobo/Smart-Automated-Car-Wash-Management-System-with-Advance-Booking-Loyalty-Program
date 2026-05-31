/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dao.UserDAO;
import dto.Customer;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.AppConstants;
import utils.HashUtil;
import utils.ValidationUtil;

/**
 *
 * @author thien
 */
@WebServlet(name = "ChangePasswordController", urlPatterns = {"/ChangePasswordController"})
public class ChangePasswordController extends HttpServlet {

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
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else {
            CustomerDAO c = new CustomerDAO();
            Customer customer = c.getCustomerByAccountId(user.getUserId());

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect("/auth/login");
            return;
        }
        String currentpassword = request.getParameter("txtCurrentPassword");
        String newPassword = request.getParameter("txtNewPassword");
        String confirmNewPassword = request.getParameter("txtConfirmNewPassword");
        // kiểm tra xem nó có trống không 
        if (ValidationUtil.isAnyEmpty(currentpassword, newPassword, confirmNewPassword)) {
            request.setAttribute("errorMessage", "Không được để trống");
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp").forward(request, response);
            return;
        }
        //Kiểm tra độ dài có dưới 6 không
        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu mới phải từ 6 ký tự trở lên!");
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp").forward(request, response);
            return;
        }
        //Kiểm tra xem xác nhận mật khẩu mới có khớp với mk mới không 
        if (!confirmNewPassword.equals(newPassword)) {
            request.setAttribute("errorMessage", "Xác nhận mật khẩu không trùng với mật khẩu mới.Vui lòng kiểm tra lại");
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp").forward(request, response);
            return;
        }
        // Kiểm tra mật khẩu cũ có giống không
        boolean correct = HashUtil.verifyPassword(currentpassword, user.getPasswordHash());
        if (!correct) {
            request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác");
            request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp").forward(request, response);
            return;
        }
        String newHashedPassword = HashUtil.createHash(newPassword);
        UserDAO userDAO = new UserDAO();
        int updateResult = userDAO.updatePassword(user.getUserId(), newHashedPassword);
        if (updateResult == 1) {
            user.setPasswordHash(newHashedPassword);
            request.getSession().setAttribute(AppConstants.SESSION_USER_ACCOUNT, user);
            request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
        } else {
            request.setAttribute("errorMessage", "Lỗi hệ thống! Không thể cập nhật mật khẩu, vui lòng thử lại sau.");
        }
        request.getRequestDispatcher("/WEB-INF/views/changePassword.jsp").forward(request, response);
        return;
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
