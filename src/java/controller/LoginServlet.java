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
import service.UserService;
import utils.ValidationUtil;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // Edge case: Thiếu thông tin
        if (ValidationUtil.isAnyEmpty(phone, password)) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ Số điện thoại và Mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        UserService userService = new UserService();
        User user = userService.processLogin(phone, password);

        if (user != null) {
            // Đăng nhập thành công, chống Session Fixation bằng cách xóa session cũ
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            
            // Tạo session mới hoàn toàn tinh khiết
            HttpSession session = request.getSession(true);
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
