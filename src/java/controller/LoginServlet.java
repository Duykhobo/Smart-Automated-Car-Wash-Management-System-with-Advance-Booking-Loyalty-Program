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

        if (ValidationUtil.isAnyEmpty(phone, password)) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ Số điện thoại và Mật khẩu!");
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        UserService us = new UserService();
        User user = us.processLogin(phone, password);

        if (user != null) {
            // Thay đổi Session ID để chống Session Fixation attack
            request.changeSessionId();

            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.SESSION_USER_ACCOUNT, user);

            // Kiểm tra xem trước đó user có đang muốn vào URL nào không
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                // Anti Open-Redirect: Check if the URL starts with context path
                if (!redirectUrl.startsWith(request.getContextPath() + "/") && !redirectUrl.equals(request.getContextPath())) {
                    redirectUrl = null; // Invalid redirect, fallback to default
                }
            }

            if (AppConstants.ROLE_ADMIN.equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(redirectUrl != null ? redirectUrl : request.getContextPath() + "/admin/dashboard");
            } else {
                dao.UserDAO userDAO = new UserDAO();
                dto.Customer cus = userDAO.getCustomerByUserId(user.getUserId());
                if (cus != null) {
                    session.setAttribute(AppConstants.SESSION_CUSTOMER_INFO, cus);
                } else {
                    // Fallback to prevent NullPointerException in JSP
                    session.setAttribute(AppConstants.SESSION_CUSTOMER_INFO, new dto.Customer());
                }
                response.sendRedirect(redirectUrl != null ? redirectUrl : request.getContextPath() + "/account/dashboard");
            }

        } else {
            request.setAttribute("errorMessage", "Số điện thoại hoặc mật khẩu không chính xác!");
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }

    }
}
