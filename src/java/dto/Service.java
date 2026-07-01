/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author Quan
 */
public class Service {

    private int serviceId;
    private String name;
    private Double basePrice;
    private int durationMinutes;
    private boolean isActive;

    private java.sql.Timestamp inactiveFromDate;

    public Service() {
    }

    public Service(int serviceId, String name, Double basePrice, int durationMinutes) {
        this.serviceId = serviceId;
        this.name = name;
        this.basePrice = basePrice;
        this.durationMinutes = durationMinutes;
        this.isActive = true; // default
    }

    public Service(int serviceId, String name, Double basePrice, int durationMinutes, boolean isActive, java.sql.Timestamp inactiveFromDate) {
        this.serviceId = serviceId;
        this.name = name;
        this.basePrice = basePrice;
        this.durationMinutes = durationMinutes;
        this.isActive = isActive;
        this.inactiveFromDate = inactiveFromDate;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBasePrice(Double basePrice) {
        this.basePrice = basePrice;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public int getServiceId() {
        return serviceId;
    }

    public String getName() {
        return name;
    }

    public Double getBasePrice() {
        return basePrice;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public java.sql.Timestamp getInactiveFromDate() {
        return inactiveFromDate;
    }

    public void setInactiveFromDate(java.sql.Timestamp inactiveFromDate) {
        this.inactiveFromDate = inactiveFromDate;
    }

}
