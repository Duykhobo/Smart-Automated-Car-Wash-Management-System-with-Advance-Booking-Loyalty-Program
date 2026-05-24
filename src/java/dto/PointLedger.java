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
public class PointLedger {

    private int ledgerId;
    private int customerId;
    private String referenceType;
    private Integer referenceId; // Có thể null
    private int pointsChange;
    private int pointsRemaining;
    private Date earnedDate;
    private Date expiryDate;
    private boolean isExpired;

    public PointLedger() {
    }

    public PointLedger(int ledgerId, int customerId, String referenceType, Integer referenceId, int pointsChange, int pointsRemaining, Date earnedDate, Date expiryDate, boolean isExpired) {
        this.ledgerId = ledgerId;
        this.customerId = customerId;
        this.referenceType = referenceType;
        this.referenceId = referenceId;
        this.pointsChange = pointsChange;
        this.pointsRemaining = pointsRemaining;
        this.earnedDate = earnedDate;
        this.expiryDate = expiryDate;
        this.isExpired = isExpired;
    }

    public int getLedgerId() {
        return ledgerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getReferenceType() {
        return referenceType;
    }

    public Integer getReferenceId() {
        return referenceId;
    }

    public int getPointsChange() {
        return pointsChange;
    }

    public int getPointsRemaining() {
        return pointsRemaining;
    }

    public Date getEarnedDate() {
        return earnedDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public boolean isIsExpired() {
        return isExpired;
    }

    public void setLedgerId(int ledgerId) {
        this.ledgerId = ledgerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setReferenceType(String referenceType) {
        this.referenceType = referenceType;
    }

    public void setReferenceId(Integer referenceId) {
        this.referenceId = referenceId;
    }

    public void setPointsChange(int pointsChange) {
        this.pointsChange = pointsChange;
    }

    public void setPointsRemaining(int pointsRemaining) {
        this.pointsRemaining = pointsRemaining;
    }

    public void setEarnedDate(Date earnedDate) {
        this.earnedDate = earnedDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public void setIsExpired(boolean isExpired) {
        this.isExpired = isExpired;
    }

}
