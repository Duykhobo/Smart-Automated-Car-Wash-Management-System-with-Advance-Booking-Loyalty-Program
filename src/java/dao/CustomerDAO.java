package dao;

import dto.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import utils.DBContext;

public class CustomerDAO {
    
    /**
     * Retrieve the Customer record that corresponds to the given account user ID.
     *
     * @param userID the account's UserID used to look up the customer
     * @return the matching Customer object, or `null` if no record is found or an error occurs
     * @throws ClassNotFoundException if the database driver or DB context cannot be initialized
     */
    public Customer getCustomerByAccountId(int userID) throws ClassNotFoundException {
        // Chỉ cần gọi tên bảng "Customers"
        String sql = "SELECT * FROM Customers WHERE UserID = ?";
        
        // Sử dụng Try-with-resources: Tự động đóng Connection, Statement và ResultSet khi chạy xong
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, userID);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int cusID = rs.getInt("CustomerID");
                    int dbUserID = rs.getInt("UserID");
                    String fullname = rs.getString("FullName");
                    String phone = rs.getString("Phone"); // Nên viết hoa chữ P cho đúng chuẩn SQL nếu có
                    String licensePlate = rs.getString("LicensePlate");
                    String tierStatus = rs.getString("TierStatus");
                    int pointBalance = rs.getInt("PointsBalance");
                    
                    // Đã sửa lại thành getDouble
                    double totalSpend = rs.getDouble("TotalSpend"); 
                    int totalWashes = rs.getInt("TotalWashes");
                    Timestamp tierUpgradeDate = rs.getTimestamp("TierUpgradeDate");
                    
                    return new Customer(cusID, dbUserID, fullname, phone, licensePlate, 
                                        tierStatus, pointBalance, totalSpend, totalWashes, tierUpgradeDate);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi truy vấn CSDL tại CustomerDAO.getCustomerByAccountId:");
            e.printStackTrace();
        }
        
        // Trả về null nếu không tìm thấy user hoặc có lỗi
        return null;
    }
}
