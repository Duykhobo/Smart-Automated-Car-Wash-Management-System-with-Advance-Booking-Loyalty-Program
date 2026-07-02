package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.annotation.MultipartConfig;

/**
 * PageController: Front Controller / Router điều hướng các trang cơ bản.
 * Chịu trách nhiệm nhận các URL ảo (như /home, /account/dashboard) và forward 
 * tới các JSP view hoặc các Servlet xử lý logic tương ứng.
 * Giúp tạo URL thân thiện (SEO/User-friendly URL) thay vì lộ tên file .jsp hay Servlet.
 */
@WebServlet(name = "PageController", urlPatterns = {"", "/home", "/index", "/account/payment-methods", "/customer/seed_demo", "/qr-scanner"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class PageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        String view = "";

        switch (path) {
            case "":
            case "/":
            case "/home":

            case "/index":
                view = "/WEB-INF/views/index.jsp";
                break;
            case "/account/payment-methods":
                view = "/WEB-INF/views/customer/payment_methods.jsp";
                break;


            case "/qr-scanner":
                view = "/demo_qr.jsp";
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
        }

        request.getRequestDispatcher(view).forward(request, response);
    }

    // de chuyen cho form dung doPost
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Gọi lại doGet để nó chạy qua khối switch-case và forward sang CustomerProfileServlet
        doGet(request, response);
    }
}
