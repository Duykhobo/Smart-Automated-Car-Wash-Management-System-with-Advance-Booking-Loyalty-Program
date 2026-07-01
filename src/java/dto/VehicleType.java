package dto;

public class VehicleType {
    private int vehicleTypeId;
    private String typeName;
    private String vehicleSize;

    public VehicleType() {
    }

    public VehicleType(int vehicleTypeId, String typeName, String vehicleSize) {
        this.vehicleTypeId = vehicleTypeId;
        this.typeName = typeName;
        this.vehicleSize = vehicleSize;
    }

    public int getVehicleTypeId() {
        return vehicleTypeId;
    }

    public void setVehicleTypeId(int vehicleTypeId) {
        this.vehicleTypeId = vehicleTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getVehicleSize() {
        return vehicleSize;
    }

    public void setVehicleSize(String vehicleSize) {
        this.vehicleSize = vehicleSize;
    }

    @Override
    public String toString() {
        return "VehicleType{" + "vehicleTypeId=" + vehicleTypeId + ", typeName=" + typeName + ", vehicleSize=" + vehicleSize + '}';
    }
}
