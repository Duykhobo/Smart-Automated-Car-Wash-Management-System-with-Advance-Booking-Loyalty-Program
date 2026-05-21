package com.autowashpro.utils;
import org.junit.Assert;
import org.junit.Test;

public class LoyaltyEngineTest {
    @Test
    public void testCalculatePoints() {
        int points = LoyaltyEngine.calculatePoints(50000);
        // Expect: 50,000 VND chia 1000 = 50 diem
        Assert.assertEquals(50, points);
    }
}
