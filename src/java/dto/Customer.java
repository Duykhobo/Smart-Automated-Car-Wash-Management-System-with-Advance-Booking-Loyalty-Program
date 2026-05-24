package dto;

import java.sql.Timestamp;

public class Customer {

    private int customerId;
    private int userId;
    private String fullName;
    private String phone;
    private String licensePlate;
    private String tierStatus;
    private int pointsBalance;
    private Double totalSpend;
    private int totalWashes;
    private Timestamp tierUpgradeDate;

    public Customer() {
    }

    public Customer(int customerId, int userId, String fullName, String phone, String licensePlate, String tierStatus, int pointsBalance, Double totalSpend, int totalWashes, Timestamp tierUpgradeDate) {
        this.customerId = customerId;
        this.userId = userId;
        this.fullName = fullName;
        this.phone = phone;
        this.licensePlate = licensePlate;
        this.tierStatus = tierStatus;
        this.pointsBalance = pointsBalance;
        this.totalSpend = totalSpend;
        this.totalWashes = totalWashes;
        this.tierUpgradeDate = tierUpgradeDate;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getTierStatus() {
        return tierStatus;
    }

    public void setTierStatus(String tierStatus) {
        this.tierStatus = tierStatus;
    }

    public int getPointsBalance() {
        return pointsBalance;
    }

    public void setPointsBalance(int pointsBalance) {
        this.pointsBalance = pointsBalance;
    }

    public Double getTotalSpend() {
        return totalSpend;
    }

    public void setTotalSpend(Double totalSpend) {
        this.totalSpend = totalSpend;
    }

    public int getTotalWashes() {
        return totalWashes;
    }

    public void setTotalWashes(int totalWashes) {
        this.totalWashes = totalWashes;
    }

    public Timestamp getTierUpgradeDate() {
        return tierUpgradeDate;
    }

    public void setTierUpgradeDate(Timestamp tierUpgradeDate) {
        this.tierUpgradeDate = tierUpgradeDate;
    }
}
