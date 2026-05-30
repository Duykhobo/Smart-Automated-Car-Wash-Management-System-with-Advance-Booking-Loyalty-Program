package filter;

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
import utils.AppConstants;

/**
 * Filter này chặn mọi request (tùy urlPatterns) để kiểm tra đăng nhập. Ở đây
 * chặn các trang yêu cầu người dùng phải có tài khoản.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/account/*", "/vehicles/*", "/bookings"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo (nếu cần)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Kiểm tra xem session có tồn tại và có chứa 'loggedInUser' không
        boolean loggedIn = session != null && session.getAttribute(AppConstants.SESSION_USER_ACCOUNT) != null;

        if (loggedIn) {
            // Chống back trình duyệt bằng cache
            res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            res.setHeader("Pragma", "no-cache");
            res.setDateHeader("Expires", 0);
            
            // Đã đăng nhập -> cho đi tiếp
            chain.doFilter(request, response);
        } else {
            // Lưu lại URL người dùng muốn vào để redirect sau khi login
            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("redirectUrl", req.getRequestURI());

            // Chưa đăng nhập -> đá về trang login với thông báo
            req.setAttribute("errorMessage", "Vui lòng đăng nhập để tiếp tục!");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        // Dọn dẹp (nếu cần)
    }
}
