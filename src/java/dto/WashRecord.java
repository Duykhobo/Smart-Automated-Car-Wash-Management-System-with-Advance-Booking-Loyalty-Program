/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Timestamp;

public class WashRecord {

    private int washRecordId;
    private int bookingId;
    private Timestamp actualStartTime; // Có thể null
    private Timestamp actualEndTime;   // Có thể null
    private Double lprConfidenceScore; // Có thể null
    private String operatorNotes;

    public WashRecord() {
    }

    public WashRecord(int washRecordId, int bookingId, Timestamp actualStartTime, Timestamp actualEndTime, Double lprConfidenceScore, String operatorNotes) {
        this.washRecordId = washRecordId;
        this.bookingId = bookingId;
        this.actualStartTime = actualStartTime;
        this.actualEndTime = actualEndTime;
        this.lprConfidenceScore = lprConfidenceScore;
        this.operatorNotes = operatorNotes;
    }

    public int getWashRecordId() {
        return washRecordId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public Timestamp getActualStartTime() {
        return actualStartTime;
    }

    public Timestamp getActualEndTime() {
        return actualEndTime;
    }

    public Double getLprConfidenceScore() {
        return lprConfidenceScore;
    }

    public String getOperatorNotes() {
        return operatorNotes;
    }

    public void setWashRecordId(int washRecordId) {
        this.washRecordId = washRecordId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public void setActualStartTime(Timestamp actualStartTime) {
        this.actualStartTime = actualStartTime;
    }

    public void setActualEndTime(Timestamp actualEndTime) {
        this.actualEndTime = actualEndTime;
    }

    public void setLprConfidenceScore(Double lprConfidenceScore) {
        this.lprConfidenceScore = lprConfidenceScore;
    }

    public void setOperatorNotes(String operatorNotes) {
        this.operatorNotes = operatorNotes;
    }

}
