/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.Customer;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import utils.DBContext;

/**
 *
 * @author Admin
 */
public class CustomerDAO {
    public Customer getCustomerByAccountId(int UserID) {
        Customer result = null;
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet table = null;

        try {
            cn = DBContext.getConnection(); // Thay bằng hàm lấy connection của bạn

            if (cn != null) {
                // Đã bỏ TierID khỏi câu lệnh SQL cho đồng bộ với Object Customer
                String sql ="SELECT * FROM [SmartCarWash].[dbo].[Customers] WHERE UserID = ?";

                st = cn.prepareStatement(sql);
                st.setInt(1,UserID);
                table = st.executeQuery();

                if (table.next()) {
                    int cusID=table.getInt("CustomerID");
                    int userID=table.getInt("UserID");
                    String fullname=table.getString("FullName");
                    String phone=table.getString("phone");
                    String LicensePlate=table.getString("LicensePlate");
                    String TierStatus= table.getString("TierStatus");
                    int poinbalance=table.getInt("PointsBalance");
                    double TotalSpend=table.getInt("TotalSpend");
                    int TotalWashes=table.getInt("TotalWashes");
                    Timestamp tierUpgradedate=table.getTimestamp("TierUpgradeDate");
                    result=new Customer(cusID, userID, fullname, phone, LicensePlate, TierStatus, poinbalance, TotalSpend, TotalWashes, tierUpgradedate);
                    // Truyền ĐÚNG THỨ TỰ và ĐÚNG SỐ LƯỢNG tham số của file Customer.java

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (table != null) {
                    table.close();
                }
                if (st != null) {
                    st.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
