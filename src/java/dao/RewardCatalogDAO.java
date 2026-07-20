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
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt, DiscountPercent " +
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
                    rs.getTimestamp("UpdatedAt"),
                    rs.getDouble("DiscountPercent")
                ));
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi lấy danh sách quà tặng: " + e.getMessage());
        }
        return list;
    }

    public List<RewardCatalog> getAllRewards() throws Exception {
        List<RewardCatalog> list = new ArrayList<>();
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt, DiscountPercent " +
                     "FROM RewardCatalog ORDER BY PointsCost ASC";

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
                    rs.getTimestamp("UpdatedAt"),
                    rs.getDouble("DiscountPercent")
                ));
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi lấy toàn bộ danh sách quà tặng: " + e.getMessage());
        }
        return list;
    }

    public RewardCatalog getRewardById(int rewardId) throws Exception {
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt, DiscountPercent " +
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
                        rs.getTimestamp("UpdatedAt"),
                        rs.getDouble("DiscountPercent")
                    );
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi tìm phần quà bằng ID: " + e.getMessage());
        }
        return null;
    }

    public RewardCatalog getRewardByType(String rewardType) throws Exception {
        String sql = "SELECT RewardID, RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt, DiscountPercent " +
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
                        rs.getTimestamp("UpdatedAt"),
                        rs.getDouble("DiscountPercent")
                    );
                }
            }
        } catch (SQLException e) {
            throw new Exception("Lỗi khi tìm phần quà bằng Type: " + e.getMessage());
        }
        return null;
    }

    public void addReward(RewardCatalog reward) throws Exception {
        String sql = "INSERT INTO RewardCatalog (RewardName, Description, PointsCost, RewardType, ImageIcon, IsActive, CreatedAt, UpdatedAt, DiscountPercent) " +
                     "VALUES (?, ?, ?, ?, ?, 1, GETDATE(), GETDATE(), ?)";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setString(1, reward.getRewardName());
            st.setString(2, reward.getDescription());
            st.setInt(3, reward.getPointsCost());
            st.setString(4, reward.getRewardType());
            st.setString(5, reward.getImageIcon());
            st.setDouble(6, reward.getDiscountPercent());
            
            st.executeUpdate();
            
        } catch (SQLException e) {
            throw new Exception("Lỗi khi thêm Voucher mới: " + e.getMessage());
        }
    }

    public void updateReward(RewardCatalog reward) throws Exception {
        String sql = "UPDATE RewardCatalog SET RewardName = ?, Description = ?, PointsCost = ?, RewardType = ?, ImageIcon = ?, DiscountPercent = ?, UpdatedAt = GETDATE() WHERE RewardID = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setString(1, reward.getRewardName());
            st.setString(2, reward.getDescription());
            st.setInt(3, reward.getPointsCost());
            st.setString(4, reward.getRewardType());
            st.setString(5, reward.getImageIcon());
            st.setDouble(6, reward.getDiscountPercent());
            st.setInt(7, reward.getRewardId());
            
            st.executeUpdate();
            
        } catch (SQLException e) {
            throw new Exception("Lỗi khi cập nhật Voucher: " + e.getMessage());
        }
    }

    public void toggleRewardStatus(int rewardId, boolean isActive) throws Exception {
        String sql = "UPDATE RewardCatalog SET IsActive = ?, UpdatedAt = GETDATE() WHERE RewardID = ?";

        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setBoolean(1, isActive);
            st.setInt(2, rewardId);
            
            st.executeUpdate();
            
        } catch (SQLException e) {
            throw new Exception("Lỗi khi đổi trạng thái Voucher: " + e.getMessage());
        }
    }
}
