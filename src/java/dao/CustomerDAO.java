package dao;

import dto.Customer;
import dto.PointLedger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import utils.DBContext;

public class CustomerDAO {

    public Customer getCustomerByAccountId(int userID) {
        String sql = "SELECT c.*, t.TierName AS TierStatus FROM Customers c LEFT JOIN MemberTiers t ON c.TierID = t.TierID WHERE c.UserID = ?";

        try ( Connection cn = DBContext.getConnection();  PreparedStatement st = cn.prepareStatement(sql)) {

            st.setInt(1, userID);

            try ( ResultSet rs = st.executeQuery()) {
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

    public Customer getCustomerById(int customerId) {
        String sql = "SELECT c.*, t.TierName AS TierStatus FROM Customers c LEFT JOIN MemberTiers t ON c.TierID = t.TierID WHERE c.CustomerID = ?";

        try (Connection cn = DBContext.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int cusID = rs.getInt("CustomerID");
                    int dbUserID = rs.getInt("UserID");
                    String fullname = rs.getString("FullName");
                    String phone = rs.getString("Phone");
                    String email = rs.getString("Email");
                    String licensePlate = ""; 
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
            System.err.println("Lỗi truy vấn CSDL tại CustomerDAO.getCustomerById:");
            e.printStackTrace();
        }
        return null;
    }

    public int updateProfile(int cusId, String fullname, String email, String avatarPath) {
        int result = 0;
        String sql;
        if (avatarPath != null) {
            sql = "UPDATE [Customers] SET [FullName] = ?, [Email] = ?, [Avatar] = ?, [UpdatedAt] = GETDATE() WHERE [CustomerID] = ?";
        } else {
            sql = "UPDATE [Customers] SET [FullName] = ?, [Email] = ?, [UpdatedAt] = GETDATE() WHERE [CustomerID] = ?";
        }

        try ( Connection cn = DBContext.getConnection();  PreparedStatement st = cn.prepareStatement(sql)) {

            st.setString(1, fullname);
            st.setString(2, email);
            if (avatarPath != null) {
                st.setString(3, avatarPath);
                st.setInt(4, cusId);
            } else {
                st.setInt(3, cusId);
            }
            result = st.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean isEmailExists(int cusId, String email) {
        String sql = "Select top 1 1\n"
                + "From Customers\n"
                + "Where Email = ? AND CustomerID <> ?";

        try ( Connection cn = DBContext.getConnection();  PreparedStatement st = cn.prepareStatement(sql)) {

            st.setString(1, email);
            st.setInt(2, cusId);
            try ( ResultSet found = st.executeQuery()) {
                if (found.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateTier(int customerId, int tierId) {
        boolean success = false;
        String sql = "UPDATE [Customers] SET [TierID] = ?, [TierUpgradeDate] = ?, [UpdatedAt] = GETDATE() WHERE [CustomerID] = ?";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, tierId);
            st.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            st.setInt(3, customerId);
            
            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            System.err.println("Error updating customer tier");
            e.printStackTrace();
        }
        return success;
    }
            public int getTotalCustomersCount() {
        String sql = "SELECT COUNT(*) FROM Customers WHERE IsActive = 1";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getNewCustomersThisMonth() {
        String sql = "SELECT COUNT(*) FROM Customers WHERE IsActive = 1 AND MONTH(CreatedAt) = MONTH(GETDATE()) AND YEAR(CreatedAt) = YEAR(GETDATE())";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getGoldPlatPercentage() {
        String sqlTotal = "SELECT COUNT(*) FROM Customers WHERE IsActive = 1";
        String sqlGoldPlat = "SELECT COUNT(*) FROM Customers c JOIN MemberTiers t ON c.TierID = t.TierID WHERE c.IsActive = 1 AND t.TierName IN ('Gold', 'Platinum')";
        
        try (Connection cn = DBContext.getConnection()) {
            int total = 0;
            try (PreparedStatement st = cn.prepareStatement(sqlTotal); ResultSet rs = st.executeQuery()) {
                if (rs.next()) total = rs.getInt(1);
            }
            int goldPlat = 0;
            try (PreparedStatement st = cn.prepareStatement(sqlGoldPlat); ResultSet rs = st.executeQuery()) {
                if (rs.next()) goldPlat = rs.getInt(1);
            }
            double percentage = (total > 0) ? ((double) goldPlat / total) * 100 : 0.0;
            return Math.round(percentage * 10.0) / 10.0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public int getTotalPointsCapped() {
        String sql = "SELECT SUM(PointsBalance) FROM Customers WHERE IsActive = 1";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public java.util.List<Customer> getAdminCustomers(String search, int page, int pageSize) {
        java.util.List<Customer> list = new java.util.ArrayList<>();
        String sql = "SELECT c.*, t.TierName AS TierStatus, " +
                     "       (SELECT TOP 1 LicensePlate FROM Vehicles WHERE CustomerID = c.CustomerID AND IsActive = 1) AS LicensePlate " +
                     "FROM Customers c " +
                     "LEFT JOIN MemberTiers t ON c.TierID = t.TierID " +
                     "WHERE c.IsActive = 1 ";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (c.FullName LIKE ? OR c.Phone LIKE ? OR c.Email LIKE ? OR EXISTS (SELECT 1 FROM Vehicles WHERE CustomerID = c.CustomerID AND LicensePlate LIKE ?)) ";
        }
        
        sql += "ORDER BY c.CustomerID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection cn = DBContext.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            int paramIdx = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                st.setString(paramIdx++, searchPattern);
                st.setString(paramIdx++, searchPattern);
                st.setString(paramIdx++, searchPattern);
                st.setString(paramIdx++, searchPattern);
            }
            st.setInt(paramIdx++, (page - 1) * pageSize);
            st.setInt(paramIdx++, pageSize);
            
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int cusID = rs.getInt("CustomerID");
                    int dbUserID = rs.getInt("UserID");
                    String fullname = rs.getString("FullName");
                    String phone = rs.getString("Phone");
                    String email = rs.getString("Email");
                    String licensePlate = rs.getString("LicensePlate");
                    if (licensePlate == null) licensePlate = "";
                    String tierStatus = rs.getString("TierStatus");
                    int pointBalance = rs.getInt("PointsBalance");
                    double totalSpend = rs.getDouble("TotalSpend");
                    int totalWashes = rs.getInt("TotalWashes");
                    Timestamp tierUpgradeDate = rs.getTimestamp("TierUpgradeDate");
                    String avatar = rs.getString("Avatar");
                    
                    list.add(new Customer(cusID, dbUserID, fullname, phone, email, licensePlate,
                            tierStatus, pointBalance, totalSpend, totalWashes, tierUpgradeDate, avatar));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalAdminCustomers(String search) {
        String sql = "SELECT COUNT(DISTINCT c.CustomerID) FROM Customers c " +
                     "LEFT JOIN Vehicles v ON c.CustomerID = v.CustomerID AND v.IsActive = 1 " +
                     "WHERE c.IsActive = 1 ";
        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (c.FullName LIKE ? OR c.Phone LIKE ? OR c.Email LIKE ? OR v.LicensePlate LIKE ?) ";
        }
        
        try (Connection cn = DBContext.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search + "%";
                st.setString(1, searchPattern);
                st.setString(2, searchPattern);
                st.setString(3, searchPattern);
                st.setString(4, searchPattern);
            }
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
        public List<PointLedger> getPointLedgerByCustomerId(int customerId) {
        java.util.List<dto.PointLedger> list = new java.util.ArrayList<>();
        String sql = "SELECT LedgerID, CustomerID, ReferenceType, ReferenceID, PointsChange, PointsRemaining, EarnedDate, ExpiryDate, " +
                     "CASE WHEN ExpiryDate IS NOT NULL AND ExpiryDate < GETDATE() THEN 1 ELSE 0 END AS IsExpired " +
                     "FROM PointLedger WHERE CustomerID = ? ORDER BY EarnedDate DESC";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, customerId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    int ledgerId = rs.getInt("LedgerID");
                    int custId = rs.getInt("CustomerID");
                    String refType = rs.getString("ReferenceType");
                    Integer refId = rs.getObject("ReferenceID") != null ? rs.getInt("ReferenceID") : null;
                    int ptsChange = rs.getInt("PointsChange");
                    int ptsRemaining = rs.getInt("PointsRemaining");
                    Timestamp earnedDate = rs.getTimestamp("EarnedDate");
                    Timestamp expiryDate = rs.getTimestamp("ExpiryDate");
                    boolean isExpired = rs.getBoolean("IsExpired");
                    
                    list.add(new dto.PointLedger(ledgerId, custId, refType, refId, ptsChange, ptsRemaining, earnedDate, expiryDate, isExpired));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
