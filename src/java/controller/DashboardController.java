/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dto.Customer;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.BindingProvider;
import utils.AppConstants;

/**
 * DashboardController: Controller chính điều hướng và cung cấp dữ liệu cho trang Tổng quan (Dashboard) của khách hàng.
 * Thu thập và tổng hợp các thông tin như: Thống kê chi tiêu, Lịch rửa xe sắp tới, Thông tin xe, và Tiến độ thăng hạng (Loyalty Tier).
 * 
 * @author thien
 */
@WebServlet(name = "DashboardController", urlPatterns = {"/DashboardController", "/account/dashboard"})
public class DashboardController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }
        CustomerDAO cusDAO = new CustomerDAO();
        Customer cus = cusDAO.getCustomerByAccountId(user.getUserId());
        if (cus != null) {
            dao.BookingDAO bookingDAO = new dao.BookingDAO();
            bookingDAO.autoCancelExpiredBookings();
            bookingDAO.autoPromoteWaitlist();
            // Lấy dữ liệu thật từ Bookings table
            cus.setTotalWashes(bookingDAO.getTotalWashes(cus.getCustomerId()));
            cus.setTotalSpend(bookingDAO.getTotalSpend(cus.getCustomerId()));
            
            request.setAttribute("customer", cus);
            
            // 1. Fetch upcoming bookings (Lấy danh sách các lịch đặt rửa xe sắp tới)
            java.util.List<dto.Booking> upcomingBookings = bookingDAO.getUpcomingBookings(cus.getCustomerId());
            if (!upcomingBookings.isEmpty()) {
                request.setAttribute("upcomingBooking", upcomingBookings.get(0)); // Show the next immediate booking
            }
            
            // 2. Fetch vehicles (Lấy danh sách xe của khách hàng)
            dao.CarDao carDao = new dao.CarDao();
            try {
                java.util.List<dto.Cars> vehicles = carDao.getAllCars(cus.getCustomerId());
                request.setAttribute("vehicles", vehicles);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // 3. Calculate Tier Progress (Tính toán tiến trình lên hạng thành viên tiếp theo)
            dao.MemberTierDAO tierDAO = new dao.MemberTierDAO();
            java.util.List<dto.MemberTier> tiers = tierDAO.getAllTiers();
            
            dto.MemberTier currentTier = null;
            dto.MemberTier nextTier = null;
            
            // Tiers are sorted by PriorityRank ASC (1: Member, 2: Silver, 3: Gold, 4: Platinum)
            // Tìm hạng hiện tại và hạng kế tiếp dựa trên danh sách Tier lấy từ DB
            for (int i = 0; i < tiers.size(); i++) {
                if (tiers.get(i).getTierName().equalsIgnoreCase(cus.getTierStatus())) {
                    currentTier = tiers.get(i);
                    if (i < tiers.size() - 1) {
                        nextTier = tiers.get(i + 1);
                    }
                    break;
                }
            }
            
            if (nextTier != null) {
                // Calculate progress based on Spend
                double currentMinSpend = currentTier != null ? currentTier.getMinSpend() : 0;
                double spendRange = nextTier.getMinSpend() - currentMinSpend;
                double spendProgress = cus.getTotalSpend() - currentMinSpend;
                double spendPercent = (spendRange > 0) ? (spendProgress / spendRange) * 100 : 100;

                // Calculate progress based on Washes
                int currentMinWashes = currentTier != null ? currentTier.getMinWashes() : 0;
                double washesRange = nextTier.getMinWashes() - currentMinWashes;
                double washesProgress = cus.getTotalWashes() - currentMinWashes;
                double washesPercent = (washesRange > 0) ? (washesProgress / washesRange) * 100 : 100;

                // Use whichever progress is higher (since rule is Washes OR Spend)
                double progressPercent = Math.max(spendPercent, washesPercent);
                if (progressPercent > 100) progressPercent = 100;
                if (progressPercent < 0) progressPercent = 0;

                // Determine what's missing (show the one that's closer to achieving)
                if (spendPercent >= washesPercent) {
                    double spendMissing = nextTier.getMinSpend() - cus.getTotalSpend();
                    request.setAttribute("missingMetric", String.format("%,.0f VND", spendMissing > 0 ? spendMissing : 0));
                } else {
                    int washesMissing = nextTier.getMinWashes() - cus.getTotalWashes();
                    request.setAttribute("missingMetric", (washesMissing > 0 ? washesMissing : 0) + " lần rửa");
                }

                request.setAttribute("nextTierName", nextTier.getTierName());
                request.setAttribute("tierProgressPercent", progressPercent);
            } else {
                request.setAttribute("tierProgressPercent", 100);
            }
                // 4. Fetch Reward Catalog
            dao.RewardCatalogDAO rewardDAO = new dao.RewardCatalogDAO();
            try {
                java.util.List<dto.RewardCatalog> rewardCatalog = rewardDAO.getAllActiveRewards();
                request.setAttribute("rewardCatalog", rewardCatalog);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // 5. Fetch Customer's Unused Vouchers
            dao.VoucherDAO voucherDAO = new dao.VoucherDAO();
            try {
                java.util.List<dto.Voucher> myVouchers = voucherDAO.getAvailableVouchers(cus.getCustomerId());
                request.setAttribute("myVouchers", myVouchers);
            } catch (Exception e) {
                e.printStackTrace();
            }

            request.getRequestDispatcher("/WEB-INF/views/customer/dashboard.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

