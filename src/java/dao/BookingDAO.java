package dao;

import dto.Booking;
import dto.Voucher;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;
import utils.DBContext;

public class BookingDAO {
    private static final Logger LOGGER = Logger.getLogger(BookingDAO.class.getName());

    public boolean createBookingTransaction(int customerId, int serviceId, int vehicleId, Integer voucherId,
                                            Date bookingDate, Time scheduledTime,
                                            double originalPrice, double discountAmount, double finalPrice) throws Exception {
        boolean success = false;
        String sql = "{CALL sp_CreateBookingTransaction(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try (Connection cn = DBContext.getConnection();
             CallableStatement cs = cn.prepareCall(sql)) {

            cs.setInt(1, customerId);
            cs.setInt(2, serviceId);
            cs.setInt(3, vehicleId);
            
            if (voucherId != null) {
                cs.setInt(4, voucherId);
            } else {
                cs.setNull(4, java.sql.Types.INTEGER);
            }
            
            cs.setDate(5, bookingDate);
            cs.setTime(6, scheduledTime);
            cs.setDouble(7, originalPrice);
            cs.setDouble(8, discountAmount);
            cs.setDouble(9, finalPrice);
            cs.setInt(10, 3); // DefaultMaxCapacity

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
        String sql = "SELECT b.*, v.LicensePlate FROM Bookings b INNER JOIN Vehicles v ON b.VehicleID = v.VehicleID WHERE b.CustomerID = ? AND b.Status IN ('Pending', 'Confirmed') ORDER BY b.BookingDate ASC, b.ScheduledTime ASC";
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try (java.sql.ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(new dto.Booking(
                        rs.getInt("BookingID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("ServiceID"),
                        rs.getObject("VoucherID") != null ? rs.getInt("VoucherID") : null,
                        rs.getString("LicensePlate"),
                        rs.getTimestamp("BookingDate"),
                        rs.getTimestamp("ScheduledTime"),
                        rs.getDouble("OriginalPrice"),
                        rs.getDouble("DiscountAmount"),
                        rs.getDouble("FinalPrice"),
                        rs.getString("Status"),
                        rs.getInt("PriorityScore")
                    ));
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

    public dto.Booking getBookingById(int bookingId) throws SQLException {
        Booking booking = null;
        String sql = "SELECT b.*, v.LicensePlate FROM Bookings b INNER JOIN Vehicles v ON b.VehicleID = v.VehicleID WHERE b.BookingID = ?";
        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    booking = new dto.Booking(
                        rs.getInt("BookingID"),
                        rs.getInt("CustomerID"),
                        rs.getInt("ServiceID"),
                        rs.getObject("VoucherID") != null ? rs.getInt("VoucherID") : null,
                        rs.getString("LicensePlate"),
                        rs.getTimestamp("BookingDate"),
                        rs.getTimestamp("ScheduledTime"),
                        rs.getDouble("OriginalPrice"),
                        rs.getDouble("DiscountAmount"),
                        rs.getDouble("FinalPrice"),
                        rs.getString("Status"),
                        rs.getInt("PriorityScore")
                    );
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
                    rs.getString("Status")
                );
            }
        }
    } catch (SQLException e) {
        throw new Exception("Lỗi khi kiểm tra mã Voucher: " + e.getMessage());
    }
    return null;
}
}
