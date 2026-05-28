/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CarDao;
import dto.Cars;
import dto.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CarCRUDController", urlPatterns = {"/CarCRUDController"})
public class CarCRUDController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("GetAllCarController");
            return;
        }
        // Xác thực đăng nhập
        Customer us = (Customer) request.getSession().getAttribute("USER");
        if (us == null) {
            response.sendRedirect("login_page.jsp");
            return;
        }
        int customerId = us.getCustomerId();
        CarDao carDAO = new CarDao();
        try {
            switch (action) {
                // 1. THÊM XE MỚI
                case "add": {
                    String licensePlate = request.getParameter("licensePlate");
                    String vehicleType = request.getParameter("vehicleType");
                    String color = request.getParameter("color");
                    Cars car = new Cars(0, customerId, licensePlate, vehicleType, color, null, null, true);
                    boolean success = carDAO.insertCar(car);
                    if (success) {
                        request.getSession().setAttribute("MESSAGE", "Thêm xe mới thành công!");
                    } else {
                        request.getSession().setAttribute("ERROR", "Thêm xe thất bại! Biển số có thể đã đăng ký.");
                    }
                    response.sendRedirect("GetAllCarController");
                    break;
                }
                // 2. YÊU CẦU LẤY THÔNG TIN XE ĐỂ SỬA
                case "edit": {
                    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                    Cars car = carDAO.getCarById(vehicleId);
                    // Kiểm tra bảo mật chính chủ
                    if (car != null && car.getCustomerID() == customerId) {
                        request.setAttribute("CAR_DETAIL", car);
                        // Forward tiếp sang GetAllCarController để load lại list xe hiển thị kèm Form sửa
                        request.getRequestDispatcher("GetAllCarController").forward(request, response);
                    } else {
                        response.sendRedirect("GetAllCarController");
                    }
                    break;
                }
                // 3. CẬP NHẬT XE SAU KHI SỬA
                case "update": {
                    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                    String licensePlate = request.getParameter("licensePlate");
                    String vehicleType = request.getParameter("vehicleType");
                    String color = request.getParameter("color");
                    Cars car = new Cars(vehicleId, customerId, licensePlate, vehicleType, color, null, null, true);
                    boolean success = carDAO.updateCar(car);
                    if (success) {
                        request.getSession().setAttribute("MESSAGE", "Cập nhật thông tin xe thành công!");
                    } else {
                        request.getSession().setAttribute("ERROR", "Cập nhật thất bại!");
                    }
                    response.sendRedirect("GetAllCarController");
                    break;
                }
                // 4. XOÁ XE (XOÁ MỀM)
                case "delete": {
                    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                    boolean success = carDAO.softDeleteCar(vehicleId, customerId);
                    if (success) {
                        request.getSession().setAttribute("MESSAGE", "Xoá xe thành công!");
                    } else {
                        request.getSession().setAttribute("ERROR", "Xoá xe thất bại!");
                    }
                    response.sendRedirect("GetAllCarController");
                    break;
                }
                default:
                    response.sendRedirect("GetAllCarController");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("GetAllCarController");
        }
       
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
