/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Timestamp;

public class Booking {

    private int bookingId;
    private int customerId;
    private String serviceNames;
    private int vehicleId;
    private Integer voucherId;
    private String licensePlate;
    private Timestamp bookingDate;
    private Timestamp scheduledTime;
    private Double originalPrice;
    private Double discountAmount;
    private Double finalPrice;
    private String paymentMethod;
    private String paymentStatus;
    private String status;
    private int priorityScore;

    private String serviceIdsStr;
    private int totalDurationMinutes;
    
    // New fields for display
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp actualStartTime;
    private Timestamp actualEndTime;

    public Booking() {
    }

    public Booking(int bookingId, int customerId, String serviceNames, int vehicleId, Integer voucherId, String licensePlate, Timestamp bookingDate, Timestamp scheduledTime, Double originalPrice, Double discountAmount, Double finalPrice, String paymentMethod, String paymentStatus, String status, int priorityScore) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.serviceNames = serviceNames;
        this.vehicleId = vehicleId;
        this.voucherId = voucherId;
        this.licensePlate = licensePlate;
        this.bookingDate = bookingDate;
        this.scheduledTime = scheduledTime;
        this.originalPrice = originalPrice;
        this.discountAmount = discountAmount;
        this.finalPrice = finalPrice;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.status = status;
        this.priorityScore = priorityScore;
    }

    public int getBookingId() {
        return bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getServiceNames() {
        return serviceNames;
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

    public void setServiceNames(String serviceNames) {
        this.serviceNames = serviceNames;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Timestamp getActualStartTime() {
        if (actualStartTime != null && bookingDate != null) {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            cal.setTime(actualStartTime);
            int year = cal.get(java.util.Calendar.YEAR);
            if (year == 1900 || year == 1970) {
                java.util.Calendar dateCal = java.util.Calendar.getInstance();
                dateCal.setTime(bookingDate);
                
                cal.set(java.util.Calendar.YEAR, dateCal.get(java.util.Calendar.YEAR));
                cal.set(java.util.Calendar.MONTH, dateCal.get(java.util.Calendar.MONTH));
                cal.set(java.util.Calendar.DAY_OF_MONTH, dateCal.get(java.util.Calendar.DAY_OF_MONTH));
                
                return new Timestamp(cal.getTimeInMillis());
            }
        }
        return actualStartTime;
    }

    public void setActualStartTime(Timestamp actualStartTime) {
        this.actualStartTime = actualStartTime;
    }

    public Timestamp getActualEndTime() {
        return actualEndTime;
    }

    public void setActualEndTime(Timestamp actualEndTime) {
        this.actualEndTime = actualEndTime;
    }

    public String getServiceIdsStr() {
        return serviceIdsStr;
    }

    public void setServiceIdsStr(String serviceIdsStr) {
        this.serviceIdsStr = serviceIdsStr;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}
