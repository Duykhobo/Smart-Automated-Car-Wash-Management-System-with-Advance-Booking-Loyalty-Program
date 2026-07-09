package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import utils.DBContext;

public class VoucherDAO {

    public void redeemVoucher(int customerId, String rewardType, int pointsCost) throws Exception {
        String sql = "{CALL sp_RedeemVoucherFIFO(?, ?, ?)}";

        try (Connection cn = DBContext.getConnection();
             CallableStatement cs = cn.prepareCall(sql)) {

            cs.setInt(1, customerId);
            cs.setString(2, rewardType);
            cs.setInt(3, pointsCost);

            // DB tự kiểm tra điểm, trừ điểm FIFO và tạo voucher
            cs.execute();

        } catch (SQLException e) {
            // Ném lỗi lên Servlet để hiển thị thông báo cho user
            throw new Exception(e.getMessage());
        }
    }

    public java.util.List<dto.Voucher> getAvailableVouchers(int customerId) throws Exception {
        java.util.List<dto.Voucher> list = new java.util.ArrayList<>();
        String sql = "SELECT VoucherID, CustomerID, VoucherCode, RewardType, PointsCost, ExpiryDate, Status " +
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
                        rs.getString("Status")
                    ));
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi lấy danh sách Voucher: " + e.getMessage());
        }
        return list;
    }
}