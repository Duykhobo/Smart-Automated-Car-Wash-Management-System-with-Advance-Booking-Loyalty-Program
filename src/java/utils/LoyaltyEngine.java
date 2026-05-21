package utils;

public class LoyaltyEngine {
    // Quy tắc: 1 điểm = 1000 VND
    public static int calculatePoints(double spendAmount) {
        return (int) (spendAmount / 1000);
    }
}
