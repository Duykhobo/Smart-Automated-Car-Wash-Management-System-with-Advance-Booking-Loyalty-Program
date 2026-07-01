package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dto.Cars;
import utils.DBContext;

public class CarDao {
    private static final Logger LOGGER = Logger.getLogger(CarDao.class.getName());

    public List<Cars> getAllCars(int custid) throws SQLException {
        List<Cars> result = new ArrayList<>();
        // Sắp xếp IsDefault lên đầu tiên
        String sql = "SELECT v.[VehicleID], v.[CustomerID], v.[LicensePlate], v.[Brand], v.[Model], v.[VehicleTypeID], v.[Color], v.[ImageURL], v.[IsDefault], v.[CreatedAt], v.[UpdatedAt], v.[IsActive], vt.[TypeName], vt.[VehicleSize] "
                   + "FROM [Vehicles] v "
                   + "JOIN [VehicleTypes] vt ON v.[VehicleTypeID] = vt.[VehicleTypeID] "
                   + "WHERE v.[CustomerID] = ? AND v.[IsActive] = 1 "
                   + "ORDER BY [IsDefault] DESC, [CreatedAt] DESC";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, custid);
            try (ResultSet table = st.executeQuery()) {
                while (table.next()) {
                    int vehicleId = table.getInt("VehicleID");
                    int cusId = table.getInt("CustomerID");
                    String licensePlate = table.getString("LicensePlate");
                    String brand = table.getString("Brand");
                    String model = table.getString("Model");
                    int vehicleTypeId = table.getInt("VehicleTypeID");
                    String typeName = table.getString("TypeName");
                    String vehicleSize = table.getString("VehicleSize");
                    String color = table.getString("Color");
                    String imageUrl = table.getString("ImageURL");
                    boolean isDefault = table.getBoolean("IsDefault");
                    Timestamp createdAt = table.getTimestamp("CreatedAt");
                    Timestamp updatedAt = table.getTimestamp("UpdatedAt");
                    boolean isActive = table.getBoolean("IsActive");

                    Cars c = new Cars(vehicleId, cusId, licensePlate, brand, model, vehicleTypeId, typeName, vehicleSize, color, imageUrl, isDefault, createdAt, updatedAt, isActive);
                    result.add(c);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all cars for customer " + custid, e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getAllCars", e);
            throw new SQLException(e);
        }
        return result;
    }

    public Cars getCarById(int vehicleId) throws SQLException {
        Cars car = null;
        String sql = "SELECT v.[VehicleID], v.[CustomerID], v.[LicensePlate], v.[Brand], v.[Model], v.[VehicleTypeID], v.[Color], v.[ImageURL], v.[IsDefault], v.[CreatedAt], v.[UpdatedAt], v.[IsActive], vt.[TypeName], vt.[VehicleSize] "
                   + "FROM [Vehicles] v "
                   + "JOIN [VehicleTypes] vt ON v.[VehicleTypeID] = vt.[VehicleTypeID] "
                   + "WHERE v.[VehicleID] = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, vehicleId);
            try (ResultSet table = st.executeQuery()) {
                if (table.next()) {
                    int customerId = table.getInt("CustomerID");
                    String licensePlate = table.getString("LicensePlate");
                    String brand = table.getString("Brand");
                    String model = table.getString("Model");
                    int vehicleTypeId = table.getInt("VehicleTypeID");
                    String typeName = table.getString("TypeName");
                    String vehicleSize = table.getString("VehicleSize");
                    String color = table.getString("Color");
                    String imageUrl = table.getString("ImageURL");
                    boolean isDefault = table.getBoolean("IsDefault");
                    Timestamp createdAt = table.getTimestamp("CreatedAt");
                    Timestamp updatedAt = table.getTimestamp("UpdatedAt");
                    boolean isActive = table.getBoolean("IsActive");

                    car = new Cars(vehicleId, customerId, licensePlate, brand, model, vehicleTypeId, typeName, vehicleSize, color, imageUrl, isDefault, createdAt, updatedAt, isActive);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching car by ID " + vehicleId, e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getCarById", e);
            throw new SQLException(e);
        }
        return car;
    }

    public boolean insertCar(Cars car) throws SQLException {
        boolean success = false;
        String sql = "INSERT INTO [Vehicles] ([CustomerID], [LicensePlate], [Brand], [Model], [VehicleTypeID], [Color], [ImageURL], [IsDefault], [IsActive], [CreatedAt], [UpdatedAt]) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1, GETDATE(), GETDATE())";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, car.getCustomerId());
            st.setString(2, car.getLicensePlate());
            st.setString(3, car.getBrand());
            st.setString(4, car.getModel());
            st.setInt(5, car.getVehicleTypeId());
            st.setString(6, car.getColor());
            st.setString(7, car.getImageUrl());
            st.setBoolean(8, car.getIsDefault());
                
            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting new car: " + car.getLicensePlate(), e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in insertCar", e);
            throw new SQLException(e);
        }
        return success;
    }

    public boolean updateCar(Cars car) throws SQLException {
        boolean success = false;
        String sql = "UPDATE [Vehicles] "
                   + "SET [LicensePlate] = ?, [Brand] = ?, [Model] = ?, [VehicleTypeID] = ?, [Color] = ?, [ImageURL] = ISNULL(?, [ImageURL]), [UpdatedAt] = ? "
                   + "WHERE [VehicleID] = ? AND [CustomerID] = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setString(1, car.getLicensePlate());
            st.setString(2, car.getBrand());
            st.setString(3, car.getModel());
            st.setInt(4, car.getVehicleTypeId());
            st.setString(5, car.getColor());
            st.setString(6, car.getImageUrl()); 
            st.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            st.setInt(8, car.getVehicleId());
            st.setInt(9, car.getCustomerId());
            
            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating car ID " + car.getVehicleId(), e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in updateCar", e);
            throw new SQLException(e);
        }
        return success;
    }

    public boolean softDeleteCar(int vehicleId, int customerId) throws SQLException {
        boolean success = false;
        String sql = "UPDATE [Vehicles] SET [IsActive] = 0, [IsDefault] = 0, [UpdatedAt] = ? WHERE [VehicleID] = ? AND [CustomerID] = ?";
        
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            st.setInt(2, vehicleId);
            st.setInt(3, customerId);
            
            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error soft deleting car ID " + vehicleId, e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in softDeleteCar", e);
            throw new SQLException(e);
        }
        return success;
    }
    
    // Hàm thiết lập xe mặc định bằng Transaction
    public boolean setDefaultCar(int vehicleId, int customerId) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Gỡ mặc định tất cả xe của khách hàng này
            String resetSql = "UPDATE [Vehicles] SET [IsDefault] = 0 WHERE [CustomerID] = ?";
            try (PreparedStatement psReset = conn.prepareStatement(resetSql)) {
                psReset.setInt(1, customerId);
                psReset.executeUpdate();
            }
            
            // 2. Set mặc định cho chiếc xe được chỉ định
            String setSql = "UPDATE [Vehicles] SET [IsDefault] = 1 WHERE [VehicleID] = ? AND [CustomerID] = ?";
            try (PreparedStatement psSet = conn.prepareStatement(setSql)) {
                psSet.setInt(1, vehicleId);
                psSet.setInt(2, customerId);
                int updatedRows = psSet.executeUpdate();
                
                if (updatedRows == 0) {
                    conn.rollback();
                    return false; // Lỗi: Xe không tồn tại hoặc không phải của khách hàng này
                }
            }
            
            conn.commit();
            return true;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error setting default car", e);
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Rollback failed", ex);
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Failed to close connection", e);
                }
            }
        }
    }
}
