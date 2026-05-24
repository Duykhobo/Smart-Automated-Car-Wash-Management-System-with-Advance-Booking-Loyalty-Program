/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import dto.Customer;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.HashUtil;

/**
 *
 * @author ThanhDuy
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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
        response.sendRedirect("register.jsp");
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
        // Cấu hình UTF-8 chống lỗi tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        // Lấy dữ liệu người dùng nhập
        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String licensePlate = request.getParameter("plate");
        String rawPassword = request.getParameter("password");
        UserDAO userDAO = new UserDAO();
        // Kiểm tra trùng lặp Số Điện Thoại
        if (userDAO.checkUserExists(phone)) {
            request.setAttribute("errorMessage", "Số điện thoại này đã được đăng ký!");

            // Giữ lại dữ liệu cũ trên giao diện
            Customer oldData = new Customer();
            oldData.setFullName(fullName);
            oldData.setPhone(phone);
            oldData.setLicensePlate(licensePlate);
            request.setAttribute("user", oldData);

            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        // Băm mật khẩu (SHA-256)
        String hashedPass = HashUtil.hashPassword(rawPassword);
        // Đóng gói DTO
        User user = new User();
        user.setUsername(phone);
        user.setPasswordHash(hashedPass);
        user.setRole("Customer");
        Customer cus = new Customer();
        cus.setFullName(fullName);
        cus.setPhone(phone);
        cus.setLicensePlate(licensePlate);
        // Lưu vào Database bằng Transaction
        boolean isSuccess = userDAO.registerCustomer(user, cus);
        // Trả kết quả
        if (isSuccess) {
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Hệ thống đang bận, vui lòng thử lại sau!");
            request.setAttribute("user", cus);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
