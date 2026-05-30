package controller;

import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.UserService;
import utils.AppConstants;
import utils.ValidationUtil;

@WebServlet(name = "LoginServlet", urlPatterns = {"/auth/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
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
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        UserService userService = new UserService();
        User user = userService.processLogin(phone, password);

        if (user != null) {
            // Đăng nhập thành công, lưu session
            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.SESSION_USER_ACCOUNT, user);

            // Phân quyền (Edge case: Admin vs Customer)
            if (AppConstants.ROLE_ADMIN.equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("admin/dashboard");
            } else {
                dao.UserDAO userDAO = new dao.UserDAO();
                dto.Customer customer = userDAO.getCustomerByUserId(user.getUserId());
                if (customer != null) {
                    session.setAttribute(AppConstants.SESSION_CUSTOMER_INFO, customer);
                }
                response.sendRedirect(request.getContextPath() + "/account/dashboard");
            }
        } else {
            // Sai số điện thoại hoặc mật khẩu
            request.setAttribute("errorMessage", "Số điện thoại hoặc Mật khẩu không chính xác!");
            request.setAttribute("phone", phone); // Giữ lại SĐT
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
