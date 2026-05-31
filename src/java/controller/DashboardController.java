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
 *
 * @author thien
 */
@WebServlet(name = "DashboardController", urlPatterns = {"/DashboardController"})
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
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        CustomerDAO cusDAO = new CustomerDAO();
        Customer cus = cusDAO.getCustomerByAccountId(user.getUserId());
        if (cus != null) {
            request.setAttribute("customer", cus);
            
            // 1. Fetch upcoming bookings
            dao.BookingDAO bookingDAO = new dao.BookingDAO();
            java.util.List<dto.Booking> upcomingBookings = bookingDAO.getUpcomingBookings(cus.getCustomerId());
            if (!upcomingBookings.isEmpty()) {
                request.setAttribute("upcomingBooking", upcomingBookings.get(0)); // Show the next immediate booking
            }
            
            // Fetch vehicles
            dao.CarDao carDao = new dao.CarDao();
            try {
                java.util.List<dto.Cars> vehicles = carDao.getAllCars(cus.getCustomerId());
                request.setAttribute("vehicles", vehicles);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // 2. Calculate Tier Progress
            dao.MemberTierDAO tierDAO = new dao.MemberTierDAO();
            java.util.List<dto.MemberTier> tiers = tierDAO.getAllTiers();
            
            dto.MemberTier currentTier = null;
            dto.MemberTier nextTier = null;
            
            // Tiers are sorted by PriorityRank ASC (1: Member, 2: Silver, 3: Gold, 4: Platinum)
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
                // Calculate missing points (using min spend for now as an example metric)
                double spendMissing = nextTier.getMinSpend() - cus.getTotalSpend();
                if (spendMissing < 0) spendMissing = 0;
                
                request.setAttribute("nextTierName", nextTier.getTierName());
                request.setAttribute("spendToNextTier", spendMissing);
                
                // Progress percentage
                double currentMinSpend = currentTier != null ? currentTier.getMinSpend() : 0;
                double spendRange = nextTier.getMinSpend() - currentMinSpend;
                double currentProgress = cus.getTotalSpend() - currentMinSpend;
                double progressPercent = (currentProgress / spendRange) * 100;
                if (progressPercent > 100) progressPercent = 100;
                if (progressPercent < 0) progressPercent = 0;
                
                request.setAttribute("tierProgressPercent", progressPercent);
            } else {
                request.setAttribute("tierProgressPercent", 100);
            }
        }
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
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
