package utils;

public class ValidationUtil {
    /**
     * Hàm kiểm tra xem CÓ BẤT KỲ chuỗi nào bị Null hoặc Rỗng hay không.
     * Trả về true nếu có í
     */

    public static boolean isAnyEmpty(String... inputs) {
        if (inputs == null)
            return true;

        for (String str : inputs) {
            if (str == null || str.trim().isEmpty()) {
                return true; // Phát hiện có lỗi là dừng luôn
            }
        }
        return false;
    }
}
