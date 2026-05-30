package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PageController", urlPatterns = {"", "/home", "/index", "/dashboard", "/booking", "/profile", "/manage-cars"})
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
            case "/dashboard":
                view = "/WEB-INF/views/dashboard.jsp";
                break;
            case "/booking":
                view = "/WEB-INF/views/booking.jsp";
                break;
            case "/profile":
                view = "/WEB-INF/views/profile.jsp";
                break;
            case "/manage-cars":
                view = "/WEB-INF/views/manage_cars.jsp";
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
        }
        
        request.getRequestDispatcher(view).forward(request, response);
    }
}
