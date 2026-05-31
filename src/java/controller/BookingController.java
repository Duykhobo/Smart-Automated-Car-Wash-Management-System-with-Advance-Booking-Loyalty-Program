package controller;

import dao.CarDao;
import dao.CustomerDAO;
import dao.ServiceDAO;
import dto.Cars;
import dto.Customer;
import dto.Service;
import dto.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.AppConstants;

@WebServlet(name = "BookingController", urlPatterns = {"/BookingController"})
public class BookingController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerByAccountId(user.getUserId());
            
            if (customer != null) {
                // Fetch cars
                CarDao carDao = new CarDao();
                List<Cars> vehicles = carDao.getAllCars(customer.getCustomerId());
                request.setAttribute("vehicles", vehicles);
                
                // Fetch services
                ServiceDAO serviceDAO = new ServiceDAO();
                List<Service> services = serviceDAO.getAllActiveServices();
                request.setAttribute("services", services);
            }
            
            request.getRequestDispatcher("/WEB-INF/views/booking.jsp").forward(request, response);
            
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải dữ liệu đặt lịch.");
            request.getRequestDispatcher("/WEB-INF/views/booking.jsp").forward(request, response);
        }
    }
}
