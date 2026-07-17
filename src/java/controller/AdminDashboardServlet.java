package controller;

import dao.ReportDAO;
import java.io.IOException;
import java.util.List;
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
        
        // Tạm thời forward thẳng tới JSP để test giao diện.
        // Sau này sẽ thêm logic check role Admin và fetch Data từ ReportDAO ở đây.
        try{
            ReportDAO d = new ReportDAO();
            
            double todayRevenue = d.getTodayTotalRevenue();
            int todayBooking = d.getTodayTotalBooking();
            int pendingBooking = d.getPendingBookingsCount();
            
            List<String> label = d.getLabelsLast7Days();
            List<Double> revenue = d.getRevenueLast7Days();
            
            StringBuilder labelJS = new StringBuilder("[");
            for(int i = 0; i < label.size();i++){
                labelJS.append("'").append(label.get(i)).append("'");
                if (i < label.size() - 1) labelJS.append(",");
            }   
            labelJS.append("]");
            
            request.setAttribute("todayRevenue", todayRevenue);
            request.setAttribute("todayBookings", todayBooking);
            request.setAttribute("pendingBookings", pendingBooking);
            request.setAttribute("chartLabels", labelJS.toString());
            request.setAttribute("chartData", revenue.toString());
            
        }catch(Exception e){
            e.printStackTrace();
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
