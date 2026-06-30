package utils;

/**
 * Lớp AppConstants
 * Nơi lưu trữ tập trung các hằng số (Constants) dùng chung cho toàn bộ hệ thống.
 * Việc sử dụng lớp này giúp tránh hiện tượng "Hard code" magic numbers hoặc magic strings,
 * qua đó tăng tính bảo trì và giảm thiểu lỗi chính tả khi tham chiếu.
 */
public class AppConstants {
    
    // ==========================================
    // ROLE & AUTHORITY CONSTANTS
    // ==========================================
    public static final String ROLE_ADMIN = "Admin";
    public static final String ROLE_CUSTOMER = "Customer";
    
    // ==========================================
    // SESSION ATTRIBUTE KEYS
    // ==========================================
    /** Khóa lưu trữ đối tượng User đang đăng nhập trong Session */
    public static final String SESSION_USER_ACCOUNT = "loggedInUser"; 
    /** Khóa lưu trữ đối tượng Customer Profile trong Session */
    public static final String SESSION_CUSTOMER_INFO = "USER";        
    /** Khóa lưu trữ thông báo thành công dạng Flash message */
    public static final String SESSION_MSG_SUCCESS = "SUCCESS";
    /** Khóa lưu trữ thông báo lỗi dạng Flash message */
    public static final String SESSION_MSG_ERROR = "ERROR";
    
    // ==========================================
    // BOOKING STATUSES
    // ==========================================
    public static final String BOOKING_PENDING = "Pending";
    public static final String BOOKING_CONFIRMED = "Confirmed";
    public static final String BOOKING_COMPLETED = "Completed";
    public static final String BOOKING_CANCELLED = "Cancelled";
    
    // ==========================================
    // GENERAL STATUS BOOLEANS
    // ==========================================
    public static final boolean STATUS_ACTIVE = true;
    public static final boolean STATUS_INACTIVE = false;
    
    // ==========================================
    // DEFAULT SYSTEM CONFIGURATIONS (FALLBACKS)
    // Các giá trị này được dùng dự phòng khi Database (SystemConfig) không lấy được dữ liệu.
    // ==========================================
    /** Giờ mở cửa mặc định (8h sáng) */
    public static final int DEFAULT_OPENING_HOUR = 8;
    /** Giờ đóng cửa mặc định (19h chiều / 7h chiều) */
    public static final int DEFAULT_CLOSING_HOUR = 19;
    /** Thời gian (phút) tối thiểu phải đặt trước so với giờ hẹn (dùng cho khách hàng di chuyển) */
    public static final int DEFAULT_MIN_ADVANCE_BOOKING_MINUTES = 60;
    /** Thời gian (phút) tối thiểu trước giờ hẹn mà khách có quyền tự hủy lịch */
    public static final int DEFAULT_MIN_CANCELLATION_MINUTES = 120;
}
