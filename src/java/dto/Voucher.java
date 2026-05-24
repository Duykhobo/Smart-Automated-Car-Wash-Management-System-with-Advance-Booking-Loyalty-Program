/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;

/**
 *
 * @author Quan
 */
public class Voucher {

    private int voucherId;
    private int customerId;
    private String voucherCode;
    private String rewardType;
    private int pointsCost;
    private Date expiryDate;
    private String status;

    public Voucher() {
    }

    public Voucher(int voucherId, int customerId, String voucherCode, String rewardType, int pointsCost, Date expiryDate, String status) {
        this.voucherId = voucherId;
        this.customerId = customerId;
        this.voucherCode = voucherCode;
        this.rewardType = rewardType;
        this.pointsCost = pointsCost;
        this.expiryDate = expiryDate;
        this.status = status;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public String getRewardType() {
        return rewardType;
    }

    public int getPointsCost() {
        return pointsCost;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public void setRewardType(String rewardType) {
        this.rewardType = rewardType;
    }

    public void setPointsCost(int pointsCost) {
        this.pointsCost = pointsCost;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
