package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/auth/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String email = request.getParameter("email");
        
        // Validate email format using basic regex
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (email != null && email.matches(emailRegex)) {
            // Anti-Enumeration: Always display the same generic success message regardless of whether the email exists in DB
            request.setAttribute("successMessage", "Nếu email hợp lệ, một đường link đặt lại mật khẩu đã được gửi đến hộp thư của bạn. Vui lòng kiểm tra.");
        } else {
            request.setAttribute("errorMessage", "Vui lòng nhập địa chỉ email hợp lệ.");
        }

        request.getRequestDispatcher("/WEB-INF/views/forgot_password.jsp").forward(request, response);
    }
}
