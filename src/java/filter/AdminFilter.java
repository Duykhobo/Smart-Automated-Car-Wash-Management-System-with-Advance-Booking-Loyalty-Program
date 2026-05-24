package filter;

import dto.User;
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

/**
 * Filter này chặn toàn bộ các request vào thư mục /admin/*
 * Chỉ có user mang Role là "Admin" mới được phép truy cập.
 */
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;

        if (loggedIn) {
            User user = (User) session.getAttribute("loggedInUser");
            if ("Admin".equalsIgnoreCase(user.getRole())) {
                // Là Admin -> cho qua
                chain.doFilter(request, response);
            } else {
                // Không phải Admin -> Báo lỗi 403 Forbidden
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập vào khu vực này!");
            }
        } else {
            // Chưa đăng nhập -> Trả về trang đăng nhập
            req.setAttribute("errorMessage", "Vui lòng đăng nhập bằng tài khoản quản trị!");
            req.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
