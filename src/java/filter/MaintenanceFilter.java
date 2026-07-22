package filter;

import dao.SystemConfigDAO;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class MaintenanceFilter implements Filter {

    private SystemConfigDAO configDAO;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        configDAO = new SystemConfigDAO();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        
        // Allowed paths even during maintenance
        if (uri.contains("/assets/") || uri.contains("/css/") || uri.contains("/js/") 
            || uri.contains("/images/") || uri.contains("/admin/") 
            || uri.contains("/auth/") || uri.contains("/api/") || uri.contains("/maintenance")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if admin is logged in, they can bypass maintenance
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            dto.User user = (dto.User) session.getAttribute("loggedInUser");
            if ("ADMIN".equals(user.getRole())) {
                chain.doFilter(request, response);
                return;
            }
        }

        try {
            String maintenanceMode = configDAO.getConfigValue("MaintenanceMode");
            if ("true".equals(maintenanceMode)) {
                res.sendRedirect(req.getContextPath() + "/maintenance");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
