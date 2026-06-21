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
@WebServlet(name = "PageController", urlPatterns = {"", "/home", "/index", "/account/dashboard", "/bookings", "/account/profile", "/account/change-password", "/account/payment-methods", "/customer/booking_history", "/customer/loyalty", "/customer/seed_demo"})
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
            case "/account/payment-methods":
                view = "/WEB-INF/views/payment_methods.jsp";
                break;
            case "/customer/booking_history":
                view = "/BookingHistoryController";
                break;
            case "/customer/seed_demo":
                // Tự động tạo dữ liệu mẫu (Bookings) cho người dùng hiện tại
                dto.User currentUser = (dto.User) request.getSession().getAttribute(utils.AppConstants.SESSION_USER_ACCOUNT);
                if (currentUser != null) {
                    dao.CustomerDAO cDAO = new dao.CustomerDAO();
                    dto.Customer c = cDAO.getCustomerByAccountId(currentUser.getUserId());
                    if (c != null) {
                        try ( java.sql.Connection conn = utils.DBContext.getConnection(); 
                              java.sql.PreparedStatement st = conn.prepareStatement("SELECT TOP 1 VehicleID FROM Vehicles WHERE CustomerID = ?")) {
                            st.setInt(1, c.getCustomerId());
                            java.sql.ResultSet rs = st.executeQuery();
                            if (rs.next()) {
                                int vehicleId = rs.getInt("VehicleID");
                                dao.BookingDAO bDAO = new dao.BookingDAO();
                                
                                // 1. Upcoming Booking (Ngày mai, 10:00)
                                java.sql.Date tomorrow = new java.sql.Date(System.currentTimeMillis() + 86400000L);
                                bDAO.createBookingTransaction(c.getCustomerId(), 1, vehicleId, null, tomorrow, java.sql.Time.valueOf("10:00:00"), 100000, 0, 100000);
                                
                                // 2. Past Completed Booking (Hôm qua, 14:00)
                                java.sql.Date yesterday = new java.sql.Date(System.currentTimeMillis() - 86400000L);
                                bDAO.createBookingTransaction(c.getCustomerId(), 2, vehicleId, null, yesterday, java.sql.Time.valueOf("14:00:00"), 150000, 0, 150000);
                                // Set status to Completed
                                String sqlComplete = "UPDATE Bookings SET Status = 'Completed' WHERE CustomerID = ? AND BookingDate = ?";
                                try (java.sql.PreparedStatement st2 = conn.prepareStatement(sqlComplete)) {
                                    st2.setInt(1, c.getCustomerId());
                                    st2.setDate(2, yesterday);
                                    st2.executeUpdate();
                                }
                                
                                // 3. Past Cancelled Booking (3 ngày trước, 09:00)
                                java.sql.Date pastDay = new java.sql.Date(System.currentTimeMillis() - 3 * 86400000L);
                                bDAO.createBookingTransaction(c.getCustomerId(), 3, vehicleId, null, pastDay, java.sql.Time.valueOf("09:00:00"), 350000, 0, 350000);
                                // Set status to Cancelled
                                String sqlCancel = "UPDATE Bookings SET Status = 'Cancelled' WHERE CustomerID = ? AND BookingDate = ?";
                                try (java.sql.PreparedStatement st3 = conn.prepareStatement(sqlCancel)) {
                                    st3.setInt(1, c.getCustomerId());
                                    st3.setDate(2, pastDay);
                                    st3.executeUpdate();
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                response.sendRedirect(request.getContextPath() + "/customer/booking_history");
                return;
            case "/customer/loyalty":
                dto.User sessionUser = (dto.User) request.getSession().getAttribute(utils.AppConstants.SESSION_USER_ACCOUNT);
                if (sessionUser != null) {
                    dao.CustomerDAO cusDAO = new dao.CustomerDAO();
                    dto.Customer customer = cusDAO.getCustomerByAccountId(sessionUser.getUserId());

                    if (customer != null) {
                        int points = customer.getPointsBalance();
                        String tier = customer.getTierStatus() != null ? customer.getTierStatus().toUpperCase() : "MEMBER";
                        String nextTier = "SILVER";
                        int targetPoints = 500;

                        if ("SILVER".equals(tier)) {
                            nextTier = "GOLD";
                            targetPoints = 1500;
                        } else if ("GOLD".equals(tier)) {
                            nextTier = "PLATINUM";
                            targetPoints = 3000;
                        } else if ("PLATINUM".equals(tier)) {
                            nextTier = "MAX";
                            targetPoints = points; // Already at max
                        }

                        int pointsNeeded = Math.max(0, targetPoints - points);
                        int progressPercent = (targetPoints > 0) ? (int) Math.min(100, ((double) points / targetPoints) * 100) : 100;

                        request.setAttribute("customer", customer);
                        request.setAttribute("nextTier", nextTier);
                        request.setAttribute("targetPoints", targetPoints);
                        request.setAttribute("pointsNeeded", pointsNeeded);
                        request.setAttribute("progressPercent", progressPercent);
                    }
                }
                view = "/WEB-INF/views/customer/loyalty.jsp";
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
