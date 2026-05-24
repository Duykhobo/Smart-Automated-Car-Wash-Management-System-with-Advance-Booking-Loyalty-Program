/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Date;

/**
 *
 * @author Quan
 */
public class Customer {

    private int customerId;
    private int userId;
    private String firstName;
    private String lastName;
    private String phone;
    private String licensePlate;
    private String tierStatus;
    private int pointsBalance;
    private Double totalSpend;
    private int totalWashes;
    private Date tierUpgradeDate;

    public Customer() {
    }

    public Customer(int customerId, int userId, String firstName, String lastName, String phone, String licensePlate, String tierStatus, int pointsBalance, Double totalSpend, int totalWashes, Date tierUpgradeDate) {
        this.customerId = customerId;
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.licensePlate = licensePlate;
        this.tierStatus = tierStatus;
        this.pointsBalance = pointsBalance;
        this.totalSpend = totalSpend;
        this.totalWashes = totalWashes;
        this.tierUpgradeDate = tierUpgradeDate;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public void setTierStatus(String tierStatus) {
        this.tierStatus = tierStatus;
    }

    public void setPointsBalance(int pointsBalance) {
        this.pointsBalance = pointsBalance;
    }

    public void setTotalSpend(Double totalSpend) {
        this.totalSpend = totalSpend;
    }

    public void setTotalWashes(int totalWashes) {
        this.totalWashes = totalWashes;
    }

    public void setTierUpgradeDate(Date tierUpgradeDate) {
        this.tierUpgradeDate = tierUpgradeDate;
    }

    public int getCustomerId() {
        return customerId;
    }

    public int getUserId() {
        return userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getPhone() {
        return phone;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public String getTierStatus() {
        return tierStatus;
    }

    public int getPointsBalance() {
        return pointsBalance;
    }

    public Double getTotalSpend() {
        return totalSpend;
    }

    public int getTotalWashes() {
        return totalWashes;
    }

    public Date getTierUpgradeDate() {
        return tierUpgradeDate;
    }

}
