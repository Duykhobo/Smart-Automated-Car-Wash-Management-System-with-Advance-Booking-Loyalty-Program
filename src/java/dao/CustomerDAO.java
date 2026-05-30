package dao;

import dto.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import utils.DBContext;

public class CustomerDAO {
    
    public Customer getCustomerByAccountId(int userID) {
        String sql = "SELECT c.*, t.TierName AS TierStatus FROM Customers c LEFT JOIN MemberTiers t ON c.TierID = t.TierID WHERE c.UserID = ?";
        
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, userID);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int cusID = rs.getInt("CustomerID");
                    int dbUserID = rs.getInt("UserID");
                    String fullname = rs.getString("FullName");
                    String phone = rs.getString("Phone"); 
                    String email = rs.getString("Email");
                    String licensePlate = ""; // Không còn dùng trong bảng Customers
                    String tierStatus = rs.getString("TierStatus");
                    int pointBalance = rs.getInt("PointsBalance");
                    
                    double totalSpend = rs.getDouble("TotalSpend"); 
                    int totalWashes = rs.getInt("TotalWashes");
                    Timestamp tierUpgradeDate = rs.getTimestamp("TierUpgradeDate");
                    String avatar = rs.getString("Avatar");
                    
                    return new Customer(cusID, dbUserID, fullname, phone, email, licensePlate, 
                                        tierStatus, pointBalance, totalSpend, totalWashes, tierUpgradeDate, avatar);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi truy vấn CSDL tại CustomerDAO.getCustomerByAccountId:");
            e.printStackTrace();
        }
        
        return null;
    }
}
