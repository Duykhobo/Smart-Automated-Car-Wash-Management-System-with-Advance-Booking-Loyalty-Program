package utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Lớp tiện ích hỗ trợ định dạng và thao tác với thời gian
 */
public class DateUtil {

    private static final String DATE_FORMAT = "dd/MM/yyyy";
    private static final String DATETIME_FORMAT = "HH:mm - dd/MM/yyyy";

    /**
     * Chuyển java.util.Date hoặc java.sql.Date sang chuỗi dd/MM/yyyy
     */
    public static String formatDate(Date date) {
        if (date == null) return "N/A";
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(date);
    }

    /**
     * Chuyển java.sql.Timestamp sang chuỗi HH:mm - dd/MM/yyyy
     * Rất hữu dụng khi hiển thị lịch sử giao dịch, giờ đặt lịch...
     */
    public static String formatDateTime(Timestamp timestamp) {
        if (timestamp == null) return "N/A";
        SimpleDateFormat sdf = new SimpleDateFormat(DATETIME_FORMAT);
        return sdf.format(timestamp);
    }
    
    /**
     * Lấy thời gian hiện tại chuẩn Timestamp để insert vào database
     */
    public static Timestamp now() {
        return new Timestamp(System.currentTimeMillis());
    }
}
