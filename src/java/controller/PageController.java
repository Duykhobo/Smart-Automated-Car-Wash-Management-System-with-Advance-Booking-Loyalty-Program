package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PageController", urlPatterns = {"", "/home", "/index", "/account/dashboard", "/bookings", "/account/profile"})
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
                view = "/WEB-INF/views/dashboard.jsp";
                break;
            case "/bookings":
                view = "/WEB-INF/views/booking.jsp";
                break;
            case "/account/profile":
                view = "/WEB-INF/views/profile.jsp";
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
        }
        
        request.getRequestDispatcher(view).forward(request, response);
    }
}
