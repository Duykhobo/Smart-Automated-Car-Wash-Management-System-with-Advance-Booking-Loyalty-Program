package dao;

import dto.Service;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBContext;

public class ServiceDAO {
    private static final Logger LOGGER = Logger.getLogger(ServiceDAO.class.getName());

    public List<Service> getAllActiveServices() throws SQLException {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT [ServiceID], [Name], [BasePrice] FROM [Services] WHERE [IsActive] = 1 ORDER BY [BasePrice] ASC";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("ServiceID");
                String name = rs.getString("Name");
                double price = rs.getDouble("BasePrice");
                services.add(new Service(id, name, price));
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
}
