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

}
