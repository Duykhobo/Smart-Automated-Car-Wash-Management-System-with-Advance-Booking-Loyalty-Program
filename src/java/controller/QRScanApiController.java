package controller;

import dao.BookingDAO;
import dto.Booking;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "QRScanApiController", urlPatterns = {"/api/scan-qr"})
public class QRScanApiController extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            // In a real application, check for Admin/Staff session here
            
            String bookingIdStr = request.getParameter("bookingId");
            String confirmPaymentStr = request.getParameter("confirmPayment");
            boolean forceConfirmPayment = "true".equals(confirmPaymentStr);
            
            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                out.print("{\"status\":\"error\",\"message\":\"Thieu ma Booking ID\"}");
                return;
            }
            
            try {
                int bookingId = Integer.parseInt(bookingIdStr.trim());
                Booking booking = bookingDAO.getBookingById(bookingId);
                
                if (booking == null) {
                    out.print("{\"status\":\"error\",\"message\":\"Khong tim thay lich hen nay (Not found).\"}");
                    return;
                }
                
                String currentStatus = booking.getStatus();
                String paymentMethod = booking.getPaymentMethod();
                String paymentStatus = booking.getPaymentStatus();
                
                if ("Pending".equals(currentStatus)) {
                    // Logic Lựa chọn 1: Thu tiền TRƯỚC
                    dao.CustomerDAO customerDAO = new dao.CustomerDAO();
                    dto.Customer customer = customerDAO.getCustomerById(booking.getCustomerId());
                    String customerName = (customer != null) ? customer.getFullName() : "Khách hàng";

                    if ("Cash".equals(paymentMethod) && "Unpaid".equals(paymentStatus) && !forceConfirmPayment) {
                        // Yêu cầu thu tiền mặt
                        String safeCustomerName = customerName != null ? customerName.replace("\"", "\\\"") : "Khách hàng";
                        String safePlate = booking.getLicensePlate() != null ? booking.getLicensePlate().replace("\"", "\\\"") : "";
                        String safeService = booking.getServiceNames() != null ? booking.getServiceNames().replace("\"", "\\\"") : "";
                        
                        out.print("{\"status\":\"require_payment\","
                                + "\"amount\":" + (booking.getFinalPrice() != null ? booking.getFinalPrice() : 0) + ","
                                + "\"customerName\":\"" + safeCustomerName + "\","
                                + "\"vehiclePlate\":\"" + safePlate + "\","
                                + "\"serviceName\":\"" + safeService + "\""
                                + "}");
                        return;
                    }
                    
                    // Nếu đã thanh toán Online, hoặc vừa mới xác nhận thu tiền mặt xong
                    if (forceConfirmPayment) {
                        bookingDAO.updatePaymentStatus(bookingId, "Paid");
                    }
                    
                    boolean success = bookingDAO.updateBookingStatus(bookingId, "Confirmed");
                    if (success) {
                        out.print("{\"status\":\"success\",\"message\":\"Check-in thanh cong!\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"message\":\"Update status failed.\"}");
                    }
                } else if ("Confirmed".equals(currentStatus)) {
                    out.print("{\"status\":\"error\",\"message\":\"Xe nay da check-in roi (Already Confirmed).\"}");
                } else if ("InProgress".equals(currentStatus)) {
                    out.print("{\"status\":\"error\",\"message\":\"Xe dang duoc rua (In Progress).\"}");
                } else {
                    if ("Completed".equals(currentStatus)) {
                        out.print("{\"status\":\"error\",\"message\":\"Lich hen da hoan thanh (Completed).\"}");
                    } else if ("Cancelled".equals(currentStatus)) {
                        out.print("{\"status\":\"error\",\"message\":\"Lich hen nay da bi huy (Cancelled).\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"message\":\"Trang thai hien tai (" + currentStatus + ") khong cho phep Check-in.\"}");
                    }
                }
                
            } catch (NumberFormatException e) {
                out.print("{\"status\":\"error\",\"message\":\"Ma Booking ID khong hop le (Invalid ID).\"}");
            } catch (SQLException ex) {
                Logger.getLogger(QRScanApiController.class.getName()).log(Level.SEVERE, null, ex);
                String safeEx = ex.getMessage() != null ? ex.getMessage().replace("\"", "\\\"").replace("\n", " ") : "Unknown Error";
                out.print("{\"status\":\"error\",\"message\":\"DB Error: " + safeEx + "\"}");
            }
        }
    }
}

