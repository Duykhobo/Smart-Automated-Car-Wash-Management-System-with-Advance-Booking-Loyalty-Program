package controller;

import dao.CarDao;
import dto.Cars;
import dto.Customer;
import utils.AppConstants;
import utils.FileUploadUtil;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.ValidationUtil;
@WebServlet(name = "VehicleController", urlPatterns = { "/vehicles", "/vehicles/action" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class VehicleController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(VehicleController.class.getName());

    // ---------------------------------------------------------
    // doGet: Lấy danh sách xe
    // ---------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            Object obj = request.getSession().getAttribute(AppConstants.SESSION_CUSTOMER_INFO);
            if (obj == null || !(obj instanceof Customer)) {
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath() + "/auth/login");
                return;
            }
            Customer us = (Customer) obj;
            int customerId = us.getCustomerId();
            CarDao carDAO = new CarDao();
            List<Cars> listCars = carDAO.getAllCars(customerId);

            request.setAttribute("LISTCARS", listCars);
            request.getRequestDispatcher("/WEB-INF/views/manage_cars.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving car list", e);
            request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR, "Lỗi: " + e.toString());
            response.sendRedirect(request.getContextPath() + "/account/dashboard");
        }
    }

    // ---------------------------------------------------------
    // doPost: Xử lý Thêm / Sửa / Xóa / Mặc định
    // ---------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/vehicles");
            return;
        }

        // Xác thực đăng nhập
        Object obj = request.getSession().getAttribute(AppConstants.SESSION_CUSTOMER_INFO);
        if (obj == null || !(obj instanceof Customer)) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        Customer us = (Customer) obj;
        int customerId = us.getCustomerId();
        CarDao carDAO = new CarDao();

        try {
            switch (action) {
                case "add": {
                    String licensePlate = request.getParameter("licensePlate");
                    if (licensePlate != null) {
                        licensePlate = licensePlate.trim().toUpperCase(); // Bổ sung dòng này để chuẩn hóa ghi đè thành chứ in hoa//
                    }
                    String vehicleType = request.getParameter("vehicleType");
                    String color = request.getParameter("color");
                    String brand = request.getParameter("brand");
                    String model = request.getParameter("model");
                    if (ValidationUtil.isAnyEmpty(licensePlate, brand, model, vehicleType, color)) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR,
                                "Vui lòng nhập đầy đủ các trường bắt buộc!");
                        response.sendRedirect(request.getContextPath() + "/vehicles");
                        return;
                    }
                    // BỔ SUNG: Kiểm tra định dạng biển số xe khi thêm mới
                    if (!ValidationUtil.isValidLicensePlate(licensePlate)) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR,
                                "Định dạng biển số xe không hợp lệ! (Ví dụ: 59A-12345 hoặc 59A1-12345)");
                        response.sendRedirect(request.getContextPath() + "/vehicles");
                        return;
                    }
                    
                    Timestamp createdAt = new Timestamp(System.currentTimeMillis());
                    Timestamp updatedAt = new Timestamp(System.currentTimeMillis());

                    String imageUrl = FileUploadUtil.saveFile(request, "carImage", getServletContext().getRealPath(""));
                    Cars car = new Cars(customerId, licensePlate, brand, model, vehicleType, color, imageUrl, false,
                            createdAt, updatedAt, true);

                    boolean success = carDAO.insertCar(car);
                    if (success) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_SUCCESS, "Thêm xe mới thành công!");
                    } else {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR,
                                "Thêm xe thất bại! Biển số có thể đã đăng ký.");
                    }
                    response.sendRedirect(request.getContextPath() + "/vehicles");
                    break;
                }

                case "update": {
                    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                    String licensePlate = request.getParameter("licensePlate");
                    if (licensePlate != null) {
                        licensePlate = licensePlate.trim().toUpperCase(); // Thêm dòng này để chuẩn hóa biển số in hoa khi sửa
                    }
                    String vehicleType = request.getParameter("vehicleType");
                    String color = request.getParameter("color");
                    String brand = request.getParameter("brand");
                    String model = request.getParameter("model");

                    if (ValidationUtil.isAnyEmpty(licensePlate, brand, model, vehicleType, color)) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR,
                                "Vui lòng nhập đầy đủ các trường bắt buộc!");
                        response.sendRedirect(request.getContextPath() + "/vehicles");
                        return;
                    }
                    // BỔ SUNG: Kiểm tra định dạng biển số xe khi cập nhật
                    if (!ValidationUtil.isValidLicensePlate(licensePlate)) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR,
                                "Định dạng biển số xe không hợp lệ! (Ví dụ: 59A-12345 hoặc 59A1-12345)");
                        response.sendRedirect(request.getContextPath() + "/vehicles");
                        return;
                    }
                    Timestamp updatedAt = new Timestamp(System.currentTimeMillis());
                    String imageUrl = FileUploadUtil.saveFile(request, "carImage", getServletContext().getRealPath(""));
                    Cars car = new Cars(vehicleId, customerId, licensePlate, brand, model, vehicleType, color, imageUrl,
                            false, null, updatedAt, true);

                    boolean success = carDAO.updateCar(car);
                    if (success) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_SUCCESS,
                                "Cập nhật thông tin xe thành công!");
                    } else {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR, "Cập nhật thất bại!");
                    }
                    response.sendRedirect(request.getContextPath() + "/vehicles");
                    break;
                }

                case "delete": {
                    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                    boolean success = carDAO.softDeleteCar(vehicleId, customerId);
                    if (success) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_SUCCESS, "Xóa xe thành công!");
                    } else {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR, "Xóa xe thất bại!");
                    }
                    response.sendRedirect(request.getContextPath() + "/vehicles");
                    break;
                }

                case "setDefault": {
                    int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                    boolean success = carDAO.setDefaultCar(vehicleId, customerId);
                    if (success) {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_SUCCESS,
                                "Đã thiết lập xe mặc định thành công!");
                    } else {
                        request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR,
                                "Thiết lập thất bại! Không tìm thấy xe.");
                    }
                    response.sendRedirect(request.getContextPath() + "/vehicles");
                    break;
                }

                default:
                    response.sendRedirect(request.getContextPath() + "/vehicles");
                    break;
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Lỗi format vehicleId", e);
            response.sendRedirect(request.getContextPath() + "/vehicles");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xử lý hành động xe", e);
            request.getSession().setAttribute(AppConstants.SESSION_MSG_ERROR, "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/vehicles");
        }
    }

    @Override
    public String getServletInfo() {
        return "RESTful Vehicle Controller";
    }
}
