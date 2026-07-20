package dto;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class BookingDetailDTO {
    private int bookingId;
    private String customerName;
    private String customerPhone;
    private String vehiclePlate;
    private Timestamp bookingDate;
    private Timestamp scheduledTime;
    private String serviceName;
    private String status;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(int bookingId, String customerName, String customerPhone, String vehiclePlate, Timestamp bookingDate, Timestamp scheduledTime, String serviceName, String status) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.vehiclePlate = vehiclePlate;
        this.bookingDate = bookingDate;
        this.scheduledTime = scheduledTime;
        this.serviceName = serviceName;
        this.status = status;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getVehiclePlate() {
        return vehiclePlate;
    }

    public void setVehiclePlate(String vehiclePlate) {
        this.vehiclePlate = vehiclePlate;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Timestamp getScheduledTime() {
        return scheduledTime;
    }

    public void setScheduledTime(Timestamp scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
