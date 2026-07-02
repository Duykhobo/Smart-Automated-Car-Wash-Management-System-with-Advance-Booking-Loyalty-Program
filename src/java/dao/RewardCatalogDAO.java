package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dto.RewardCatalog;
import utils.DBContext;

public class RewardCatalogDAO {

    public List<RewardCatalog> getAllActiveRewards() throws Exception {
        List<RewardCatalog> list = new ArrayList<>();
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt " +
                     "FROM RewardCatalog WHERE IsActive = 1 ORDER BY PointsCost ASC";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                list.add(new RewardCatalog(
                    rs.getInt("RewardID"),
                    rs.getString("RewardName"),
                    rs.getString("Description"),
                    rs.getInt("PointsCost"),
                    rs.getString("RewardType"),
                    rs.getString("ImageIcon"),
                    rs.getBoolean("IsActive"),
                    rs.getTimestamp("CreatedAt"),
                    rs.getTimestamp("UpdatedAt")
                ));
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi lấy danh sách quà tặng: " + e.getMessage());
        }
        return list;
    }

    public RewardCatalog getRewardById(int rewardId) throws Exception {
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt " +
                     "FROM RewardCatalog WHERE RewardID = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, rewardId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new RewardCatalog(
                        rs.getInt("RewardID"),
                        rs.getString("RewardName"),
                        rs.getString("Description"),
                        rs.getInt("PointsCost"),
                        rs.getString("RewardType"),
                        rs.getString("ImageIcon"),
                        rs.getBoolean("IsActive"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi tìm phần quà bằng ID: " + e.getMessage());
        }
        return null;
    }

    public RewardCatalog getRewardByType(String rewardType) throws Exception {
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt " +
                     "FROM RewardCatalog WHERE RewardType = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setString(1, rewardType);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new RewardCatalog(
                        rs.getInt("RewardID"),
                        rs.getString("RewardName"),
                        rs.getString("Description"),
                        rs.getInt("PointsCost"),
                        rs.getString("RewardType"),
                        rs.getString("ImageIcon"),
                        rs.getBoolean("IsActive"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi tìm phần quà bằng Type: " + e.getMessage());
        }
        return null;
    }
}
