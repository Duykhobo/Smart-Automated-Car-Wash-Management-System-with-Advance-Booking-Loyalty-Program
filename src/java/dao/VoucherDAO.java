package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import utils.DBContext;

public class VoucherDAO {

    public void redeemVoucher(int customerId, String rewardType, int pointsCost, double discountPercent) throws Exception {
        String sql = "{CALL sp_RedeemVoucherFIFO(?, ?, ?, ?)}";

        try (Connection cn = DBContext.getConnection();
             CallableStatement cs = cn.prepareCall(sql)) {

            cs.setInt(1, customerId);
            cs.setString(2, rewardType);
            cs.setInt(3, pointsCost);
            cs.setDouble(4, discountPercent);

            // DB tự kiểm tra điểm, trừ điểm FIFO và tạo voucher
            cs.execute();

        } catch (SQLException e) {
            // Ném lỗi lên Servlet để hiển thị thông báo cho user
            throw new Exception(e.getMessage());
        }
    }

    public java.util.List<dto.Voucher> getAvailableVouchers(int customerId) throws Exception {
        java.util.List<dto.Voucher> list = new java.util.ArrayList<>();
        String sql = "SELECT VoucherID, CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status, DiscountPercent " +
                     "FROM Vouchers " +
                     "WHERE CustomerID = ? AND Status = 'Unused' AND ExpiryDate >= GETDATE() " +
                     "ORDER BY ExpiryDate ASC";
                     
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql)) {
             
            st.setInt(1, customerId);
            try (java.sql.ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(new dto.Voucher(
                        rs.getInt("VoucherID"),
                        rs.getInt("CustomerID"),
                        rs.getString("VoucherCode"),
                        rs.getString("RewardType"),
                        rs.getInt("PointsCost"),
                        rs.getTimestamp("ExpiryDate"),
                        rs.getString("Status"),
                        rs.getDouble("DiscountPercent")
                    ));
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi lấy danh sách Voucher: " + e.getMessage());
        }
        return list;
    }

    public int getActiveVouchersCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM Vouchers WHERE Status = 'Unused' AND ExpiryDate >= GETDATE()";
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql);
             java.sql.ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getRedeemedVouchersThisMonth() throws Exception {
        String sql = "SELECT COUNT(*) FROM Vouchers WHERE MONTH(CreatedAt) = MONTH(GETDATE()) AND YEAR(CreatedAt) = YEAR(GETDATE())";
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql);
             java.sql.ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getTotalPointsSpent() throws Exception {
        String sql = "SELECT ISNULL(SUM(PointsCost), 0) FROM Vouchers";
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql);
             java.sql.ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getTotalVouchersCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM Vouchers";
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql);
             java.sql.ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public java.util.List<dto.VoucherHistoryDTO> getVoucherHistory(int limit, int offset) throws Exception {
        java.util.List<dto.VoucherHistoryDTO> list = new java.util.ArrayList<>();
        String sql = "WITH PagedVouchers AS ( " +
                     "    SELECT v.VoucherID, v.VoucherCode, v.RewardType, v.DiscountPercent, v.PointsCost, v.Status, v.ExpiryDate, v.CreatedAt, " +
                     "    c.FullName as CustomerName, c.Email as CustomerEmail, " +
                     "    ROW_NUMBER() OVER (ORDER BY v.CreatedAt DESC) AS RowNum " +
                     "    FROM Vouchers v " +
                     "    JOIN Customers c ON v.CustomerID = c.CustomerID " +
                     ") " +
                     "SELECT * FROM PagedVouchers WHERE RowNum > ? AND RowNum <= ?";
                     
        try (Connection cn = DBContext.getConnection();
             java.sql.PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, offset);
            st.setInt(2, offset + limit);
            try (java.sql.ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(new dto.VoucherHistoryDTO(
                        rs.getInt("VoucherID"),
                        rs.getString("CustomerName"),
                        rs.getString("CustomerEmail"),
                        rs.getString("VoucherCode"),
                        rs.getString("RewardType"),
                        rs.getDouble("DiscountPercent"),
                        rs.getInt("PointsCost"),
                        rs.getString("Status"),
                        rs.getTimestamp("ExpiryDate"),
                        rs.getTimestamp("CreatedAt")
                    ));
                }
            }
        }
        return list;
    }
}