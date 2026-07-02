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

@WebServlet(name = "QRScanServlet", urlPatterns = {"/api/scan-qr"})
public class QRScanServlet extends HttpServlet {

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
                out.print("{\"status\":\"error\",\"message\":\"Thiếu mã Booking ID\"}");
                return;
            }
            
            try {
                int bookingId = Integer.parseInt(bookingIdStr.trim());
                Booking booking = bookingDAO.getBookingById(bookingId);
                
                if (booking == null) {
                    out.print("{\"status\":\"error\",\"message\":\"Không tìm thấy lịch hẹn này trong hệ thống.\"}");
                    return;
                }
                
                String currentStatus = booking.getStatus();
                String paymentMethod = booking.getPaymentMethod();
                String paymentStatus = booking.getPaymentStatus();
                
                if ("Pending".equals(currentStatus) || "Confirmed".equals(currentStatus)) {
                    // Logic Lựa chọn 1: Thu tiền TRƯỚC
                    if ("Cash".equals(paymentMethod) && "Unpaid".equals(paymentStatus) && !forceConfirmPayment) {
                        // Yêu cầu thu tiền mặt
                        out.print("{\"status\":\"require_payment\",\"amount\":" + booking.getFinalPrice() + "}");
                        return;
                    }
                    
                    // Nếu đã thanh toán Online, hoặc vừa mới xác nhận thu tiền mặt xong
                    if (forceConfirmPayment) {
                        bookingDAO.updatePaymentStatus(bookingId, "Paid");
                    }
                    
                    boolean success = bookingDAO.updateBookingStatus(bookingId, "InProgress");
                    if (success) {
                        out.print("{\"status\":\"success\",\"message\":\"Check-in thành công! Xe đang được rửa (InProgress).\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"message\":\"Lỗi cập nhật trạng thái.\"}");
                    }
                } else if ("InProgress".equals(currentStatus)) {
                    // Xe đã rửa xong
                    boolean success = bookingDAO.completeBookingTransaction(bookingId);
                    if (success) {
                        out.print("{\"status\":\"success\",\"message\":\"Tuyệt vời! Đã hoàn thành (Completed) và xe sẵn sàng giao khách.\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"message\":\"Lỗi cập nhật trạng thái.\"}");
                    }
                } else {
                    // Cac trang thai khac nhu Cancelled, NoShow, Completed, Waitlisted
                    if ("Completed".equals(currentStatus)) {
                        out.print("{\"status\":\"error\",\"message\":\"Lịch hẹn này đã hoàn thành trước đó rồi.\"}");
                    } else if ("Cancelled".equals(currentStatus)) {
                        out.print("{\"status\":\"error\",\"message\":\"Lịch hẹn này đã bị Hủy, mã QR không còn hiệu lực.\"}");
                    } else {
                        out.print("{\"status\":\"error\",\"message\":\"Trạng thái hiện tại (" + currentStatus + ") không cho phép Check-in.\"}");
                    }
                }
                
            } catch (NumberFormatException e) {
                out.print("{\"status\":\"error\",\"message\":\"Mã Booking ID không hợp lệ.\"}");
            } catch (SQLException ex) {
                Logger.getLogger(QRScanServlet.class.getName()).log(Level.SEVERE, null, ex);
                out.print("{\"status\":\"error\",\"message\":\"Lỗi cơ sở dữ liệu.\"}");
            }
        }
    }
}
