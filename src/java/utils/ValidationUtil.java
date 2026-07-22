package utils;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Regex cho tên tiếng Việt (Chỉ chứa chữ cái và khoảng trắng)
    private static final String NAME_PATTERN = "^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";

    // Regex cho số điện thoại Việt Nam (Bắt đầu bằng 0, tổng cộng 10 số)
    private static final String PHONE_PATTERN = "^0\\d{9}$";

    // Regex cho biển số xe cơ bản (VD: 59A-12345 hoặc 59A1-12345)
    private static final String LICENSE_PLATE_PATTERN = "^[0-9]{2}[A-Z][0-9A-Z]?-[0-9]{4,5}$";

    // Regex cho email
    private static final String EMAIL_PATTERN = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";

    // Regex cho Voucher Code (Tối đa 30 ký tự, cho phép gạch ngang)
    private static final String VOUCHER_CODE_PATTERN = "^[A-Z0-9_-]{3,30}$";

    // Regex cho RewardType (Tối đa 30 ký tự, ví dụ: 10_PERCENT_OFF, FREE_WASH)
    private static final String REWARD_TYPE_PATTERN = "^[A-Z0-9_]{3,30}$";

    // Regex cho Tên Voucher / Reward (Tối đa 100 ký tự theo NVARCHAR(100))
    private static final String REWARD_NAME_PATTERN = "^[a-zA-Z0-9ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s%\\-&+,:()]{1,100}$";

    /**
     * Hàm kiểm tra xem CÓ BẤT KỲ chuỗi nào bị Null hoặc Rỗng hay không. Trả về
     * true nếu có
     */
    public static boolean isAnyEmpty(String... inputs) {
        if (inputs == null) {
            return true;
        }

        for (String str : inputs) {
            if (str == null || str.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    /**
     * Kiểm tra họ và tên hợp lệ (không chứa số, không chứa ký tự đặc biệt)
     */
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(NAME_PATTERN, name.trim());
    }

    /**
     * Kiểm tra số điện thoại Việt Nam hợp lệ
     */
    public static boolean isValidVNPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(PHONE_PATTERN, phone.trim());
    }

    /**
     * Kiểm tra biển số xe hợp lệ
     */
    public static boolean isValidLicensePlate(String plate) {
        if (plate == null || plate.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(LICENSE_PLATE_PATTERN, plate.trim());
    }

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(EMAIL_PATTERN, email.trim());
    }

    /**
     * Kiểm tra mã Voucher hợp lệ
     */
    public static boolean isValidVoucherCode(String code) {
        if (code == null || code.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(VOUCHER_CODE_PATTERN, code.trim());
    }

    /**
     * Kiểm tra RewardType hợp lệ (dành cho phần loại voucher trong DB)
     */
    public static boolean isValidRewardType(String type) {
        if (type == null || type.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(REWARD_TYPE_PATTERN, type.trim());
    }

    /**
     * Kiểm tra tên Voucher hợp lệ (Tối đa 100 ký tự)
     */
    public static boolean isValidRewardName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return Pattern.matches(REWARD_NAME_PATTERN, name.trim());
    }

    /**
     * Kiểm tra mật khẩu hợp lệ (tối thiểu 8 ký tự, không chứa khoảng trắng hai đầu)
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }
        if (password.length() < 8 || password.length() > 50) {
            return false;
        }
        // Có thể thêm regex phức tạp hơn ở đây nếu cần thiết
        return true;
    }

    /**
     * Kiểm tra số phải lớn hơn hoặc bằng 0 (không âm)
     */
    public static boolean isNonNegative(Number number) {
        if (number == null) return false;
        return number.doubleValue() >= 0;
    }

    /**
     * Kiểm tra số phải lớn hơn 0 (số dương)
     */
    public static boolean isPositive(Number number) {
        if (number == null) return false;
        return number.doubleValue() > 0;
    }

    /**
     * Kiểm tra % giảm giá phải nằm trong khoảng 1 đến 100
     */
    public static boolean isValidDiscountPercentage(Number percentage) {
        if (percentage == null) return false;
        double val = percentage.doubleValue();
        return val > 0 && val <= 100;
    }

    /**
     * Parse Integer an toàn, tránh văng NumberFormatException.
     * Trả về null nếu lỗi.
     */
    public static Integer parseIntSafe(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /**
     * Parse Double an toàn, tránh văng NumberFormatException.
     * Trả về null nếu lỗi.
     */
    public static Double parseDoubleSafe(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Double.parseDouble(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

}
