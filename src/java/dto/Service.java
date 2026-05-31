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
    private boolean isActive;

    public Service() {
    }

    public Service(int serviceId, String name, Double basePrice) {
        this.serviceId = serviceId;
        this.name = name;
        this.basePrice = basePrice;
        this.isActive = true; // default
    }

    public Service(int serviceId, String name, Double basePrice, boolean isActive) {
        this.serviceId = serviceId;
        this.name = name;
        this.basePrice = basePrice;
        this.isActive = isActive;
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

}
