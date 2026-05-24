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
public class Promotion {

    private int promoId;
    private String title;
    private String description;
    private String targetTierMin;
    private Double discountPercent;
    private Date startDate;
    private Date endDate;
    private boolean isActive;

    public Promotion() {
    }

    public Promotion(int promoId, String title, String description, String targetTierMin, Double discountPercent, Date startDate, Date endDate, boolean isActive) {
        this.promoId = promoId;
        this.title = title;
        this.description = description;
        this.targetTierMin = targetTierMin;
        this.discountPercent = discountPercent;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActive = isActive;
    }

    public void setPromoId(int promoId) {
        this.promoId = promoId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setTargetTierMin(String targetTierMin) {
        this.targetTierMin = targetTierMin;
    }

    public void setDiscountPercent(Double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getPromoId() {
        return promoId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getTargetTierMin() {
        return targetTierMin;
    }

    public Double getDiscountPercent() {
        return discountPercent;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public boolean isIsActive() {
        return isActive;
    }

}
