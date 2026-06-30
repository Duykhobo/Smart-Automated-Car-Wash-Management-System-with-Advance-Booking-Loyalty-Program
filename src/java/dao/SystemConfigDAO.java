package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import dto.SystemConfig;
import utils.DBContext;

/**
 * SystemConfigDAO đảm nhiệm việc thao tác cơ sở dữ liệu cho bảng SystemConfig.
 * Lớp này chịu trách nhiệm lấy các cấu hình động của hệ thống (như giờ làm việc, thời gian chờ đặt lịch, ...).
 * Nếu xảy ra sự cố truy xuất, nó sẽ tự động trả về giá trị dự phòng (Fallback) từ AppConstants để hệ thống không bị crash.
 */
public class SystemConfigDAO {
    private static final Logger LOGGER = Logger.getLogger(SystemConfigDAO.class.getName());

    /**
     * Lấy toàn bộ danh sách cấu hình hiện có trong DB dưới dạng Map(Key-Value).
     * @return Map chứa ConfigKey là khóa và ConfigValue là giá trị.
     * @throws SQLException Nếu có lỗi khi kết nối hoặc truy vấn DB.
     */
    public Map<String, String> getAllConfigs() throws SQLException {
        Map<String, String> configs = new HashMap<>();
        String sql = "SELECT [ConfigKey], [ConfigValue] FROM [SystemConfig]";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                configs.put(rs.getString("ConfigKey"), rs.getString("ConfigValue"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all system configs", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getAllConfigs", e);
            throw new SQLException(e);
        }
        return configs;
    }

    /**
     * Lấy giá trị của một cấu hình cụ thể dựa trên khóa (Key).
     * @param key Tên của ConfigKey (vd: "OpeningHour").
     * @return Chuỗi ConfigValue tương ứng, hoặc null nếu không tồn tại.
     * @throws SQLException Nếu có lỗi khi kết nối DB.
     */
    public String getConfigValue(String key) throws SQLException {
        String sql = "SELECT [ConfigValue] FROM [SystemConfig] WHERE [ConfigKey] = ?";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {

            st.setString(1, key);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("ConfigValue");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching system config by key", e);
            throw e;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in getConfigValue", e);
            throw new SQLException(e);
        }
        return null;
    }

    /**
     * Tiện ích lấy Giờ mở cửa của cửa hàng.
     * @return Giờ (int), dùng giá trị DB, nếu lỗi sẽ tự động fallback về AppConstants.DEFAULT_OPENING_HOUR.
     */
    public int getOpeningHour() {
        try {
            String val = getConfigValue("OpeningHour");
            return val != null ? Integer.parseInt(val) : utils.AppConstants.DEFAULT_OPENING_HOUR;
        } catch (Exception e) {
            return utils.AppConstants.DEFAULT_OPENING_HOUR;
        }
    }

    /**
     * Tiện ích lấy Giờ đóng cửa của cửa hàng.
     * @return Giờ (int), dùng giá trị DB, nếu lỗi sẽ tự động fallback về AppConstants.DEFAULT_CLOSING_HOUR.
     */
    public int getClosingHour() {
        try {
            String val = getConfigValue("ClosingHour");
            return val != null ? Integer.parseInt(val) : utils.AppConstants.DEFAULT_CLOSING_HOUR;
        } catch (Exception e) {
            return utils.AppConstants.DEFAULT_CLOSING_HOUR;
        }
    }

    /**
     * Tiện ích lấy Thời gian đặt trước tối thiểu (để khách có thời gian di chuyển).
     * @return Thời gian bằng phút (int), fallback về AppConstants.DEFAULT_MIN_ADVANCE_BOOKING_MINUTES.
     */
    public int getMinAdvanceBookingMinutes() {
        try {
            String val = getConfigValue("MinAdvanceBookingMinutes");
            return val != null ? Integer.parseInt(val) : utils.AppConstants.DEFAULT_MIN_ADVANCE_BOOKING_MINUTES;
        } catch (Exception e) {
            return utils.AppConstants.DEFAULT_MIN_ADVANCE_BOOKING_MINUTES;
        }
    }

    /**
     * Tiện ích lấy Thời gian hủy trước tối thiểu (hệ thống cần chuẩn bị slot cho khách khác).
     * @return Thời gian bằng phút (int), fallback về AppConstants.DEFAULT_MIN_CANCELLATION_MINUTES.
     */
    public int getMinCancellationMinutes() {
        try {
            String val = getConfigValue("MinCancellationMinutes");
            return val != null ? Integer.parseInt(val) : utils.AppConstants.DEFAULT_MIN_CANCELLATION_MINUTES;
        } catch (Exception e) {
            return utils.AppConstants.DEFAULT_MIN_CANCELLATION_MINUTES;
        }
    }

    /**
     * Tiện ích lấy tỉ lệ quy đổi điểm (Vd: 10000 VND = 1 Điểm)
     */
    public int getPointsPerCurrencyUnit() {
        try {
            String val = getConfigValue("PointsPerCurrencyUnit");
            return val != null ? Integer.parseInt(val) : 10000;
        } catch (Exception e) {
            return 10000;
        }
    }

    /**
     * Cập nhật giá trị cấu hình. Nếu chưa có thì Insert, nếu có rồi thì Update.
     */
    public boolean updateConfigValue(String key, String value) {
        // Cố gắng update trước
        String updateSql = "UPDATE [SystemConfig] SET [ConfigValue] = ?, [UpdatedAt] = GETDATE() WHERE [ConfigKey] = ?";
        String insertSql = "INSERT INTO [SystemConfig] ([ConfigKey], [ConfigValue]) VALUES (?, ?)";
        
        try (Connection cn = DBContext.getConnection();
             PreparedStatement updateSt = cn.prepareStatement(updateSql)) {
            
            updateSt.setString(1, value);
            updateSt.setString(2, key);
            int rows = updateSt.executeUpdate();
            
            if (rows > 0) {
                return true;
            }
            
            // Nếu rows == 0 có nghĩa là key chưa tồn tại, ta chuyển sang Insert
            try (PreparedStatement insertSt = cn.prepareStatement(insertSql)) {
                insertSt.setString(1, key);
                insertSt.setString(2, value);
                return insertSt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating system config", e);
            return false;
        }
    }
}
