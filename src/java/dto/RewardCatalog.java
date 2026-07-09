package dto;

import java.util.Date;

public class RewardCatalog {
    private int rewardId;
    private String rewardName;
    private String description;
    private int pointsCost;
    private String rewardType;
    private String imageIcon;
    private boolean isActive;
    private Date createdAt;
    private Date updatedAt;
    
    // Dynamic discount fields
    private String discountType;
    private double discountValue;
    private double maxDiscount;

    public RewardCatalog() {
    }

    public RewardCatalog(int rewardId, String rewardName, String description, int pointsCost, String rewardType, String imageIcon, boolean isActive, Date createdAt, Date updatedAt) {
        this.rewardId = rewardId;
        this.rewardName = rewardName;
        this.description = description;
        this.pointsCost = pointsCost;
        this.rewardType = rewardType;
        this.imageIcon = imageIcon;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public RewardCatalog(int rewardId, String rewardName, String description, int pointsCost, String rewardType, String imageIcon, boolean isActive, Date createdAt, Date updatedAt, String discountType, double discountValue, double maxDiscount) {
        this.rewardId = rewardId;
        this.rewardName = rewardName;
        this.description = description;
        this.pointsCost = pointsCost;
        this.rewardType = rewardType;
        this.imageIcon = imageIcon;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.maxDiscount = maxDiscount;
    }

    public int getRewardId() {
        return rewardId;
    }

    public void setRewardId(int rewardId) {
        this.rewardId = rewardId;
    }

    public String getRewardName() {
        return rewardName;
    }

    public void setRewardName(String rewardName) {
        this.rewardName = rewardName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPointsCost() {
        return pointsCost;
    }

    public void setPointsCost(int pointsCost) {
        this.pointsCost = pointsCost;
    }

    public String getRewardType() {
        return rewardType;
    }

    public void setRewardType(String rewardType) {
        this.rewardType = rewardType;
    }

    public String getImageIcon() {
        return imageIcon;
    }

    public void setImageIcon(String imageIcon) {
        this.imageIcon = imageIcon;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public double getMaxDiscount() {
        return maxDiscount;
    }

    public void setMaxDiscount(double maxDiscount) {
        this.maxDiscount = maxDiscount;
    }
}
