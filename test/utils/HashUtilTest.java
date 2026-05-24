package utils;

import org.junit.Test;
import static org.junit.Assert.*;

public class HashUtilTest {

    @Test
    public void testHashPasswordConsistency() {
        // Test 1: Băm 2 lần cùng 1 mật khẩu phải ra kết quả giống nhau.
        String password = "mySecretPassword123";
        String hash1 = HashUtil.hashPassword(password);
        String hash2 = HashUtil.hashPassword(password);
        
        assertNotNull("Mã băm không được null", hash1);
        assertEquals("Hai lần băm cùng mật khẩu phải ra cùng chuỗi hash", hash1, hash2);
    }

    @Test
    public void testHashPasswordEmptyString() {
        // Test 2: Băm chuỗi rỗng vẫn phải ra một chuỗi hash cố định
        String hash = HashUtil.hashPassword("");
        assertNotNull(hash);
        // SHA-256 của chuỗi rỗng là e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
        assertEquals("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", hash);
    }

    @Test(expected = NullPointerException.class)
    public void testHashPasswordNull() {
        // Test 3: Truyền null phải văng lỗi (NullPointerException do getBytes() trên null)
        HashUtil.hashPassword(null);
    }
}
