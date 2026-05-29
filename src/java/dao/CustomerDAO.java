package dao;

import dto.Customer;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import utils.DBContext;

public class CustomerDAO {

    public Customer getCustomerByAccountId(int userID) {
        // Chỉ cần gọi tên bảng "Customers"
        String sql = "SELECT * FROM Customers WHERE UserID = ?";

        // Sử dụng Try-with-resources: Tự động đóng Connection, Statement và ResultSet khi chạy xong
        try (Connection cn = DBContext.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {

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

                    // Sửa lỗi getInt -> getDouble để tránh mất số thập phân
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

    public Customer getCustomer(String txtphone) {
        Customer result = null;
        Connection cn = null;
        try {
            //buoc 1: make connection
            cn = DBContext.getConnection();
            if (cn != null) {
                //buoc 2 : viet sql
                String sql = "Select [UserID]\n"
                        + "from Customers\n"
                        + "where Phone = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, txtphone);
                ResultSet rs = st.executeQuery();
                //buoc 3: doc data trong bien table
                if (rs.next()) {
                    int cusID = rs.getInt("CustomerID");
                    int dbUserID = rs.getInt("UserID");
                    String fullname = rs.getString("FullName");
                    String phone = rs.getString("Phone"); // Nên viết hoa chữ P cho đúng chuẩn SQL nếu có
                    String licensePlate = rs.getString("LicensePlate");
                    String tierStatus = rs.getString("TierStatus");
                    int pointBalance = rs.getInt("PointsBalance");

                    // Sửa lỗi getInt -> getDouble để tránh mất số thập phân
                    double totalSpend = rs.getDouble("TotalSpend");
                    int totalWashes = rs.getInt("TotalWashes");
                    Timestamp tierUpgradeDate = rs.getTimestamp("TierUpgradeDate");

                    return new Customer(cusID, dbUserID, fullname, phone, licensePlate,
                            tierStatus, pointBalance, totalSpend, totalWashes, tierUpgradeDate);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                //buoc 4
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }

    public int updateProfile(int cusId, String fullname, String phone) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBContext.getConnection();
            if (cn != null) {
                String sql = "from Customers\n"
                        + "Update Customers\n"
                        + "Set FullName = ?, Phone = ?\n"
                        + "Where CustomerID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, fullname);
                st.setString(2, phone);
                st.setInt(3, cusId);
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return result;
    }

}
