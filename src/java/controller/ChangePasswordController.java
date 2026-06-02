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
        request.setCharacterEncoding("UTF-8");
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
            request.getSession().setAttribute("errorMessage", "Không được để trống");
            response.sendRedirect(request.getContextPath() + "/account/change-password");
            return;
        }
        //Kiểm tra độ mạnh của mật khẩu mới (ít nhất 8 ký tự, chứa chữ viết hoa và ký tự đặc biệt)
        String passwordPattern = "^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?\":{}|<>]).{8,}$";
        if (!newPassword.matches(passwordPattern)) {
            request.getSession().setAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 8 ký tự, chứa chữ viết hoa và ký tự đặc biệt!");
            response.sendRedirect(request.getContextPath() + "/account/change-password");
            return;
        }
        //Kiểm tra xem xác nhận mật khẩu mới có khớp với mk mới không 
        if (!confirmNewPassword.equals(newPassword)) {
            request.getSession().setAttribute("errorMessage", "Xác nhận mật khẩu không trùng với mật khẩu mới.Vui lòng kiểm tra lại");
            response.sendRedirect(request.getContextPath() + "/account/change-password");
            return;
        }
        // Kiểm tra mật khẩu cũ có giống không
        boolean correct = HashUtil.verifyPassword(currentpassword, user.getPasswordHash());
        if (!correct) {
            request.getSession().setAttribute("errorMessage", "Mật khẩu cũ không chính xác");
            response.sendRedirect(request.getContextPath() + "/account/change-password");
            return;
        }
        // kiểm trả xem mật khẩu mới có giống mật khẩu cũ không 
        if (currentpassword.equals(newPassword)) {
            request.getSession().setAttribute("errorMessage", "Mật khẩu mới không được trùng với mật khẩu đang dùng");
            response.sendRedirect(request.getContextPath() + "/account/change-password");
            return;
        }
        String newHashedPassword = HashUtil.createHash(newPassword);
        UserDAO userDAO = new UserDAO();
        int updateResult = userDAO.updatePassword(user.getUserId(), newHashedPassword);
        if (updateResult == 1) {
            // Đổi mật khẩu thành công, xóa session cũ bắt đăng nhập lại
            request.getSession().invalidate();
            // Tạo session mới để lưu thông báo thành công
            request.getSession(true).setAttribute("successMessage", "Đổi mật khẩu thành công! Vui lòng đăng nhập lại với mật khẩu mới.");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        } else {
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống! Không thể cập nhật mật khẩu, vui lòng thử lại sau.");
            response.sendRedirect(request.getContextPath() + "/account/change-password");
            return;
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
