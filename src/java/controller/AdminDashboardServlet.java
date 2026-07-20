package controller;

import dao.ReportDAO;
import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AdminDashboardServlet điều hướng yêu cầu tới trang Dashboard của Admin.
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ReportDAO reportDAO = new ReportDAO();
        
        double revenueThisMonth = reportDAO.getRevenueThisMonth();
        double revenueLastMonth = reportDAO.getRevenueLastMonth();
        double revenueGrowth = 0.0;
        if (revenueLastMonth > 0) {
            revenueGrowth = ((revenueThisMonth - revenueLastMonth) / revenueLastMonth) * 100;
        } else if (revenueThisMonth > 0) {
            revenueGrowth = 100.0;
        }

        int washesToday = reportDAO.getWashesToday();
        int washesYesterday = reportDAO.getWashesYesterday();
        int washesGrowth = washesToday - washesYesterday;
        
        int pendingBookings = reportDAO.getPendingBookingsCount();
        
        Map<String, Double> revenueLast7Days = reportDAO.getRevenueLast7Days();
        
        StringBuilder labelsJson = new StringBuilder("[");
        StringBuilder dataJson = new StringBuilder("[");
        boolean first = true;
        for (Map.Entry<String, Double> entry : revenueLast7Days.entrySet()) {
            if (!first) {
                labelsJson.append(",");
                dataJson.append(",");
            }
            labelsJson.append("\"").append(entry.getKey()).append("\"");
            dataJson.append(entry.getValue());
            first = false;
        }
        labelsJson.append("]");
        dataJson.append("]");
        
        request.setAttribute("revenueThisMonth", revenueThisMonth);
        request.setAttribute("revenueGrowth", revenueGrowth);
        request.setAttribute("washesToday", washesToday);
        request.setAttribute("washesGrowth", washesGrowth);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("chartLabels", labelsJson.toString());
        request.setAttribute("chartData", dataJson.toString());
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
