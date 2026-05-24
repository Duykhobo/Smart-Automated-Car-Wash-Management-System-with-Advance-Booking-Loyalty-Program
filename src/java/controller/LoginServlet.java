package controller;

import dao.UserDAO;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.HashUtil;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // Edge case: Thiếu thông tin
        if (phone == null || phone.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ Số điện thoại và Mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String hashedPass = HashUtil.hashPassword(password);
        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(phone, hashedPass);

        if (user != null) {
            // Đăng nhập thành công, lưu session
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            
            // Phân quyền (Edge case: Admin vs Customer)
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            // Sai số điện thoại hoặc mật khẩu
            request.setAttribute("errorMessage", "Số điện thoại hoặc Mật khẩu không chính xác!");
            request.setAttribute("phone", phone); // Giữ lại SĐT
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
