package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoyaltyProgramController", urlPatterns = {"/loyalty"})
public class LoyaltyProgramController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setAttribute("pageTitle", "Chương Trình Khách Hàng Thân Thiết");
        
        // Chuyển hướng tới trang JSP tĩnh giới thiệu Loyalty Program
        request.getRequestDispatcher("/WEB-INF/views/loyalty_program.jsp").forward(request, response);
    }
}
