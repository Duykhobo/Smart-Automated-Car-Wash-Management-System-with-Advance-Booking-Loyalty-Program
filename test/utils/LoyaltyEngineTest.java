package utils;
import org.junit.Assert;
import org.junit.Test;

public class LoyaltyEngineTest {

    @Test
    public void testCalculatePointsNormal() {
        int points = LoyaltyEngine.calculatePoints(50000);
        Assert.assertEquals("50,000 VND -> 50 diem", 50, points);
    }

    @Test
    public void testCalculatePointsZero() {
        int points = LoyaltyEngine.calculatePoints(0);
        Assert.assertEquals("0 VND -> 0 diem", 0, points);
    }

    @Test
    public void testCalculatePointsNegative() {
        int points = LoyaltyEngine.calculatePoints(-10000);
        // Tùy theo logic nghiệp vụ, ở đây tạm giả định điểm có thể âm nếu bị trừ tiền, 
        // hoặc nếu yêu cầu không âm thì logic cần sửa đổi (đây là cách test tìm ra bug)
        Assert.assertEquals("-10,000 VND -> -10 diem", -10, points);
    }

    @Test
    public void testCalculatePointsDecimal() {
        int points = LoyaltyEngine.calculatePoints(55500);
        Assert.assertEquals("55,500 VND -> 55 diem (bo phan thap phan)", 55, points);
    }
}
