package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Customer;
import dto.User;
import utils.DBContext;

public class UserDAO {

    // Hàm kiểm tra xem User đã tồn tại hay chưa
    public boolean checkUserExists(String phone) {
        String sql = "SELECT [UserID] FROM Users WHERE [Username] = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            try ( ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Hàm lưu vào cả 2 bảng bằng Transaction
    public boolean registerCustomer(User user, Customer cus) {
        String sqlInsertUser = "INSERT INTO Users (Username, PasswordHash, Role) VALUES (?, ?, ?)";
        String sqlInsertCustomer = "INSERT INTO Customers (UserID, FullName, Phone) VALUES (?, ?, ?)";
        String sqlInsertVehicle = "INSERT INTO Vehicles (CustomerID, LicensePlate) VALUES (?, ?)";

        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            // 1. Tắt Auto-commit để bắt đầu Transaction
            conn.setAutoCommit(false);
            // 2. Insert vào bảng Users, đồng thời xin lấy lại UserID vừa được tạo
            try ( PreparedStatement psUser = conn.prepareStatement(sqlInsertUser, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, user.getUsername());
                psUser.setString(2, user.getPasswordHash());
                psUser.setString(3, user.getRole());
                psUser.executeUpdate();
                // Lấy ID tự tăng của User vừa tạo
                try ( ResultSet rsUser = psUser.getGeneratedKeys()) {
                    if (rsUser.next()) {
                        int generatedUserId = rsUser.getInt(1);

                        // 3. Có UserID rồi thì Insert tiếp vào bảng Customers
                        try ( PreparedStatement psCustomer = conn.prepareStatement(sqlInsertCustomer, PreparedStatement.RETURN_GENERATED_KEYS)) {
                            psCustomer.setInt(1, generatedUserId);
                            psCustomer.setString(2, cus.getFullName());
                            psCustomer.setString(3, cus.getPhone());
                            psCustomer.executeUpdate();
                            
                            // Lấy ID tự tăng của Customer vừa tạo
                            try (ResultSet rsCustomer = psCustomer.getGeneratedKeys()) {
                                if (rsCustomer.next()) {
                                    int generatedCustomerId = rsCustomer.getInt(1);
                                    
                                    // 4. Có CustomerID rồi thì Insert Biển số vào bảng Vehicles
                                    try ( PreparedStatement psVehicle = conn.prepareStatement(sqlInsertVehicle)) {
                                        psVehicle.setInt(1, generatedCustomerId);
                                        psVehicle.setString(2, cus.getLicensePlate());
                                        psVehicle.executeUpdate();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // 4. Nếu code chạy mượt tới đây không sinh lỗi -> Chốt hạ lưu vào DB!
            conn.commit();
            return true;
        } catch (SQLException e) {
            // Nếu có lỗi ở bất kỳ bước nào (trùng SDT, đứt cáp...) -> Hủy bỏ hết toàn bộ
            // quá trình trên
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            // Nhớ bật lại AutoCommit và đóng kết nối để khỏi bị leak bộ nhớ
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    // Hàm Đăng Nhập
    public User login(String username, String passwordHash) {
        String sql = "SELECT * FROM Users WHERE [Username] = ? AND [PasswordHash] = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, passwordHash);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUsername(rs.getString("Username"));
                    user.setPasswordHash(rs.getString("PasswordHash"));
                    user.setRole(rs.getString("Role"));
                    user.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
