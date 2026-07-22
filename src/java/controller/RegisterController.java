/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.UserService;
import utils.ValidationUtil;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author ThanhDuy
 */
@WebServlet(name = "RegisterController", urlPatterns = { "/auth/register" })
public class RegisterController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    /**
     * Processes user registration submissions and forwards to the appropriate view.
     *
     * Reads form parameters (fullname, phone, plate, password), enforces UTF-8
     * encoding,
     * and validates that all required fields are present. If any field is missing
     * or blank,
     * sets "errorMessage", attaches a partially populated Customer as "user", and
     * forwards to "register.jsp".
     * Otherwise calls UserService.processRegistration(fullname, phone, plate,
     * password) and:
     * - when the result is 0: sets "errorMessage" indicating the phone is already
     * registered,
     * attaches the submitted Customer as "user", and forwards to "register.jsp";
     * - when the result is 1: sets "successMessage" indicating registration success
     * and forwards to "login.jsp";
     * - for any other result: sets a system-busy "errorMessage", attaches the
     * submitted Customer as "user",
     * and forwards to "register.jsp".
     *
     * @param request  the HTTP request carrying form data
     * @param response the HTTP response used for forwarding
     * @throws ServletException if a servlet-specific error occurs during request
     *                          forwarding
     * @throws IOException      if an I/O error occurs during request forwarding
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

        // Validate form data và gom lỗi vào Map
        Map<String, String> errors = new HashMap<>();

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullname", "Họ và tên không được để trống");
        } else if (!ValidationUtil.isValidName(fullName)) {
            errors.put("fullname", "Họ và tên không hợp lệ! (Không chứa số hoặc ký tự đặc biệt)");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phone", "Số điện thoại không được để trống");
        } else if (!ValidationUtil.isValidVNPhone(phone)) {
            errors.put("phone", "Số điện thoại không hợp lệ! (Phải có 10 chữ số và bắt đầu bằng 0)");
        }

        if (licensePlate == null || licensePlate.trim().isEmpty()) {
            errors.put("plate", "Biển số xe không được để trống");
        } else if (!ValidationUtil.isValidLicensePlate(licensePlate)) {
            errors.put("plate", "Biển số xe không hợp lệ! (VD: 59A-12345)");
        }

        if (rawPassword == null || rawPassword.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống");
        } else if (!ValidationUtil.isValidPassword(rawPassword)) {
            errors.put("password", "Mật khẩu phải từ 8 ký tự trở lên");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("errorMessage", "Vui lòng kiểm tra lại thông tin đăng ký!");
            forwardWithError(request, response, fullName, phone, licensePlate);
            return;
        }

        UserService userService = new UserService();
        int result = userService.processRegistration(fullName, phone, licensePlate, rawPassword);

        if (result == 0) {
            request.setAttribute("errorMessage", "Số điện thoại này đã được đăng ký!");
            forwardWithError(request, response, fullName, phone, licensePlate);
            return;
        }

        if (result == 1) {
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Hệ thống đang bận, vui lòng thử lại sau!");
            forwardWithError(request, response, fullName, phone, licensePlate);
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, 
                                  String fullName, String phone, String licensePlate) 
            throws ServletException, IOException {
        Customer cus = new Customer();
        cus.setFullName(fullName);
        cus.setPhone(phone);
        cus.setLicensePlate(licensePlate);
        request.setAttribute("user", cus);
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }
}
