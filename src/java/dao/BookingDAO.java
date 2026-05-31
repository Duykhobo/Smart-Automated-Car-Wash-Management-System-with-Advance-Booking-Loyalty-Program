package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
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
}
