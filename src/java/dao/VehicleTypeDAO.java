package dao;

import dto.VehicleType;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VehicleTypeDAO {
    private static final Logger LOGGER = Logger.getLogger(VehicleTypeDAO.class.getName());

    public List<VehicleType> getAllVehicleTypes() throws SQLException {
        List<VehicleType> list = new ArrayList<>();
        String sql = "SELECT [VehicleTypeID], [TypeName], [VehicleSize] FROM [VehicleTypes] ORDER BY [VehicleTypeID]";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(new VehicleType(
                        rs.getInt("VehicleTypeID"),
                        rs.getString("TypeName"),
                        rs.getString("VehicleSize")
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all vehicle types", e);
            throw e;
        }
        return list;
    }
}
