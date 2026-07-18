package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dto.Booking;
import dto.BookingSlotCapacity;
import dto.Voucher;
import dto.BookingDetailDTO;
import utils.DBContext;

public class BookingDAO {

    private static final Logger LOGGER = Logger.getLogger(BookingDAO.class.getName());

    /**
     * Khởi tạo giao dịch đặt lịch mới (Booking Transaction)
     * Đây là hàm quan trọng nhất của Booking Engine. Nó gọi Stored Procedure: sp_CreateBookingTransaction.
     * Stored Procedure này đảm bảo an toàn về dữ liệu, chống Race Condition,
     * tự động cộng dồn số lượng đặt chỗ và tự đưa vào danh sách Waitlist nếu khung giờ đã đầy.
     * 
     * @param customerId ID của khách hàng
     * @param serviceId Gói dịch vụ đã chọn
     * @param vehicleId Xe sẽ rửa
     * @param voucherId Mã giảm giá (nếu có)
     * @param bookingDate Ngày rửa xe
     * @param scheduledTime Giờ rửa xe
     * @param originalPrice Giá gốc
     * @param discountAmount Số tiền giảm giá
     * @param finalPrice Giá cuối cùng phải trả
     * @return true nếu gọi Transaction thành công (Không phân biệt Pending hay Waitlisted)
     */
    public boolean createBookingTransaction(int customerId, String serviceIds, int vehicleId, Integer voucherId,
            Date bookingDate, Time scheduledTime,
            double originalPrice, double discountAmount, double finalPrice, int totalDurationMinutes) throws Exception {
        boolean success = false;
        String sql = "{CALL sp_CreateBookingTransaction(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try (Connection cn = DBContext.getConnection();
                CallableStatement cs = cn.prepareCall(sql)) {

            cs.setInt(1, customerId);
            cs.setString(2, serviceIds);
            cs.setInt(3, vehicleId);

            if (voucherId != null) {
                cs.setInt(4, voucherId);
            } else {
                cs.setNull(4, java.sql.Types.INTEGER);
            }

            cs.setDate(5, bookingDate);
            cs.setString(6, scheduledTime.toString());
            cs.setDouble(7, originalPrice);
            cs.setDouble(8, discountAmount);
            cs.setDouble(9, finalPrice);
            cs.setInt(10, totalDurationMinutes); // TotalDurationMinutes
            cs.setInt(11, new dao.SystemConfigDAO().getMaxSlotCapacity()); // DefaultMaxCapacity

            cs.execute();
            success = true;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating booking transaction", e);
            throw new Exception(e.getMessage());
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in createBookingTransaction", e);
            throw new Exception("Lỗi hệ thống khi đặt lịch.");
        }
        return success;
    }

    public List<dto.Booking> getUpcomingBookings(int customerId) {
        List<dto.Booking> list = new java.util.ArrayList<>();
        String sql = "SELECT b.*, v.LicensePlate, STUFF((SELECT ', ' + s.Name FROM BookingDetails bd JOIN Services s ON bd.ServiceID = s.ServiceID WHERE bd.BookingID = b.BookingID FOR XML PATH('')), 1, 2, '') AS ServiceNames, STUFF((SELECT ',' + CAST(ServiceID AS VARCHAR) FROM BookingDetails WHERE BookingID = b.BookingID FOR XML PATH('')), 1, 1, '') AS ServiceIDsStr, COALESCE(wr.ActualStartTime, CASE WHEN b.Status = 'InProgress' THEN b.UpdatedAt ELSE NULL END) AS ActualStartTime, COALESCE(wr.ActualEndTime, CASE WHEN b.Status = 'Completed' THEN b.UpdatedAt ELSE NULL END) AS ActualEndTime, b.UpdatedAt FROM Bookings b INNER JOIN Vehicles v ON b.VehicleID = v.VehicleID LEFT JOIN WashRecords wr ON b.BookingID = wr.BookingID WHERE b.CustomerID = ? AND b.Status IN ('Pending', 'Confirmed', 'InProgress', 'Waitlisted') ORDER BY b.BookingDate ASC, b.ScheduledTime ASC";
        try (Connection cn = DBContext.getConnection();
                java.sql.PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try ( java.sql.ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    dto.Booking b = new dto.Booking(
                            rs.getInt("BookingID"),
                            rs.getInt("CustomerID"),
                            rs.getString("ServiceNames"),
                            rs.getInt("VehicleID"),
                            rs.getObject("VoucherID") != null ? rs.getInt("VoucherID") : null,
                            rs.getString("LicensePlate"),
                            rs.getTimestamp("BookingDate"),
                            rs.getTimestamp("ScheduledTime"),
                            rs.getDouble("OriginalPrice"),
                            rs.getDouble("DiscountAmount"),
                            rs.getDouble("FinalPrice"),
                            rs.getString("PaymentMethod"),
                            rs.getString("PaymentStatus"),
                            rs.getString("Status"),
                            rs.getInt("PriorityScore"));
                    b.setServiceIdsStr(rs.getString("ServiceIDsStr"));
                    b.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    b.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                    b.setActualStartTime(rs.getTimestamp("ActualStartTime"));
                    b.setActualEndTime(rs.getTimestamp("ActualEndTime"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateBookingStatus(int bookingId, String newStatus) throws SQLException {
        boolean success = false;
        String sql = "UPDATE [Bookings] SET [Status] = ?, [UpdatedAt] = GETDATE() WHERE [BookingID] = ?";
        try (Connection cn = DBContext.getConnection();
                java.sql.PreparedStatement st = cn.prepareStatement(sql)) {

            st.setString(1, newStatus);
            st.setInt(2, bookingId);

            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating booking status", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in updateBookingStatus", e);
            throw new SQLException(e);
        }
        return success;
    }

    /**
     * Cập nhật thông tin Lịch Hẹn (Dời lịch).
     * Hàm này thực thi Transaction:
     * 1. Giảm số slot đã đặt ở giờ cũ.
     * 2. Kiểm tra sức chứa ở giờ mới. Nếu còn trống -> Tăng slot ở giờ mới và cập nhật trạng thái Pending.
     *    Nếu hết chỗ -> Chuyển trạng thái thành Waitlisted.
     * 3. Lưu giá tiền và thời gian mới vào bảng Bookings.
     *
     * @param bookingId ID của lịch hẹn cần dời
     * @param vehicleId Xe sử dụng
     * @param serviceId Dịch vụ sử dụng
     * @param oldDate Ngày cũ
     * @param oldTime Giờ cũ
     * @param newDate Ngày mới khách muốn dời
     * @param newTime Giờ mới khách muốn dời
     * @param originalPrice Giá gốc dịch vụ mới
     * @param discountAmount Số tiền được giảm giá
     * @param finalPrice Tổng tiền cuối cùng
     * @return true nếu thành công
     * @throws Exception nếu có lỗi CSDL
     */
    public boolean updateBookingTransaction(int bookingId, int vehicleId, String[] serviceIds,
                                            Date oldDate, Time oldTime, 
                                            Date newDate, Time newTime, 
                                            double originalPrice, double discountAmount, double finalPrice) throws Exception {
        boolean success = false;
        Connection cn = null;
        try {
            cn = DBContext.getConnection();
            cn.setAutoCommit(false); // Begin transaction

            // 1. Lấy thông tin lịch cũ và nhả toàn bộ slot cũ nếu đang Pending
            int oldTotalDuration = 30;
            String oldStatus = "Pending";
            String getOldSql = "SELECT b.Status, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration FROM [Bookings] b LEFT JOIN [BookingDetails] bd ON b.BookingID = bd.BookingID WHERE b.BookingID = ? GROUP BY b.Status";
            try (PreparedStatement stGetOld = cn.prepareStatement(getOldSql)) {
                stGetOld.setInt(1, bookingId);
                try (ResultSet rs = stGetOld.executeQuery()) {
                    if (rs.next()) {
                        oldStatus = rs.getString("Status");
                        oldTotalDuration = rs.getInt("TotalDuration");
                    }
                }
            }
            if ("Pending".equalsIgnoreCase(oldStatus)) {
                this.releaseSlots(cn, oldDate, oldTime, oldTotalDuration);
            }

            // 2. Lấy tổng thời gian mới
            int newTotalDuration = 30;
            if (serviceIds != null && serviceIds.length > 0) {
                String inClause = String.join(",", java.util.Collections.nCopies(serviceIds.length, "?"));
                String getNewDurSql = "SELECT ISNULL(SUM(DurationMinutes), 30) AS TotalDuration FROM [Services] WHERE ServiceID IN (" + inClause + ")";
                try (PreparedStatement stGetNewDur = cn.prepareStatement(getNewDurSql)) {
                    for (int i = 0; i < serviceIds.length; i++) {
                        stGetNewDur.setInt(i + 1, Integer.parseInt(serviceIds[i]));
                    }
                    try (ResultSet rs = stGetNewDur.executeQuery()) {
                        if (rs.next()) {
                            newTotalDuration = rs.getInt("TotalDuration");
                        }
                    }
                }
            }
            if (newTotalDuration == 0) newTotalDuration = 30;

            String targetStatus = "Pending";
            int newSlotsNeeded = (int) Math.ceil(newTotalDuration / 30.0);
            if (newSlotsNeeded < 1) newSlotsNeeded = 1;

            // 3. Kiểm tra tất cả các slot mới xem có bị đầy không (Waitlist)
            boolean isWaitlisted = false;
            String checkSql = "SELECT CurrentBooked, MaxCapacity FROM [BookingSlotCapacity] WITH (UPDLOCK) WHERE [SlotDate] = ? AND [TimeSlot] = CAST(? AS TIME)";
            
            for (int i = 0; i < newSlotsNeeded; i++) {
                java.time.LocalTime currentSlotTime = newTime.toLocalTime().plusMinutes(i * 30L);
                try (PreparedStatement stCheck = cn.prepareStatement(checkSql)) {
                    stCheck.setDate(1, newDate);
                    stCheck.setString(2, currentSlotTime.toString());
                    try (ResultSet rs = stCheck.executeQuery()) {
                        if (rs.next()) {
                            if (rs.getInt("CurrentBooked") >= rs.getInt("MaxCapacity")) {
                                isWaitlisted = true;
                                break;
                            }
                        }
                    }
                }
            }

            if (isWaitlisted) {
                targetStatus = "Waitlisted";
            } else {
                // 4. Giữ tất cả các slot mới
                for (int i = 0; i < newSlotsNeeded; i++) {
                    java.time.LocalTime currentSlotTime = newTime.toLocalTime().plusMinutes(i * 30L);
                    boolean exists = false;
                    try (PreparedStatement stCheck = cn.prepareStatement(checkSql)) {
                        stCheck.setDate(1, newDate);
                        stCheck.setString(2, currentSlotTime.toString());
                        try (ResultSet rs = stCheck.executeQuery()) {
                            if (rs.next()) exists = true;
                        }
                    }
                    
                    if (exists) {
                        String incSql = "UPDATE [BookingSlotCapacity] SET [CurrentBooked] = [CurrentBooked] + 1 WHERE [SlotDate] = ? AND [TimeSlot] = CAST(? AS TIME)";
                        try (PreparedStatement st3 = cn.prepareStatement(incSql)) {
                            st3.setDate(1, newDate);
                            st3.setString(2, currentSlotTime.toString());
                            st3.executeUpdate();
                        }
                    } else {
                        String insSql = "INSERT INTO [BookingSlotCapacity] (SlotDate, TimeSlot, MaxCapacity, CurrentBooked) VALUES (?, CAST(? AS TIME), ?, 1)";
                        try (PreparedStatement st4 = cn.prepareStatement(insSql)) {
                            st4.setDate(1, newDate);
                            st4.setString(2, currentSlotTime.toString());
                            st4.setInt(3, new dao.SystemConfigDAO().getMaxSlotCapacity());
                            st4.executeUpdate();
                        }
                    }
                }
            }

            // 5. Update Booking
            String updateBookingSql = "UPDATE [Bookings] SET [VehicleID] = ?, [BookingDate] = ?, [ScheduledTime] = ?, [OriginalPrice] = ?, [DiscountAmount] = ?, [FinalPrice] = ?, [Status] = ?, [UpdatedAt] = GETDATE() WHERE [BookingID] = ?";
            try (PreparedStatement st1 = cn.prepareStatement(updateBookingSql)) {
                st1.setInt(1, vehicleId);
                st1.setDate(2, newDate);
                st1.setString(3, newTime.toString());
                st1.setDouble(4, originalPrice);
                st1.setDouble(5, discountAmount);
                st1.setDouble(6, finalPrice);
                st1.setString(7, targetStatus);
                st1.setInt(8, bookingId);
                st1.executeUpdate();
            }

            if (serviceIds != null && serviceIds.length > 0) {
                try (PreparedStatement delSt = cn.prepareStatement("DELETE FROM [BookingDetails] WHERE [BookingID] = ?")) {
                    delSt.setInt(1, bookingId);
                    delSt.executeUpdate();
                }
                String insSql = "INSERT INTO [BookingDetails] (BookingID, ServiceID, Price, DurationMinutes) " +
                                "SELECT ?, ServiceID, " +
                                "ISNULL((SELECT sp.Price FROM ServicePrices sp " +
                                "        JOIN Vehicles v ON v.VehicleID = (SELECT VehicleID FROM Bookings WHERE BookingID = ?) " +
                                "        JOIN VehicleTypes vt ON v.VehicleTypeID = vt.VehicleTypeID " +
                                "        WHERE sp.ServiceID = [Services].ServiceID AND sp.VehicleSize = vt.VehicleSize), BasePrice), " +
                                "DurationMinutes FROM [Services] WHERE ServiceID = ?";
                try (PreparedStatement insSt = cn.prepareStatement(insSql)) {
                    for (String sid : serviceIds) {
                        insSt.setInt(1, bookingId);
                        insSt.setInt(2, bookingId);
                        insSt.setInt(3, Integer.parseInt(sid));
                        insSt.executeUpdate();
                    }
                }
            }

            cn.commit();
            success = true;
        } catch (Exception e) {
            if (cn != null) {
                try {
                    cn.rollback();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Rollback failed", ex);
                }
            }
            LOGGER.log(Level.SEVERE, "Error updating booking transaction", e);
            throw e;
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                    cn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Close connection failed", ex);
                }
            }
        }
        if (success) {
            this.autoPromoteWaitlist();
        }
        return success;
    }

    public boolean updateBookingTimeOnly(int bookingId, java.sql.Date newDate, java.sql.Time newTime) throws Exception {
        boolean success = false;
        Connection cn = null;
        try {
            cn = DBContext.getConnection();
            cn.setAutoCommit(false);

            int totalDuration = 30;
            String oldStatus = "Pending";
            java.sql.Date oldDate = null;
            java.sql.Time oldTime = null;
            
            String getOldSql = "SELECT b.Status, b.BookingDate, b.ScheduledTime, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration FROM [Bookings] b LEFT JOIN [BookingDetails] bd ON b.BookingID = bd.BookingID WHERE b.BookingID = ? GROUP BY b.Status, b.BookingDate, b.ScheduledTime";
            try (PreparedStatement stGetOld = cn.prepareStatement(getOldSql)) {
                stGetOld.setInt(1, bookingId);
                try (ResultSet rs = stGetOld.executeQuery()) {
                    if (rs.next()) {
                        oldStatus = rs.getString("Status");
                        oldDate = rs.getDate("BookingDate");
                        oldTime = rs.getTime("ScheduledTime");
                        totalDuration = rs.getInt("TotalDuration");
                    } else {
                        throw new Exception("Booking not found");
                    }
                }
            }
            
            if ("Pending".equalsIgnoreCase(oldStatus)) {
                this.releaseSlots(cn, oldDate, oldTime, totalDuration);
            }

            String targetStatus = "Pending";
            int newSlotsNeeded = (int) Math.ceil(totalDuration / 30.0);
            if (newSlotsNeeded < 1) newSlotsNeeded = 1;

            boolean isWaitlisted = false;
            String checkSql = "SELECT CurrentBooked, MaxCapacity FROM [BookingSlotCapacity] WITH (UPDLOCK) WHERE [SlotDate] = ? AND [TimeSlot] = CAST(? AS TIME)";
            
            for (int i = 0; i < newSlotsNeeded; i++) {
                java.time.LocalTime currentSlotTime = newTime.toLocalTime().plusMinutes(i * 30L);
                try (PreparedStatement stCheck = cn.prepareStatement(checkSql)) {
                    stCheck.setDate(1, newDate);
                    stCheck.setString(2, currentSlotTime.toString());
                    try (ResultSet rs = stCheck.executeQuery()) {
                        if (rs.next()) {
                            if (rs.getInt("CurrentBooked") >= rs.getInt("MaxCapacity")) {
                                isWaitlisted = true;
                                break;
                            }
                        }
                    }
                }
            }

            if (isWaitlisted) {
                targetStatus = "Waitlisted";
            } else {
                for (int i = 0; i < newSlotsNeeded; i++) {
                    java.time.LocalTime currentSlotTime = newTime.toLocalTime().plusMinutes(i * 30L);
                    boolean exists = false;
                    try (PreparedStatement stCheck = cn.prepareStatement(checkSql)) {
                        stCheck.setDate(1, newDate);
                        stCheck.setString(2, currentSlotTime.toString());
                        try (ResultSet rs = stCheck.executeQuery()) {
                            if (rs.next()) exists = true;
                        }
                    }
                    
                    if (exists) {
                        String incSql = "UPDATE [BookingSlotCapacity] SET [CurrentBooked] = [CurrentBooked] + 1 WHERE [SlotDate] = ? AND [TimeSlot] = CAST(? AS TIME)";
                        try (PreparedStatement stInc = cn.prepareStatement(incSql)) {
                            stInc.setDate(1, newDate);
                            stInc.setString(2, currentSlotTime.toString());
                            stInc.executeUpdate();
                        }
                    } else {
                        String insSql = "INSERT INTO [BookingSlotCapacity] (SlotDate, TimeSlot, MaxCapacity, CurrentBooked) "
                                + "VALUES (?, CAST(? AS TIME), CAST((SELECT ConfigValue FROM SystemConfig WHERE ConfigKey='MaxSlotsPerHalfHour') AS INT), 1)";
                        try (PreparedStatement stIns = cn.prepareStatement(insSql)) {
                            stIns.setDate(1, newDate);
                            stIns.setString(2, currentSlotTime.toString());
                            stIns.executeUpdate();
                        }
                    }
                }
            }

            String updateSql = "UPDATE [Bookings] SET BookingDate = ?, ScheduledTime = ?, Status = ?, UpdatedAt = GETDATE() WHERE BookingID = ?";
            try (PreparedStatement stUpdate = cn.prepareStatement(updateSql)) {
                stUpdate.setDate(1, newDate);
                stUpdate.setTime(2, newTime);
                stUpdate.setString(3, targetStatus);
                stUpdate.setInt(4, bookingId);
                int updatedRows = stUpdate.executeUpdate();
                if (updatedRows > 0) {
                    success = true;
                }
            }

            if (success) {
                cn.commit();
            } else {
                cn.rollback();
            }

        } catch (Exception e) {
            if (cn != null) {
                try {
                    cn.rollback();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Rollback failed", ex);
                }
            }
            throw e;
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                    cn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Close connection failed", ex);
                }
            }
        }
        if (success) {
            this.autoPromoteWaitlist();
        }
        return success;
    }

    /**
     * Hủy một lịch đặt và trả lại sức chứa (Slot)
     * Chỉ được phép hủy nếu trạng thái là Pending hoặc Waitlisted.
     * 
     * @param bookingId ID lịch đặt
     * @param customerId ID khách hàng (để verify quyền)
     * @return true nếu hủy thành công
     */
    public boolean cancelBookingTransaction(int bookingId, int customerId) {
        boolean success = false;
        String queryBooking = "SELECT b.BookingDate, b.ScheduledTime, b.Status, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration "
                + "FROM Bookings b LEFT JOIN BookingDetails bd ON b.BookingID = bd.BookingID "
                + "WHERE b.BookingID = ? AND b.CustomerID = ? "
                + "GROUP BY b.BookingDate, b.ScheduledTime, b.Status";
        String updateStatus = "UPDATE Bookings SET Status = 'Cancelled', UpdatedAt = GETDATE() WHERE BookingID = ?";
        String decreaseCapacity = "UPDATE BookingSlotCapacity SET CurrentBooked = CurrentBooked - 1 "
                + "WHERE SlotDate = ? AND TimeSlot = CAST(? AS TIME) AND CurrentBooked > 0";

        Connection cn = null;
        try {
            cn = DBContext.getConnection();
            cn.setAutoCommit(false);
            
            try (PreparedStatement pstGet = cn.prepareStatement(queryBooking)) {
                pstGet.setInt(1, bookingId);
                pstGet.setInt(2, customerId);
                try (ResultSet rs = pstGet.executeQuery()) {
                    if (rs.next()) {
                        String status = rs.getString("Status");
                        if (!"Pending".equalsIgnoreCase(status) && !"Waitlisted".equalsIgnoreCase(status)) {
                            return false; // Chỉ cho phép hủy Pending hoặc Waitlisted
                        }
                        Date bDate = rs.getDate("BookingDate");
                        Time bTime = rs.getTime("ScheduledTime");
                        
                        // Update Status sang Cancelled
                        try (PreparedStatement pstUpdate = cn.prepareStatement(updateStatus)) {
                            pstUpdate.setInt(1, bookingId);
                            int row = pstUpdate.executeUpdate();
                            if (row == 0) {
                                cn.rollback();
                                return false;
                            }
                        }
                        
                        // Nếu là Pending thì mới chiếm slot -> phải giải phóng TẤT CẢ slot
                        if ("Pending".equalsIgnoreCase(status)) {
                            int totalDuration = rs.getInt("TotalDuration");
                            releaseSlots(cn, bDate, bTime, totalDuration);
                        }
                        
                        cn.commit();
                        success = true;
                    }
                }
            }
        } catch (Exception e) {
            if (cn != null) {
                try {
                    cn.rollback();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Rollback cancelBooking failed", ex);
                }
            }
            LOGGER.log(Level.SEVERE, "Error in cancelBookingTransaction", e);
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                    cn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Close connection failed", ex);
                }
            }
        }
        if (success) {
            this.autoPromoteWaitlist();
        }
        return success;
    }

    public boolean adminCancelBookingTransaction(int bookingId, String finalStatus) {
        boolean success = false;
        String queryBooking = "SELECT b.BookingDate, b.ScheduledTime, b.Status, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration "
                + "FROM Bookings b LEFT JOIN BookingDetails bd ON b.BookingID = bd.BookingID "
                + "WHERE b.BookingID = ? "
                + "GROUP BY b.BookingDate, b.ScheduledTime, b.Status";
        String updateStatus = "UPDATE Bookings SET Status = ?, UpdatedAt = GETDATE() WHERE BookingID = ?";

        Connection cn = null;
        try {
            cn = DBContext.getConnection();
            cn.setAutoCommit(false);
            
            try (PreparedStatement pstGet = cn.prepareStatement(queryBooking)) {
                pstGet.setInt(1, bookingId);
                try (ResultSet rs = pstGet.executeQuery()) {
                    if (rs.next()) {
                        String status = rs.getString("Status");
                        if ("Completed".equalsIgnoreCase(status) || "Cancelled".equalsIgnoreCase(status) || "No Show".equalsIgnoreCase(status)) {
                            return false; // Already finished
                        }
                        Date bDate = rs.getDate("BookingDate");
                        Time bTime = rs.getTime("ScheduledTime");
                        
                        try (PreparedStatement pstUpdate = cn.prepareStatement(updateStatus)) {
                            pstUpdate.setString(1, finalStatus);
                            pstUpdate.setInt(2, bookingId);
                            int row = pstUpdate.executeUpdate();
                            if (row == 0) {
                                cn.rollback();
                                return false;
                            }
                        }
                        
                        // If it was taking up a slot, release it
                        if ("Pending".equalsIgnoreCase(status) || "Confirmed".equalsIgnoreCase(status) || "InProgress".equalsIgnoreCase(status)) {
                            int totalDuration = rs.getInt("TotalDuration");
                            releaseSlots(cn, bDate, bTime, totalDuration);
                        }
                        
                        cn.commit();
                        success = true;
                    }
                }
            }
        } catch (Exception e) {
            if (cn != null) {
                try {
                    cn.rollback();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Rollback adminCancelBooking failed", ex);
                }
            }
            LOGGER.log(Level.SEVERE, "Error in adminCancelBookingTransaction", e);
        } finally {
            if (cn != null) {
                try {
                    cn.setAutoCommit(true);
                    cn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Close connection failed", ex);
                }
            }
        }
        if (success) {
            this.autoPromoteWaitlist();
        }
        return success;
    }

    public dto.Booking getBookingById(int bookingId) throws SQLException {
        Booking booking = null;
        String sql = "SELECT b.*, v.LicensePlate, STUFF((SELECT ', ' + s.Name FROM BookingDetails bd JOIN Services s ON bd.ServiceID = s.ServiceID WHERE bd.BookingID = b.BookingID FOR XML PATH('')), 1, 2, '') AS ServiceNames FROM Bookings b INNER JOIN Vehicles v ON b.VehicleID = v.VehicleID WHERE b.BookingID = ?";
        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    booking = new dto.Booking(
                            rs.getInt("BookingID"),
                            rs.getInt("CustomerID"),
                            rs.getString("ServiceNames"),
                            rs.getInt("VehicleID"),
                            rs.getObject("VoucherID") != null ? rs.getInt("VoucherID") : null,
                            rs.getString("LicensePlate"),
                            rs.getTimestamp("BookingDate"),
                            rs.getTimestamp("ScheduledTime"),
                            rs.getDouble("OriginalPrice"),
                            rs.getDouble("DiscountAmount"),
                            rs.getDouble("FinalPrice"),
                            rs.getString("PaymentMethod"),
                            rs.getString("PaymentStatus"),
                            rs.getString("Status"),
                            rs.getInt("PriorityScore"));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching booking by ID", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getBookingById", e);
            throw new SQLException(e);
        }
        return booking;
    }

    public Voucher getActiveVoucherByCode(String voucherCode, int customerId) throws Exception {
        String sql = "SELECT VoucherID, CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status " +
                "FROM Vouchers " +
                "WHERE VoucherCode = ? AND CustomerID = ? AND Status = 'Unused' AND ExpiryDate >= GETDATE()";
        try (Connection cn = utils.DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, voucherCode);
            st.setInt(2, customerId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Voucher(
                            rs.getInt("VoucherID"),
                            rs.getInt("CustomerID"),
                            rs.getString("VoucherCode"),
                            rs.getString("RewardType"),
                            rs.getInt("PointsCost"),
                            rs.getTimestamp("ExpiryDate"),
                            rs.getString("Status"));
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi kiểm tra mã Voucher: " + e.getMessage(), e);
        }
        return null;
    }

    public List<BookingSlotCapacity> getSlotsByDate(Date date) throws Exception {
        List<BookingSlotCapacity> list = new ArrayList<>();
        String sql = "SELECT * FROM BookingSlotCapacity WHERE SlotDate = ?";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setDate(1, date);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BookingSlotCapacity slot = new BookingSlotCapacity(
                            rs.getInt("SlotID"),
                            rs.getDate("SlotDate"),
                            rs.getTime("TimeSlot"),
                            rs.getInt("MaxCapacity"),
                            rs.getInt("CurrentBooked"));
                    list.add(slot);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching slots by date", e);
            throw e;
        }
        return list;
    }

    public List<dto.Booking> getHistoryBookings(int customerId) {
        return getHistoryBookings(customerId, 1, 1000); // Default to a large number if not paginated
    }

    public List<dto.Booking> getHistoryBookings(int customerId, int page, int pageSize) {
        List<dto.Booking> list = new java.util.ArrayList<>();
        String sql = "WITH PagedBookings AS (SELECT b.*, v.LicensePlate, STUFF((SELECT ', ' + s.Name FROM BookingDetails bd JOIN Services s ON bd.ServiceID = s.ServiceID WHERE bd.BookingID = b.BookingID FOR XML PATH('')), 1, 2, '') AS ServiceNames, STUFF((SELECT ',' + CAST(ServiceID AS VARCHAR) FROM BookingDetails WHERE BookingID = b.BookingID FOR XML PATH('')), 1, 1, '') AS ServiceIDsStr, COALESCE(wr.ActualStartTime, CASE WHEN b.Status IN ('Completed', 'InProgress') THEN b.ScheduledTime ELSE NULL END) AS ActualStartTime, COALESCE(wr.ActualEndTime, CASE WHEN b.Status = 'Completed' THEN b.UpdatedAt ELSE NULL END) AS ActualEndTime, ROW_NUMBER() OVER (ORDER BY b.BookingDate DESC, b.ScheduledTime DESC) AS RowNum FROM Bookings b INNER JOIN Vehicles v ON b.VehicleID = v.VehicleID LEFT JOIN WashRecords wr ON b.BookingID = wr.BookingID WHERE b.CustomerID = ? AND b.Status IN ('Completed', 'Cancelled', 'No Show')) SELECT * FROM PagedBookings WHERE RowNum > ? AND RowNum <= ?";
        try (Connection cn = DBContext.getConnection();
                java.sql.PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, ((page - 1) * pageSize) + pageSize);
            try (java.sql.ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    dto.Booking b = new dto.Booking(
                            rs.getInt("BookingID"),
                            rs.getInt("CustomerID"),
                            rs.getString("ServiceNames"),
                            rs.getInt("VehicleID"),
                            rs.getObject("VoucherID") != null ? rs.getInt("VoucherID") : null,
                            rs.getString("LicensePlate"),
                            rs.getTimestamp("BookingDate"),
                            rs.getTimestamp("ScheduledTime"),
                            rs.getDouble("OriginalPrice"),
                            rs.getDouble("DiscountAmount"),
                            rs.getDouble("FinalPrice"),
                            rs.getString("PaymentMethod"),
                            rs.getString("PaymentStatus"),
                            rs.getString("Status"),
                            rs.getInt("PriorityScore"));
                    b.setServiceIdsStr(rs.getString("ServiceIDsStr"));
                    b.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    b.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                    b.setActualStartTime(rs.getTimestamp("ActualStartTime"));
                    b.setActualEndTime(rs.getTimestamp("ActualEndTime"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalHistoryBookings(int customerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Bookings WHERE CustomerID = ? AND Status IN ('Completed', 'Cancelled', 'No Show')";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getTotalWashes(int customerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Bookings WHERE CustomerID = ? AND Status = 'Completed'";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting total washes", e);
        }
        return count;
    }

    public double getTotalSpend(int customerId) {
        double total = 0;
        String sql = "SELECT SUM(FinalPrice) FROM Bookings WHERE CustomerID = ? AND Status = 'Completed'";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error summing total spend", e);
        }
        return total;
    }

    public boolean updatePaymentStatus(int bookingId, String status) throws SQLException {
        boolean success = false;
        String sql = "UPDATE [Bookings] SET [PaymentStatus] = ?, [UpdatedAt] = GETDATE() WHERE [BookingID] = ?";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
             
            st.setString(1, status);
            st.setInt(2, bookingId);
            int rows = st.executeUpdate();
            if (rows > 0) success = true;
        }
        return success;
    }
    
    public void releaseSlots(Connection cn, Date bDate, Time bTime, int totalDuration) throws SQLException {
        String decreaseCapacity = "UPDATE BookingSlotCapacity SET CurrentBooked = CurrentBooked - 1 "
                + "WHERE SlotDate = ? AND TimeSlot = CAST(? AS TIME) AND CurrentBooked > 0";
        int slotsNeeded = (int) Math.ceil(totalDuration / 30.0);
        if (slotsNeeded < 1) slotsNeeded = 1;
        try (PreparedStatement pstCap = cn.prepareStatement(decreaseCapacity)) {
            for (int i = 0; i < slotsNeeded; i++) {
                java.time.LocalTime slotTime = bTime.toLocalTime().plusMinutes(i * 30L);
                pstCap.setDate(1, bDate);
                pstCap.setString(2, slotTime.toString());
                pstCap.executeUpdate();
            }
        }
    }

    public boolean completeBookingTransaction(int bookingId) throws SQLException {
        boolean success = false;
        String query = "SELECT b.BookingDate, b.ScheduledTime, b.Status, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration "
                     + "FROM Bookings b LEFT JOIN BookingDetails bd ON b.BookingID = bd.BookingID "
                     + "WHERE b.BookingID = ? "
                     + "GROUP BY b.BookingDate, b.ScheduledTime, b.Status";
        String sql = "UPDATE [Bookings] SET [Status] = 'Completed', [UpdatedAt] = GETDATE() WHERE [BookingID] = ?";
        
        try (Connection cn = DBContext.getConnection()) {
            cn.setAutoCommit(false);
            try (PreparedStatement pstGet = cn.prepareStatement(query)) {
                pstGet.setInt(1, bookingId);
                try (ResultSet rs = pstGet.executeQuery()) {
                    if (rs.next()) {
                        String currentStatus = rs.getString("Status");
                        if (!"Completed".equalsIgnoreCase(currentStatus) && !"Cancelled".equalsIgnoreCase(currentStatus) && !"No Show".equalsIgnoreCase(currentStatus)) {
                            try (PreparedStatement st = cn.prepareStatement(sql)) {
                                st.setInt(1, bookingId);
                                int rows = st.executeUpdate();
                                if (rows > 0) {
                                    Date bDate = rs.getDate("BookingDate");
                                    Time bTime = rs.getTime("ScheduledTime");
                                    int totalDuration = rs.getInt("TotalDuration");
                                    if ("Pending".equalsIgnoreCase(currentStatus) || "Confirmed".equalsIgnoreCase(currentStatus) || "InProgress".equalsIgnoreCase(currentStatus)) {
                                        releaseSlots(cn, bDate, bTime, totalDuration);
                                    }
                                    success = true;
                                }
                            }
                        }
                    }
                }
            }
            if (success) {
                cn.commit();
            } else {
                cn.rollback();
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Lỗi khi completeBookingTransaction", ex);
            throw ex;
        }
        if (success) {
            this.autoPromoteWaitlist();
        }
        return success;
    }

    public boolean isSlotAvailable(Date date, Time time) throws SQLException {
        boolean isAvailable = false;

        String sql = "SELECT (MaxCapacity - CurrentBooked) AS AvailableSlots " +
                "FROM BookingSlotCapacity " +
                "WHERE SlotDate = ? AND TimeSlot = ?";
        try (Connection cn = DBContext.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            st.setDate(1, date);
            st.setString(2, time.toString());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int available = rs.getInt("AvailableSlots");
                    if (available > 0) {
                        isAvailable = true;
                    }
                } else {
                    isAvailable = true;
                }
            }
        }
        return isAvailable;
    }

    /**
     * Lấy trạng thái của lần đặt lịch gần nhất (dùng để fix Race Condition)
     */
    public String getLatestBookingStatus(int customerId, Date date, Time time) throws SQLException {
        String status = null;
        String sql = "SELECT TOP 1 Status FROM Bookings WHERE CustomerID = ? AND BookingDate = ? AND ScheduledTime = ? ORDER BY BookingID DESC";
        try (Connection cn = DBContext.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            st.setDate(2, date);
            st.setString(3, time.toString());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    status = rs.getString("Status");
                }
            }
        }
        return status;
    }

    /**
     * Tự động quét và hủy các lịch đặt quá hạn 15 phút chưa Check-in.
     */
    public void autoCancelExpiredBookings() {
        String getExpired = "SELECT b.BookingID, b.BookingDate, b.ScheduledTime, b.Status, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration " +
                     "FROM Bookings b LEFT JOIN BookingDetails bd ON b.BookingID = bd.BookingID " +
                     "WHERE b.Status IN ('Pending', 'Waitlisted') " +
                     "AND CAST(CAST(b.BookingDate AS VARCHAR) + ' ' + CAST(b.ScheduledTime AS VARCHAR) AS DATETIME2) <= DATEADD(MINUTE, -15, GETDATE()) " +
                     "GROUP BY b.BookingID, b.BookingDate, b.ScheduledTime, b.Status";
                     
        String updateStatus = "UPDATE Bookings SET Status = 'Cancelled', UpdatedAt = GETDATE() WHERE BookingID = ?";

        try (Connection cn = DBContext.getConnection()) {
            cn.setAutoCommit(false);
            
            try (PreparedStatement stFetch = cn.prepareStatement(getExpired);
                 PreparedStatement stUpdate = cn.prepareStatement(updateStatus)) {
                 
                ResultSet rs = stFetch.executeQuery();
                int rowsAffected = 0;
                
                while (rs.next()) {
                    int bookingId = rs.getInt("BookingID");
                    String status = rs.getString("Status");
                    Date bDate = rs.getDate("BookingDate");
                    Time bTime = rs.getTime("ScheduledTime");
                    int totalDuration = rs.getInt("TotalDuration");
                    
                    stUpdate.setInt(1, bookingId);
                    if (stUpdate.executeUpdate() > 0) {
                        rowsAffected++;
                        if ("Pending".equalsIgnoreCase(status) || "Confirmed".equalsIgnoreCase(status) || "InProgress".equalsIgnoreCase(status)) {
                            releaseSlots(cn, bDate, bTime, totalDuration);
                        }
                    }
                }
                cn.commit();
                
                if (rowsAffected > 0) {
                    LOGGER.info("Hệ thống đã tự động hủy " + rowsAffected + " lịch hẹn quá hạn 15 phút và nhả slot tương ứng.");
                }
            } catch (SQLException ex) {
                cn.rollback();
                throw ex;
            } finally {
                cn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi Background Job khi quét lịch hẹn quá hạn", e);
        }
    }

    public void autoPromoteWaitlist() {
        String queryWaitlisted = "SELECT b.BookingID, b.BookingDate, b.ScheduledTime, b.PriorityScore, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration " +
                "FROM Bookings b LEFT JOIN BookingDetails bd ON b.BookingID = bd.BookingID " +
                "WHERE b.Status = 'Waitlisted' AND (b.BookingDate > CAST(GETDATE() AS DATE) OR (b.BookingDate = CAST(GETDATE() AS DATE) AND b.ScheduledTime > CAST(GETDATE() AS TIME))) " +
                "GROUP BY b.BookingID, b.BookingDate, b.ScheduledTime, b.PriorityScore " +
                "ORDER BY b.BookingDate ASC, b.ScheduledTime ASC, b.PriorityScore DESC";
        
        String checkSql = "SELECT CurrentBooked, MaxCapacity FROM [BookingSlotCapacity] WHERE [SlotDate] = ? AND [TimeSlot] = CAST(? AS TIME)";
        String incSql = "UPDATE [BookingSlotCapacity] SET [CurrentBooked] = [CurrentBooked] + 1 WHERE [SlotDate] = ? AND [TimeSlot] = CAST(? AS TIME)";
        String insSql = "INSERT INTO [BookingSlotCapacity] (SlotDate, TimeSlot, MaxCapacity, CurrentBooked) VALUES (?, CAST(? AS TIME), ?, 1)";
        String updateStatus = "UPDATE Bookings SET Status = 'Pending', UpdatedAt = GETDATE() WHERE BookingID = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement stFetch = cn.prepareStatement(queryWaitlisted)) {
             
            try (ResultSet rs = stFetch.executeQuery()) {
                while (rs.next()) {
                    int bookingId = rs.getInt("BookingID");
                    Date bDate = rs.getDate("BookingDate");
                    Time bTime = rs.getTime("ScheduledTime");
                    int totalDuration = rs.getInt("TotalDuration");
                    int slotsNeeded = (int) Math.ceil(totalDuration / 30.0);
                    if (slotsNeeded < 1) slotsNeeded = 1;

                    boolean canPromote = true;
                    java.time.LocalTime bLocalTime = bTime.toLocalTime();
                    
                    // Check capacity
                    for (int i = 0; i < slotsNeeded; i++) {
                        java.time.LocalTime slotTime = bLocalTime.plusMinutes(i * 30L);
                        try (PreparedStatement stCheck = cn.prepareStatement(checkSql)) {
                            stCheck.setDate(1, bDate);
                            stCheck.setString(2, slotTime.toString());
                            try (ResultSet rsCheck = stCheck.executeQuery()) {
                                if (rsCheck.next()) {
                                    int current = rsCheck.getInt("CurrentBooked");
                                    int max = rsCheck.getInt("MaxCapacity");
                                    if (current >= max) {
                                        canPromote = false;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    if (canPromote) {
                        // Promote it! Update capacities
                        for (int i = 0; i < slotsNeeded; i++) {
                            java.time.LocalTime slotTime = bLocalTime.plusMinutes(i * 30L);
                            boolean exists = false;
                            try (PreparedStatement stCheck = cn.prepareStatement(checkSql)) {
                                stCheck.setDate(1, bDate);
                                stCheck.setString(2, slotTime.toString());
                                try (ResultSet rsCheck = stCheck.executeQuery()) {
                                    if (rsCheck.next()) exists = true;
                                }
                            }
                            if (exists) {
                                try (PreparedStatement stInc = cn.prepareStatement(incSql)) {
                                    stInc.setDate(1, bDate);
                                    stInc.setString(2, slotTime.toString());
                                    stInc.executeUpdate();
                                }
                            } else {
                                try (PreparedStatement stIns = cn.prepareStatement(insSql)) {
                                    stIns.setDate(1, bDate);
                                    stIns.setString(2, slotTime.toString());
                                    stIns.setInt(3, new dao.SystemConfigDAO().getMaxSlotCapacity());
                                    stIns.executeUpdate();
                                }
                            }
                        }
                        
                        try (PreparedStatement stUpd = cn.prepareStatement(updateStatus)) {
                            stUpd.setInt(1, bookingId);
                            stUpd.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error auto-promoting waitlist", e);
        }
    }

    public boolean isVehicleDoubleBooked(int vehicleId, Date bookingDate, Time scheduledTime, int totalDurationMinutes) {
        return isVehicleDoubleBooked(vehicleId, bookingDate, scheduledTime, totalDurationMinutes, -1);
    }

    public boolean isVehicleDoubleBooked(int vehicleId, Date bookingDate, Time scheduledTime, int totalDurationMinutes, int excludeBookingId) {
        boolean isDoubleBooked = false;
        String sql = "SELECT b.BookingID, b.ScheduledTime, ISNULL(SUM(bd.DurationMinutes), 30) AS TotalDuration " +
                     "FROM Bookings b LEFT JOIN BookingDetails bd ON b.BookingID = bd.BookingID " +
                     "WHERE b.VehicleID = ? AND b.BookingDate = ? AND b.Status IN ('Pending', 'Confirmed', 'Waitlisted', 'InProgress') ";
        
        if (excludeBookingId > 0) {
            sql += "AND b.BookingID != ? ";
        }
        sql += "GROUP BY b.BookingID, b.ScheduledTime";
        
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, vehicleId);
            st.setDate(2, bookingDate);
            if (excludeBookingId > 0) {
                st.setInt(3, excludeBookingId);
            }
            try (ResultSet rs = st.executeQuery()) {
                java.time.LocalTime reqStart = scheduledTime.toLocalTime();
                java.time.LocalTime reqEnd = reqStart.plusMinutes(totalDurationMinutes);

                while (rs.next()) {
                    java.time.LocalTime existingStart = rs.getTime("ScheduledTime").toLocalTime();
                    int duration = rs.getInt("TotalDuration");
                    java.time.LocalTime existingEnd = existingStart.plusMinutes(duration);

                    if (reqStart.isBefore(existingEnd) && existingStart.isBefore(reqEnd)) {
                        isDoubleBooked = true;
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking vehicle double booking", e);
        }
        return isDoubleBooked;
    }

    /**
     * Kiểm tra xem một chiếc xe (Vehicle) có đang vướng lịch hẹn nào chưa hoàn thành hay không.
     * Hàm này được gọi khi khách hàng muốn xóa xe. Nếu có lịch Pending, Confirmed, InProgress hoặc Waitlisted, sẽ chặn xóa.
     * 
     * @param vehicleId ID của xe cần kiểm tra
     * @return true nếu xe đang có lịch hẹn chờ xử lý, false nếu an toàn để xóa.
     */
    public boolean hasActiveBookings(int vehicleId) {
        boolean hasActive = false;
        String sql = "SELECT TOP 1 1 FROM Bookings WHERE VehicleID = ? AND Status IN ('Pending', 'Confirmed', 'InProgress', 'Waitlisted')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, vehicleId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    hasActive = true;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking active bookings for vehicle", e);
        }
        return hasActive;
    }

    public List<BookingDetailDTO> getAdminBookings(String dateStr, String statusFilter, String searchKeyword, int page, int pageSize) {
        List<BookingDetailDTO> list = new ArrayList<>();
        java.sql.Date sqlDate = null;
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                sqlDate = java.sql.Date.valueOf(dateStr);
            } catch (IllegalArgumentException e) {
                return list; // Invalid date format
            }
        }

        StringBuilder sql = new StringBuilder(
            "WITH PagedBookings AS ( " +
            "SELECT b.BookingID, c.FullName, c.Phone AS PhoneNumber, v.LicensePlate, " +
            "b.BookingDate, b.ScheduledTime, " +
            "(SELECT STUFF((SELECT ', ' + s.Name FROM BookingDetails bd JOIN Services s ON bd.ServiceID = s.ServiceID WHERE bd.BookingID = b.BookingID FOR XML PATH('')), 1, 2, '')) AS ServiceName, " +
            "b.Status, " +
            "ROW_NUMBER() OVER (ORDER BY b.BookingDate ASC, b.ScheduledTime ASC) AS RowNum " +
            "FROM Bookings b " +
            "JOIN Customers c ON b.CustomerID = c.CustomerID " +
            "JOIN Vehicles v ON b.VehicleID = v.VehicleID " +
            "WHERE 1=1 "
        );

        if (sqlDate != null) {
            sql.append("AND b.BookingDate = ? ");
        }
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("All")) {
            sql.append("AND b.Status = ? ");
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append("AND (c.Phone LIKE ? OR v.LicensePlate LIKE ?) ");
        }
        
        sql.append(") SELECT * FROM PagedBookings WHERE RowNum > ? AND RowNum <= ?");

        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql.toString())) {
             
            int paramIndex = 1;
            if (sqlDate != null) {
                st.setDate(paramIndex++, sqlDate);
            }
            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("All")) {
                st.setString(paramIndex++, statusFilter);
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                String searchPattern = "%" + searchKeyword.trim() + "%";
                st.setString(paramIndex++, searchPattern);
                st.setString(paramIndex++, searchPattern);
            }
            
            st.setInt(paramIndex++, (page - 1) * pageSize);
            st.setInt(paramIndex++, page * pageSize);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BookingDetailDTO dto = new BookingDetailDTO();
                    dto.setBookingId(rs.getInt("BookingID"));
                    dto.setCustomerName(rs.getString("FullName"));
                    dto.setCustomerPhone(rs.getString("PhoneNumber"));
                    dto.setVehiclePlate(rs.getString("LicensePlate"));
                    dto.setBookingDate(rs.getTimestamp("BookingDate"));
                    dto.setScheduledTime(rs.getTimestamp("ScheduledTime"));
                    dto.setServiceName(rs.getString("ServiceName"));
                    dto.setStatus(rs.getString("Status"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalAdminBookings(String dateStr, String statusFilter, String searchKeyword) {
        int total = 0;
        java.sql.Date sqlDate = null;
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                sqlDate = java.sql.Date.valueOf(dateStr);
            } catch (IllegalArgumentException e) {
                return 0; // Invalid date format
            }
        }

        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM Bookings b " +
            "JOIN Customers c ON b.CustomerID = c.CustomerID " +
            "JOIN Vehicles v ON b.VehicleID = v.VehicleID " +
            "WHERE 1=1 "
        );
        if (sqlDate != null) {
            sql.append("AND b.BookingDate = ? ");
        }
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("All")) {
            sql.append("AND b.Status = ? ");
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append("AND (c.Phone LIKE ? OR v.LicensePlate LIKE ?) ");
        }

        try (Connection conn = DBContext.getConnection();
             PreparedStatement st = conn.prepareStatement(sql.toString())) {
             
            int paramIndex = 1;
            if (sqlDate != null) {
                st.setDate(paramIndex++, sqlDate);
            }
            if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equalsIgnoreCase("All")) {
                st.setString(paramIndex++, statusFilter);
            }
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                String searchPattern = "%" + searchKeyword.trim() + "%";
                st.setString(paramIndex++, searchPattern);
                st.setString(paramIndex++, searchPattern);
            }
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
