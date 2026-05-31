package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.annotation.MultipartConfig;

@WebServlet(name = "PageController", urlPatterns = {"", "/home", "/index", "/account/dashboard", "/bookings", "/account/profile", "/account/change-password"})
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
            case "/account/dashboard":
                view = "/DashboardController";
                break;
            case "/bookings":
                view = "/BookingController";
                break;
            case "/account/profile":
                view = "/CustomerProfileServlet";
                break;
            case "/account/change-password":
                view = "/ChangePasswordController";
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
