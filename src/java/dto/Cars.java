package dto;

import java.sql.Date;

public class Cars {
    private int VehicleID;
    private int CustomerID;
    private String LicensePlate;
    private String VehicleType;
    private String Color;
    private Date CreatedAt;
    private Date UpdatedAt;
    private boolean isActive;

    public Cars(int vehicleID, int customerID, String licensePlate, String vehicleType, String color, Date createdAt,
            Date updatedAt, boolean isActive) {
        VehicleID = vehicleID;
        CustomerID = customerID;
        LicensePlate = licensePlate;
        VehicleType = vehicleType;
        Color = color;
        CreatedAt = createdAt;
        UpdatedAt = updatedAt;
        this.isActive = isActive;
    }

    public int getVehicleID() {
        return VehicleID;   
    }

    public void setVehicleID(int vehicleID) {
        VehicleID = vehicleID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int customerID) {
        CustomerID = customerID;
    }

    public String getLicensePlate() {
        return LicensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        LicensePlate = licensePlate;
    }

    public String getVehicleType() {
        return VehicleType;
    }

    public void setVehicleType(String vehicleType) {
        VehicleType = vehicleType;
    }

    public String getColor() {
        return Color;
    }

    public void setColor(String color) {
        Color = color;
    }

    public Date getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Date createdAt) {
        CreatedAt = createdAt;
    }

    public Date getUpdatedAt() {
        return UpdatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        UpdatedAt = updatedAt;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }
    
}
