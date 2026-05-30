package utils;

/**
 * Lưu trữ các hằng số (Constants) dùng chung cho toàn bộ hệ thống
 */
public class AppConstants {
    
    // Roles
    public static final String ROLE_ADMIN = "Admin";
    public static final String ROLE_CUSTOMER = "Customer";
    
    // Session Keys
    public static final String SESSION_USER_ACCOUNT = "loggedInUser"; // Lưu object User
    public static final String SESSION_CUSTOMER_INFO = "USER";        // Lưu object Customer
    public static final String SESSION_MSG_SUCCESS = "MESSAGE";
    public static final String SESSION_MSG_ERROR = "ERROR";
    
    // Booking Statuses (Dự kiến)
    public static final String BOOKING_PENDING = "Pending";
    public static final String BOOKING_CONFIRMED = "Confirmed";
    public static final String BOOKING_COMPLETED = "Completed";
    public static final String BOOKING_CANCELLED = "Cancelled";
    
    // Car Statuses
    public static final boolean STATUS_ACTIVE = true;
    public static final boolean STATUS_INACTIVE = false;
}
