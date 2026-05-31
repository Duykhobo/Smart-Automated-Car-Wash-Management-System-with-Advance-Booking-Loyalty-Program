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
import utils.AppConstants;
import utils.ValidationUtil;

/**
 *
 * @author Quan
 */
@WebServlet(name = "CustomerProfileServlet", urlPatterns = {"/CustomerProfileServlet"})
public class CustomerProfileServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else {
            CustomerDAO c = new CustomerDAO();
            Customer customer = c.getCustomerByAccountId(user.getUserId());

            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute(AppConstants.SESSION_USER_ACCOUNT);
        if (user == null) {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        String fullname = request.getParameter("txtfullname");
        String email = request.getParameter("email");
        CustomerDAO cDAO = new CustomerDAO();
        ValidationUtil validate = new ValidationUtil();
        Customer customer = cDAO.getCustomerByAccountId(user.getUserId());
        // nếu mà khách hàng cố tình để trống thì hiển thị lỗi
        if (validate.isAnyEmpty(fullname)) {
            request.setAttribute("errorMessage", "Không được để trống");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }
        // Kiểm tra xem là người dùng có thay đổi gì không ?
        if (customer.getFullName().equalsIgnoreCase(fullname) && customer.getEmail().equalsIgnoreCase(email)) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }
        // Kiểm tra định dạng tên
        if (!ValidationUtil.isValidName(fullname)) {
            request.setAttribute("errorMessage", "Tên không hợp lệ! Vui lòng nhập lại tên.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        if (email != null && !email.trim().isEmpty()) {
            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("errorMessage", "Email không hợp lệ!!Vui lòng nhập lại");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                return;
            }
        }
        if (cDAO.isEmailExists(customer.getCustomerId(), email)) {
            request.setAttribute("errorMessage", "Email đã tồn tại");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        int updateResult = cDAO.updateProfile(customer.getCustomerId(), fullname, email);
        if (updateResult > 0) {
            // Cập nhật thành công: Gửi thông báo xanh và lấy lại thông tin mới nhất từ DB

            request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            Customer updatedCustomer = cDAO.getCustomerByAccountId(user.getUserId());
            request.getSession().setAttribute(AppConstants.SESSION_CUSTOMER_INFO, updatedCustomer); // cập nhật cho cả những trang nào lấy customer bằng session
            request.setAttribute("customer", updatedCustomer);
        } else {
            // Cập nhật thất bại
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống, vui lòng thử lại sau!");
            request.setAttribute("customer", customer);
        }
        // Forward về lại trang hiển thị profile
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
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
