package dto;

import java.sql.Timestamp;

public class Cars {
    private int vehicleId;
    private int customerId;
    private String licensePlate;
    private String brand;
    private String model;
    private int vehicleTypeId;
    private String vehicleTypeName;
    private String vehicleSize;
    private String color;
    private String imageUrl;
    private boolean isDefault; // Đánh dấu xe mặc định
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isActive;

    public Cars() {
    }

    public Cars(int vehicleId, int customerId, String licensePlate, String brand, String model, int vehicleTypeId, String vehicleTypeName, String vehicleSize, String color, String imageUrl, boolean isDefault, Timestamp createdAt, Timestamp updatedAt, boolean isActive) {
        this.vehicleId = vehicleId;
        this.customerId = customerId;
        this.licensePlate = licensePlate;
        this.brand = brand;
        this.model = model;
        this.vehicleTypeId = vehicleTypeId;
        this.vehicleTypeName = vehicleTypeName;
        this.vehicleSize = vehicleSize;
        this.color = color;
        this.imageUrl = imageUrl;
        this.isDefault = isDefault;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
    }

    // Constructor nay dung khi them xe moi
    public Cars(int customerId, String licensePlate, String brand, String model, int vehicleTypeId, String color, String imageUrl, boolean isDefault, Timestamp createdAt, Timestamp updatedAt, boolean isActive) {
        this.customerId = customerId;
        this.licensePlate = licensePlate;
        this.brand = brand;
        this.model = model;
        this.vehicleTypeId = vehicleTypeId;
        this.color = color;
        this.imageUrl = imageUrl;
        this.isDefault = isDefault;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isActive = isActive;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(int vehicleTypeId) {
        this.vehicleTypeId = vehicleTypeId;
    }

    public String getVehicleTypeName() {
        return vehicleTypeName;
    }

    public void setVehicleTypeName(String vehicleTypeName) {
        this.vehicleTypeName = vehicleTypeName;
    }

    public String getVehicleSize() {
        return vehicleSize;
    }

    public void setVehicleSize(String vehicleSize) {
        this.vehicleSize = vehicleSize;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
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

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "Cars{" + "vehicleId=" + vehicleId + ", customerId=" + customerId + ", licensePlate=" + licensePlate + ", brand=" + brand + ", model=" + model + ", vehicleTypeId=" + vehicleTypeId + ", vehicleTypeName=" + vehicleTypeName + ", vehicleSize=" + vehicleSize + ", color=" + color + ", imageUrl=" + imageUrl + ", isDefault=" + isDefault + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", isActive=" + isActive + '}';
    }
}
