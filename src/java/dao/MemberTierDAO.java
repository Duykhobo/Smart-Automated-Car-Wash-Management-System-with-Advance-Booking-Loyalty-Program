package dao;

import dto.MemberTier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;

public class MemberTierDAO {
    
    public List<MemberTier> getAllTiers() {
        List<MemberTier> list = new ArrayList<>();
        String sql = "SELECT * FROM MemberTiers ORDER BY PriorityRank ASC";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            
            while (rs.next()) {
                list.add(new MemberTier(
                    rs.getInt("TierID"),
                    rs.getString("TierName"),
                    rs.getInt("MinWashes"),
                    rs.getDouble("MinSpend"),
                    rs.getDouble("PointsModifier"),
                    rs.getInt("PriorityRank"),
                    rs.getInt("MaxBookingDays"),
                    rs.getString("BadgeClass"),
                    rs.getString("BannerBorder"),
                    rs.getString("BannerBg"),
                    rs.getString("BannerIcon"),
                    rs.getString("BannerText")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public MemberTier getTierByName(String tierName) {
        String sql = "SELECT * FROM MemberTiers WHERE TierName = ?";
        try (Connection cn = DBContext.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, tierName);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new MemberTier(
                        rs.getInt("TierID"),
                        rs.getString("TierName"),
                        rs.getInt("MinWashes"),
                        rs.getDouble("MinSpend"),
                        rs.getDouble("PointsModifier"),
                        rs.getInt("PriorityRank"),
                        rs.getInt("MaxBookingDays"),
                        rs.getString("BadgeClass"),
                        rs.getString("BannerBorder"),
                        rs.getString("BannerBg"),
                        rs.getString("BannerIcon"),
                        rs.getString("BannerText")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
