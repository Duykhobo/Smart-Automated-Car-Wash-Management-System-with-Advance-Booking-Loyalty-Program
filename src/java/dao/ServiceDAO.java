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
        String sql = "SELECT [ServiceID], [Name], [BasePrice], [DurationMinutes], [InactiveFromDate] FROM [Services] WHERE [IsActive] = 1 AND ([InactiveFromDate] IS NULL OR [InactiveFromDate] > GETDATE()) ORDER BY [BasePrice] ASC";

        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("ServiceID");
                String name = rs.getString("Name");
                double price = rs.getDouble("BasePrice");
                int duration = rs.getInt("DurationMinutes");
                java.sql.Timestamp inactiveFrom = rs.getTimestamp("InactiveFromDate");
                services.add(new Service(id, name, price, duration, true, inactiveFrom));
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
        String sql = "SELECT [ServiceID], [Name], [BasePrice], [DurationMinutes] FROM [Services] WHERE [ServiceID] = ?";
        try (Connection cn = DBContext.getConnection();
                PreparedStatement st = cn.prepareStatement(sql)) {

            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("Name");
                    double price = rs.getDouble("BasePrice");
                    int duration = rs.getInt("DurationMinutes");
                    return new Service(id, name, price, duration);
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
}
