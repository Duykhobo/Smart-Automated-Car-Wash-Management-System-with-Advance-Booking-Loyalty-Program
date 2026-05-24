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
public class BookingSlotCapacity {

    private int slotId;
    private Date slotDate;
    private Date timeSlot;
    private int maxCapacity;
    private int currentBooked;

    public BookingSlotCapacity() {
    }

    public BookingSlotCapacity(int slotId, Date slotDate, Date timeSlot, int maxCapacity, int currentBooked) {
        this.slotId = slotId;
        this.slotDate = slotDate;
        this.timeSlot = timeSlot;
        this.maxCapacity = maxCapacity;
        this.currentBooked = currentBooked;
    }

    public int getSlotId() {
        return slotId;
    }

    public Date getSlotDate() {
        return slotDate;
    }

    public Date getTimeSlot() {
        return timeSlot;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }

    public int getCurrentBooked() {
        return currentBooked;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public void setSlotDate(Date slotDate) {
        this.slotDate = slotDate;
    }

    public void setTimeSlot(Date timeSlot) {
        this.timeSlot = timeSlot;
    }

    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    public void setCurrentBooked(int currentBooked) {
        this.currentBooked = currentBooked;
    }

}
