/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBContext;

public class ReportDAO {

    private static final Logger LOGGER = Logger.getLogger(ReportDAO.class.getName());

    public double getTodayTotalRevenue() {
        double total = 0;
        String sql = "SELECT ISNULL(SUM(FinalPrice), 0) FROM Bookings "
                + "WHERE CAST(BookingDate AS DATE) = CAST(GETDATE() AS DATE) "
                + "AND Status = 'Completed'";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement st = conn.prepareStatement(sql);  ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching today's revenue", e);
        }
        return total;
    }

    public int getTodayTotalBooking() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Bookings "
                + "WHERE CAST(BookingDate AS DATE) = CAST(GETDATE() AS DATE)";
        try ( Connection cn = DBContext.getConnection();  
                PreparedStatement st = cn.prepareStatement(sql);  
                ResultSet rs = st.executeQuery()) {
            if(rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching pending bookings count", e);
        }
        return count;
    }
    // Đếm số đơn đang chờ xử lý
    public int getPendingBookingsCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Bookings WHERE Status = 'Pending'";
        try (Connection cn = DBContext.getConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching pending bookings count", e);
        }
        return count;
    }
    // Lấy doanh thu 7 ngày gần nhất (dùng CTE để không bị thiếu ngày)
    public List<Double> getRevenueLast7Days() {
        List<Double> revenues = new ArrayList<>();
        String sql = "WITH Last7Days AS ("
                   + "    SELECT CAST(GETDATE() - 6 AS DATE) AS Date "
                   + "    UNION ALL "
                   + "    SELECT DATEADD(day, 1, Date) FROM Last7Days "
                   + "    WHERE Date < CAST(GETDATE() AS DATE)"
                   + ") "
                   + "SELECT d.Date, ISNULL(SUM(b.FinalPrice), 0) AS Revenue "
                   + "FROM Last7Days d "
                   + "LEFT JOIN Bookings b ON CAST(b.BookingDate AS DATE) = d.Date "
                   + "AND b.Status = 'Completed' "
                   + "GROUP BY d.Date "
                   + "ORDER BY d.Date ASC";
        try (Connection cn = DBContext.getConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                revenues.add(rs.getDouble("Revenue"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching revenue last 7 days", e);
            // Fallback: trả mảng 7 số 0 để biểu đồ không sập
            for (int i = 0; i < 7; i++) revenues.add(0.0);
        }
        return revenues;
    }
    // Lấy nhãn ngày (dd/MM) cho 7 ngày gần nhất
    public List<String> getLabelsLast7Days() {
        List<String> labels = new ArrayList<>();
        String sql = "WITH Last7Days AS ("
                   + "    SELECT CAST(GETDATE() - 6 AS DATE) AS Date "
                   + "    UNION ALL "
                   + "    SELECT DATEADD(day, 1, Date) FROM Last7Days "
                   + "    WHERE Date < CAST(GETDATE() AS DATE)"
                   + ") "
                   + "SELECT FORMAT(Date, 'dd/MM') AS Label "
                   + "FROM Last7Days ORDER BY Date ASC";
        try (Connection cn = DBContext.getConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                labels.add(rs.getString("Label"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching labels last 7 days", e);
            for (int i = 0; i < 7; i++) labels.add("");
        }
        return labels;
    }

}
