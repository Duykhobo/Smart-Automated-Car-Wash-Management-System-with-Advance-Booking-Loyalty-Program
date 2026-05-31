package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

/**
 * Filter ngăn chặn trình duyệt cache lại các trang nhạy cảm (như dashboard, profile)
 * Khi user logout và ấn nút Back, họ sẽ không thấy được thông tin cũ nữa.
 */
@WebFilter(filterName = "NoCacheFilter", urlPatterns = {"/account/dashboard", "/vehicles", "/bookings", "/account/profile", "/admin/*"})
public class NoCacheFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Init logic
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Cài đặt các Header chống cache chuẩn cho HTTP/1.1 và HTTP/1.0
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        httpResponse.setDateHeader("Expires", 0); // Proxies.
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Destroy logic
    }
}
