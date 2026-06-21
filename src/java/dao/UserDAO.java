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
                            try ( ResultSet rsCustomer = psCustomer.getGeneratedKeys()) {
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

    /**
     * @deprecated Hàm này hiện tại KHÔNG CÒN SỬ DỤNG VÀ KHÔNG HOẠT ĐỘNG
     * do hệ thống đã chuyển sang dùng Mật khẩu Hash có Salt ngẫu nhiên (BCrypt/PBKDF2).
     * Không thể dùng câu query `WHERE PasswordHash = ?` để so sánh trong DB.
     * Vui lòng dùng hàm `getUserByUsername` kết hợp với `HashUtil.verifyPassword` bên tầng Controller.
     */
    @Deprecated
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

    // Lấy thông tin User bằng Username (SĐT) để phục vụ việc xác thực mật khẩu kiểu mới (có Salt)
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE [Username] = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
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

    public dto.Customer getCustomerByUserId(int userId) {
        String sql = "SELECT * FROM Customers WHERE UserID = ?";
        try ( java.sql.Connection conn = DBContext.getConnection();  java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try ( java.sql.ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    dto.Customer cus = new dto.Customer();
                    cus.setCustomerId(rs.getInt("CustomerID"));
                    cus.setUserId(rs.getInt("UserID"));
                    cus.setFullName(rs.getString("FullName"));
                    cus.setPhone(rs.getString("Phone"));
                    cus.setEmail(rs.getString("Email"));
                    cus.setPointsBalance(rs.getInt("PointsBalance"));
                    cus.setTotalSpend(rs.getDouble("TotalSpend"));
                    cus.setTotalWashes(rs.getInt("TotalWashes"));
                    cus.setTierUpgradeDate(rs.getTimestamp("TierUpgradeDate"));
                    cus.setAvatar(rs.getString("Avatar"));
                    return cus;
                }
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updatePassword(int userID, String hashPass) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBContext.getConnection();
            if (cn != null) {
                String sql = "Update Users\n"
                        + "Set PasswordHash = ?\n"
                        + "Where UserID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, hashPass);
                st.setInt(2, userID);
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return result;
    }
}
