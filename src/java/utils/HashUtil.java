package utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashUtil {
    // Sinh Salt ngẫu nhiên
    public static String generateSalt() {
        java.security.SecureRandom random = new java.security.SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        StringBuilder hexString = new StringBuilder();
        for (byte b : salt) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }

    // Băm mật khẩu (Kèm Salt)
    private static String hashPasswordWithSalt(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            // Kết hợp mật khẩu và salt
            md.update(salt.getBytes());
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi: Không tìm thấy thuật toán mã hóa SHA-256", e);
        }
    }

    // Băm mật khẩu thuần túy (CŨ - Không an toàn) -> Giữ lại để verify tài khoản cũ
    public static String hashPasswordLegacy(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();

            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi: Không tìm thấy thuật toán mã hóa SHA-256", e);
        }
    }

    // Tạo Hash chuẩn mới (Định dạng: salt:hash)
    public static String createHash(String password) {
        String salt = generateSalt();
        String hash = hashPasswordWithSalt(password, salt);
        return salt + ":" + hash;
    }

    // Kiểm tra mật khẩu (Hỗ trợ cả chuẩn MỚI và CŨ)
    public static boolean verifyPassword(String rawPassword, String storedHash) {
        if (storedHash == null || storedHash.isEmpty()) return false;

        if (storedHash.contains(":")) {
            // Chuẩn MỚI: Có Salt (salt:hash)
            String[] parts = storedHash.split(":");
            if (parts.length != 2) return false;
            
            String salt = parts[0];
            String expectedHash = parts[1];
            String actualHash = hashPasswordWithSalt(rawPassword, salt);
            
            return expectedHash.equals(actualHash);
        } else {
            // Chuẩn CŨ: Không có Salt (Legacy)
            String actualHash = hashPasswordLegacy(rawPassword);
            return storedHash.equals(actualHash);
        }
    }
}
