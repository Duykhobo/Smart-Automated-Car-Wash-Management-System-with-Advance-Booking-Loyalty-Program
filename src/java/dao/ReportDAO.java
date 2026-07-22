package dao;

import utils.DBContext;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReportDAO {
    private static final Logger LOGGER = Logger.getLogger(ReportDAO.class.getName());

    public double getRevenueThisMonth() {
        String sql = "SELECT SUM(FinalPrice) AS Revenue FROM Bookings WHERE Status = 'Completed' AND MONTH(BookingDate) = MONTH(GETDATE()) AND YEAR(BookingDate) = YEAR(GETDATE())";
        return fetchDoubleValue(sql);
    }

    public double getRevenueLastMonth() {
        String sql = "SELECT SUM(FinalPrice) AS Revenue FROM Bookings WHERE Status = 'Completed' AND MONTH(BookingDate) = MONTH(DATEADD(month, -1, GETDATE())) AND YEAR(BookingDate) = YEAR(DATEADD(month, -1, GETDATE()))";
        return fetchDoubleValue(sql);
    }

    public int getWashesToday() {
        String sql = "SELECT COUNT(*) AS Total FROM Bookings WHERE Status = 'Completed' AND CAST(UpdatedAt AS DATE) = CAST(GETDATE() AS DATE)";
        return fetchIntValue(sql);
    }

    public int getWashesYesterday() {
        String sql = "SELECT COUNT(*) AS Total FROM Bookings WHERE Status = 'Completed' AND CAST(UpdatedAt AS DATE) = CAST(DATEADD(day, -1, GETDATE()) AS DATE)";
        return fetchIntValue(sql);
    }

    public int getPendingBookingsCount() {
        String sql = "SELECT COUNT(*) AS Total FROM Bookings WHERE Status = 'Pending'";
        return fetchIntValue(sql);
    }

    public Map<String, Double> getRevenueLast7Days() {
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        // Initialize map with 0.0 for the last 7 days
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");
        for (int i = 6; i >= 0; i--) {
            revenueMap.put(today.minusDays(i).format(formatter), 0.0);
        }

        String sql = "SELECT CAST(BookingDate AS DATE) as DateValue, SUM(FinalPrice) as Revenue " +
                     "FROM Bookings " +
                     "WHERE Status = 'Completed' AND BookingDate >= CAST(DATEADD(day, -6, GETDATE()) AS DATE) " +
                     "GROUP BY CAST(BookingDate AS DATE)";
        
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                Date sqlDate = rs.getDate("DateValue");
                double rev = rs.getDouble("Revenue");
                if (sqlDate != null) {
                    String dateStr = sqlDate.toLocalDate().format(formatter);
                    if (revenueMap.containsKey(dateStr)) {
                        revenueMap.put(dateStr, rev);
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching 7 days revenue", e);
        }
        return revenueMap;
    }

    private double fetchDoubleValue(String sql) {
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching double value", e);
        }
        return 0.0;
    }

    private int fetchIntValue(String sql) {
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching int value", e);
        }
        return 0;
    }
}
