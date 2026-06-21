/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Timestamp;

public class Booking {

    private int bookingId;
    private int customerId;
    private int serviceId;
    private int vehicleId;
    private Integer voucherId;
    private String licensePlate;
    private Timestamp bookingDate;
    private Timestamp scheduledTime;
    private Double originalPrice;
    private Double discountAmount;
    private Double finalPrice;
    private String status;
    private int priorityScore;

    public Booking() {
    }

    public Booking(int bookingId, int customerId, int serviceId, int vehicleId, Integer voucherId, String licensePlate, Timestamp bookingDate, Timestamp scheduledTime, Double originalPrice, Double discountAmount, Double finalPrice, String status, int priorityScore) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.vehicleId = vehicleId;
        this.voucherId = voucherId;
        this.licensePlate = licensePlate;
        this.bookingDate = bookingDate;
        this.scheduledTime = scheduledTime;
        this.originalPrice = originalPrice;
        this.discountAmount = discountAmount;
        this.finalPrice = finalPrice;
        this.status = status;
        this.priorityScore = priorityScore;
    }

    public int getBookingId() {
        return bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public Integer getVoucherId() {
        return voucherId;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public Timestamp getScheduledTime() {
        return scheduledTime;
    }

    public Double getOriginalPrice() {
        return originalPrice;
    }

    public Double getDiscountAmount() {
        return discountAmount;
    }

    public Double getFinalPrice() {
        return finalPrice;
    }

    public String getStatus() {
        return status;
    }

    public int getPriorityScore() {
        return priorityScore;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public void setVoucherId(Integer voucherId) {
        this.voucherId = voucherId;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public void setScheduledTime(Timestamp scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    public void setOriginalPrice(Double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public void setDiscountAmount(Double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public void setFinalPrice(Double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPriorityScore(int priorityScore) {
        this.priorityScore = priorityScore;
    }

}
