package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dto.Service;
import utils.DBContext;

public class ServiceDAO {
    private static final Logger LOGGER = Logger.getLogger(ServiceDAO.class.getName());

    /**
     * Lấy danh sách tất cả các Dịch Vụ đang hoạt động để hiển thị cho Khách hàng lựa chọn.
     * Logic mở rộng: Ngoài việc kiểm tra IsActive = 1, hệ thống còn kiểm tra trường InactiveFromDate.
     * Nếu InactiveFromDate tồn tại và lớn hơn Thời gian hiện tại, dịch vụ này vẫn hiển thị (để khách đã lỡ đặt vẫn thấy thông tin).
     * Tuy nhiên, UI sẽ cảnh báo dịch vụ này sắp ngừng hoạt động.
     *
     * @return Danh sách Dịch vụ (Service)
     * @throws SQLException nếu truy vấn CSDL lỗi
     */
    public List<Service> getAllActiveServices() throws SQLException {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT [ServiceID], [Name], [BasePrice], [DurationMinutes], [InactiveFromDate], [ServiceType] FROM [Services] WHERE [IsActive] = 1 AND ([InactiveFromDate] IS NULL OR [InactiveFromDate] > GETDATE()) ORDER BY [BasePrice] ASC";

        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("ServiceID");
                String name = rs.getString("Name");
                double price = rs.getDouble("BasePrice");
                int duration = rs.getInt("DurationMinutes");
                java.sql.Timestamp inactiveFrom = rs.getTimestamp("InactiveFromDate");
                String serviceType = rs.getString("ServiceType");
                services.add(new Service(id, name, price, duration, true, inactiveFrom, serviceType));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching active services", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getAllActiveServices", e);
            throw new SQLException(e);
        }
        return services;
    }

    public Service getServiceById(int id) throws SQLException {
        String sql = "SELECT [ServiceID], [Name], [BasePrice], [DurationMinutes], [ServiceType] FROM [Services] WHERE [ServiceID] = ?";
        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {

            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("Name");
                    double price = rs.getDouble("BasePrice");
                    int duration = rs.getInt("DurationMinutes");
                    String serviceType = rs.getString("ServiceType");
                    Service s = new Service(id, name, price, duration);
                    s.setServiceType(serviceType);
                    return s;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching service by ID", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getServiceById", e);
            throw new SQLException(e);
        }
        return null;
    }

    /**
     * Lấy JSON Map giá động theo kích cỡ xe.
     * Trả về định dạng: {"1": {"SEDAN": 70000.0, "SUV": 80000.0, "XLARGE": 90000.0}, "2": ...}
     */
    public String getServicePricesJson() throws SQLException {
        StringBuilder json = new StringBuilder("{");
        String sql = "SELECT [ServiceID], [VehicleSize], [Price] FROM [ServicePrices] ORDER BY [ServiceID]";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            int currentServiceId = -1;
            boolean firstService = true;
            boolean firstSize = true;

            while (rs.next()) {
                int serviceId = rs.getInt("ServiceID");
                String size = rs.getString("VehicleSize");
                double price = rs.getDouble("Price");

                if (serviceId != currentServiceId) {
                    if (!firstService) {
                        json.append("},");
                    }
                    json.append("\"").append(serviceId).append("\":{");
                    currentServiceId = serviceId;
                    firstService = false;
                    firstSize = true;
                }

                if (!firstSize) {
                    json.append(",");
                }
                json.append("\"").append(size).append("\":").append(price);
                firstSize = false;
            }
            if (!firstService) {
                json.append("}");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching service prices", e);
            throw e;
        }
        json.append("}");
        return json.toString();
    }

    public double getServicePrice(int serviceId, String vehicleSize) throws SQLException {
        String sql = "SELECT [Price] FROM [ServicePrices] WHERE [ServiceID] = ? AND [VehicleSize] = ?";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, serviceId);
            st.setString(2, vehicleSize);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("Price");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching service price", e);
            throw e;
        }
        // Fallback to base price if not found in ServicePrices
        Service s = getServiceById(serviceId);
        return (s != null) ? s.getBasePrice() : 0.0;
    }

    public boolean insertService(Service service) throws SQLException {
        boolean success = false;
        String sql = "INSERT INTO [Services] ([Name], [BasePrice], [IsActive]) VALUES (?, ?, 1)";
        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {

            st.setString(1, service.getName());
            st.setDouble(2, service.getBasePrice());

            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting service", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in insertService", e);
            throw new SQLException(e);
        }
        return success;
    }

    public boolean updateService(Service service) throws SQLException {
        boolean success = false;
        String sql = "UPDATE [Services] SET [Name] = ?, [BasePrice] = ?, [UpdatedAt] = GETDATE() WHERE [ServiceID] = ?";
        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {

            st.setString(1, service.getName());
            st.setDouble(2, service.getBasePrice());
            st.setInt(3, service.getServiceId());

            int rows = st.executeUpdate();
            if (rows > 0) {
                success = true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating service", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in updateService", e);
            throw new SQLException(e);
        }
        return success;
    }
    public List<Service> getAllServicesForAdmin() throws SQLException {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT s.[ServiceID], s.[Name], s.[BasePrice], s.[DurationMinutes], s.[IsActive], s.[InactiveFromDate], s.[ServiceType], " +
                     "       p1.Price AS PriceSedan, " +
                     "       p2.Price AS PriceSuv, " +
                     "       p3.Price AS PriceXlarge " +
                     "FROM [Services] s " +
                     "LEFT JOIN [ServicePrices] p1 ON s.ServiceID = p1.ServiceID AND p1.VehicleSize = 'SEDAN' " +
                     "LEFT JOIN [ServicePrices] p2 ON s.ServiceID = p2.ServiceID AND p2.VehicleSize = 'SUV' " +
                     "LEFT JOIN [ServicePrices] p3 ON s.ServiceID = p3.ServiceID AND p3.VehicleSize = 'XLARGE' " +
                     "ORDER BY s.[ServiceID] ASC";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("ServiceID");
                String name = rs.getString("Name");
                double price = rs.getDouble("BasePrice");
                int duration = rs.getInt("DurationMinutes");
                boolean isActive = rs.getBoolean("IsActive");
                java.sql.Timestamp inactiveFrom = rs.getTimestamp("InactiveFromDate");
                String serviceType = rs.getString("ServiceType");
                
                Service s = new Service(id, name, price, duration, isActive, inactiveFrom, serviceType);
                
                double priceSedan = rs.getDouble("PriceSedan");
                if (rs.wasNull()) priceSedan = price;
                
                double priceSuv = rs.getDouble("PriceSuv");
                if (rs.wasNull()) priceSuv = price;
                
                double priceXlarge = rs.getDouble("PriceXlarge");
                if (rs.wasNull()) priceXlarge = price;
                
                s.setPriceSedan(priceSedan);
                s.setPriceSuv(priceSuv);
                s.setPriceXlarge(priceXlarge);
                
                services.add(s);
            }
        }
        return services;
    }

    public boolean createServiceWithPrices(Service service) throws SQLException {
        String sqlService = "INSERT INTO [Services] ([Name], [BasePrice], [DurationMinutes], [IsActive], [ServiceType]) VALUES (?, ?, ?, 1, ?)";
        String sqlPrice = "INSERT INTO [ServicePrices] ([ServiceID], [VehicleSize], [Price]) VALUES (?, ?, ?)";
        
        dao.SystemConfigDAO configDAO = new dao.SystemConfigDAO();
        double mulSedan = 1.0, mulSuv = 1.2, mulXlarge = 1.5;
        try { mulSedan = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_SEDAN")); } catch(Exception e){}
        try { mulSuv = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_SUV")); } catch(Exception e){}
        try { mulXlarge = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_XLARGE")); } catch(Exception e){}
        
        try (Connection cn = DBContext.getConnection()) {
            cn.setAutoCommit(false);
            try (PreparedStatement stService = cn.prepareStatement(sqlService, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                stService.setString(1, service.getName());
                stService.setDouble(2, service.getBasePrice());
                stService.setInt(3, service.getDurationMinutes());
                stService.setString(4, service.getServiceType() != null ? service.getServiceType() : "Main");
                
                int affected = stService.executeUpdate();
                if (affected > 0) {
                    int serviceId = -1;
                    try (ResultSet rs = stService.getGeneratedKeys()) {
                        if (rs.next()) serviceId = rs.getInt(1);
                    }
                    
                    if (serviceId != -1) {
                        try (PreparedStatement stPrice = cn.prepareStatement(sqlPrice)) {
                            stPrice.setInt(1, serviceId); stPrice.setString(2, "SEDAN"); stPrice.setDouble(3, service.getBasePrice() * mulSedan); stPrice.executeUpdate();
                            stPrice.setInt(1, serviceId); stPrice.setString(2, "SUV"); stPrice.setDouble(3, service.getBasePrice() * mulSuv); stPrice.executeUpdate();
                            stPrice.setInt(1, serviceId); stPrice.setString(2, "XLARGE"); stPrice.setDouble(3, service.getBasePrice() * mulXlarge); stPrice.executeUpdate();
                        }
                        cn.commit();
                        return true;
                    }
                }
                cn.rollback();
                return false;
            } catch (SQLException e) {
                cn.rollback();
                throw e;
            }
        }
    }

    public boolean updateServiceWithPrices(Service service) throws SQLException {
        String sqlService = "UPDATE [Services] SET [Name] = ?, [BasePrice] = ?, [DurationMinutes] = ?, [IsActive] = ?, [UpdatedAt] = GETDATE(), [ServiceType] = ? WHERE [ServiceID] = ?";
        
        dao.SystemConfigDAO configDAO = new dao.SystemConfigDAO();
        double mulSedan = 1.0, mulSuv = 1.2, mulXlarge = 1.5;
        try { mulSedan = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_SEDAN")); } catch(Exception e){}
        try { mulSuv = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_SUV")); } catch(Exception e){}
        try { mulXlarge = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_XLARGE")); } catch(Exception e){}
        
        try (Connection cn = DBContext.getConnection()) {
            cn.setAutoCommit(false);
            try {
                try (PreparedStatement stService = cn.prepareStatement(sqlService)) {
                    stService.setString(1, service.getName());
                    stService.setDouble(2, service.getBasePrice());
                    stService.setInt(3, service.getDurationMinutes());
                    stService.setBoolean(4, service.isIsActive());
                    stService.setString(5, service.getServiceType() != null ? service.getServiceType() : "Main");
                    stService.setInt(6, service.getServiceId());
                    stService.executeUpdate();
                }
                
                updateOrInsertPrice(cn, service.getServiceId(), "SEDAN", service.getBasePrice() * mulSedan);
                updateOrInsertPrice(cn, service.getServiceId(), "SUV", service.getBasePrice() * mulSuv);
                updateOrInsertPrice(cn, service.getServiceId(), "XLARGE", service.getBasePrice() * mulXlarge);
                
                cn.commit();
                return true;
            } catch (SQLException e) {
                cn.rollback();
                throw e;
            }
        }
    }

    public void syncAllServicePrices() throws SQLException {
        dao.SystemConfigDAO configDAO = new dao.SystemConfigDAO();
        double mulSedan = 1.0, mulSuv = 1.2, mulXlarge = 1.5;
        try { mulSedan = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_SEDAN")); } catch(Exception e){}
        try { mulSuv = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_SUV")); } catch(Exception e){}
        try { mulXlarge = Double.parseDouble(configDAO.getConfigValue("VehicleMultiplier_XLARGE")); } catch(Exception e){}

        String fetchSql = "SELECT ServiceID, BasePrice FROM [Services]";
        try (Connection cn = DBContext.getConnection()) {
            cn.setAutoCommit(false);
            try {
                try (PreparedStatement stFetch = cn.prepareStatement(fetchSql);
                     ResultSet rs = stFetch.executeQuery()) {
                    while (rs.next()) {
                        int serviceId = rs.getInt("ServiceID");
                        double basePrice = rs.getDouble("BasePrice");
                        
                        updateOrInsertPrice(cn, serviceId, "SEDAN", basePrice * mulSedan);
                        updateOrInsertPrice(cn, serviceId, "SUV", basePrice * mulSuv);
                        updateOrInsertPrice(cn, serviceId, "XLARGE", basePrice * mulXlarge);
                    }
                }
                cn.commit();
            } catch (SQLException e) {
                cn.rollback();
                throw e;
            }
        }
    }

    private void updateOrInsertPrice(Connection cn, int serviceId, String vehicleSize, double price) throws SQLException {
        String checkSql = "SELECT 1 FROM [ServicePrices] WHERE [ServiceID] = ? AND [VehicleSize] = ?";
        String updateSql = "UPDATE [ServicePrices] SET [Price] = ? WHERE [ServiceID] = ? AND [VehicleSize] = ?";
        String insertSql = "INSERT INTO [ServicePrices] ([ServiceID], [VehicleSize], [Price]) VALUES (?, ?, ?)";
        
        boolean exists = false;
        try (PreparedStatement checkSt = cn.prepareStatement(checkSql)) {
            checkSt.setInt(1, serviceId);
            checkSt.setString(2, vehicleSize);
            try (ResultSet rs = checkSt.executeQuery()) {
                if (rs.next()) exists = true;
            }
        }
        
        if (exists) {
            try (PreparedStatement updateSt = cn.prepareStatement(updateSql)) {
                updateSt.setDouble(1, price);
                updateSt.setInt(2, serviceId);
                updateSt.setString(3, vehicleSize);
                updateSt.executeUpdate();
            }
        } else {
            try (PreparedStatement insertSt = cn.prepareStatement(insertSql)) {
                insertSt.setInt(1, serviceId);
                insertSt.setString(2, vehicleSize);
                insertSt.setDouble(3, price);
                insertSt.executeUpdate();
            }
        }
    }

    public boolean toggleServiceStatus(int serviceId, boolean isActive) throws SQLException {
        String sql = "UPDATE [Services] SET [IsActive] = ?, [UpdatedAt] = GETDATE() WHERE [ServiceID] = ?";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setBoolean(1, isActive);
            st.setInt(2, serviceId);
            return st.executeUpdate() > 0;
        }
    }
}
