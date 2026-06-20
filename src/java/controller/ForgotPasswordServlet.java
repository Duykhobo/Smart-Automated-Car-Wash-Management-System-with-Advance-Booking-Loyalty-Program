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
        
        // TODO: Implement actual email sending logic or token generation here
        // For now, we simulate a successful email send to keep the flow intact
        if (email != null && !email.trim().isEmpty()) {
            request.setAttribute("successMessage", "Một đường link đặt lại mật khẩu đã được gửi đến email " + email + ". Vui lòng kiểm tra hộp thư của bạn.");
        } else {
            request.setAttribute("errorMessage", "Vui lòng nhập địa chỉ email hợp lệ.");
        }

        request.getRequestDispatcher("/WEB-INF/views/forgot_password.jsp").forward(request, response);
    }
}
