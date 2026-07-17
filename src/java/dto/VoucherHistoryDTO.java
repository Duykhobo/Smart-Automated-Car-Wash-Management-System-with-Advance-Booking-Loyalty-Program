package dto;

import java.util.Date;

public class VoucherHistoryDTO {
    private int voucherId;
    private String customerName;
    private String customerEmail;
    private String voucherCode;
    private String rewardType;
    private double discountPercent;
    private int pointsCost;
    private String status;
    private Date expiryDate;
    private Date createdAt;

    public VoucherHistoryDTO() {
    }

    public VoucherHistoryDTO(int voucherId, String customerName, String customerEmail, String voucherCode, String rewardType, double discountPercent, int pointsCost, String status, Date expiryDate, Date createdAt) {
        this.voucherId = voucherId;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.voucherCode = voucherCode;
        this.rewardType = rewardType;
        this.discountPercent = discountPercent;
        this.pointsCost = pointsCost;
        this.status = status;
        this.expiryDate = expiryDate;
        this.createdAt = createdAt;
    }

    public int getVoucherId() { return voucherId; }
    public void setVoucherId(int voucherId) { this.voucherId = voucherId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getVoucherCode() { return voucherCode; }
    public void setVoucherCode(String voucherCode) { this.voucherCode = voucherCode; }

    public String getRewardType() { return rewardType; }
    public void setRewardType(String rewardType) { this.rewardType = rewardType; }

    public double getDiscountPercent() { return discountPercent; }
    public void setDiscountPercent(double discountPercent) { this.discountPercent = discountPercent; }

    public int getPointsCost() { return pointsCost; }
    public void setPointsCost(int pointsCost) { this.pointsCost = pointsCost; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
