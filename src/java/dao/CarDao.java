package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;

import java.util.List;

import dto.Cars;
import utils.DBContext;

public class CarDao {
 public List<Cars> getAllCars(int custid){
      List<Cars> result=new ArrayList<>();
      Connection cn=null;
        try {
            cn=DBContext.getConnection();
            if(cn!=null){
                String sql = "SELECT [VehicleID], [CustomerID], [LicensePlate], [VehicleType], [Color], [CreatedAt], [UpdatedAt], [IsActive] "
                           + "FROM [Vehicles] "
                           + "WHERE [CustomerID] = ? AND [IsActive] = 1";
                PreparedStatement st=cn.prepareStatement(sql);
                st.setInt(1, custid);
                ResultSet table=st.executeQuery();
                if(table!=null){
                    while(table.next()){
                        int vehicleId = table.getInt("VehicleID");
                        int Cusid=table.getInt("CustomerID");
                        String licensePlate = table.getString("LicensePlate");
                        String vehicleType = table.getString("VehicleType");
                        String color = table.getString("Color");
                    Date createdAt = table.getDate("CreatedAt");
                        Date updatedAt = table.getDate("UpdatedAt");
                        boolean isActive = table.getBoolean("IsActive");
                        Cars c = new Cars(vehicleId, Cusid, licensePlate, vehicleType, color, createdAt, updatedAt, isActive);
                       result.add(c);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
      return result;
    }
     public Cars getCarById(int vehicleId) {
        Cars car = null;
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet table = null;
        try {
            cn = DBContext.getConnection();
            if (cn != null) {
                String sql = "SELECT [VehicleID], [CustomerID], [LicensePlate], [VehicleType], [Color], [CreatedAt], [UpdatedAt], [IsActive] "
                           + "FROM [Vehicles] "
                           + "WHERE [VehicleID] = ?";
                st = cn.prepareStatement(sql);
                st.setInt(1, vehicleId);
                table = st.executeQuery();
                if (table.next()) {
                    int customerId = table.getInt("CustomerID");
                    String licensePlate = table.getString("LicensePlate");
                    String vehicleType = table.getString("VehicleType");
                    String color = table.getString("Color");
                    Date createdAt = table.getDate("CreatedAt");
                    Date updatedAt = table.getDate("UpdatedAt");
                    boolean isActive = table.getBoolean("IsActive");
                    
                    car = new Cars(vehicleId, customerId, licensePlate, vehicleType, color, createdAt, updatedAt, isActive);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (table != null) table.close();
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return car;
    }
    //tao xe moi//
    public boolean insertCar(Cars car) {
        Connection cn = null;
        PreparedStatement st = null;
        boolean success = false;
        try {
            cn = DBContext.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO [Vehicles] ([CustomerID], [LicensePlate], [VehicleType], [Color], [IsActive], [CreatedAt], [UpdatedAt]) "
                           + "VALUES (?, ?, ?, ?, ?, ?, ?)";
                st = cn.prepareStatement(sql);
                st.setInt(1, car.getCustomerID());
                st.setString(2, car.getLicensePlate());
                st.setString(3, car.getVehicleType());
                st.setString(4, car.getColor());
                st.setBoolean(5, true); // Active mặc định khi tạo mới
                st.setDate(6, new Date(System.currentTimeMillis()));
                st.setDate(7, new Date(System.currentTimeMillis()));

                int rows = st.executeUpdate();
                if (rows > 0) {
                    success = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }
    //chinh xua thong tin xe//
    public boolean updateCar(Cars car) {
        Connection cn = null;
        PreparedStatement st = null;
        boolean success = false;
        try {
            cn = DBContext.getConnection();
            if (cn != null) {
                String sql = "UPDATE [Vehicles] "
                           + "SET [LicensePlate] = ?, [VehicleType] = ?, [Color] = ?, [UpdatedAt] = ? "
                           + "WHERE [VehicleID] = ? AND [CustomerID] = ?";
                st = cn.prepareStatement(sql);
                st.setString(1, car.getLicensePlate());
                st.setString(2, car.getVehicleType());
                st.setString(3, car.getColor());
                st.setDate(4, new Date(System.currentTimeMillis())); // Cập nhật thời gian sửa
                st.setInt(5, car.getVehicleID());
                st.setInt(6, car.getCustomerID());
                
                int rows = st.executeUpdate();
                if (rows > 0) {
                    success = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }
    //xoa xe chuyen isactive sang so 0//
    public boolean softDeleteCar(int vehicleId, int customerId) {
        Connection cn = null;
        PreparedStatement st = null;
        boolean success = false;
        try {
            cn = DBContext.getConnection();
            if (cn != null) {
                String sql = "UPDATE [Vehicles] SET [IsActive] = 0, [UpdatedAt] = ? WHERE [VehicleID] = ? AND [CustomerID] = ?";
                st = cn.prepareStatement(sql);
                st.setDate(1, new Date(System.currentTimeMillis()));
                st.setInt(2, vehicleId);
                st.setInt(3, customerId);
                
                int rows = st.executeUpdate();
                if (rows > 0) {
                    success = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }
}
