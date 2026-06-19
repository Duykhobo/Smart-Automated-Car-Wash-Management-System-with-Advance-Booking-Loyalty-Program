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
}