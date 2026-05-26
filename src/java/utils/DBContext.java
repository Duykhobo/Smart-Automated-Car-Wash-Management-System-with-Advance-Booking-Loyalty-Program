package utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBContext {

    private static final String SERVER_NAME = "localhost";
    private static final String PORT_NUMBER = "1433";
    private static final String DB_NAME = "SmartCarWash";
    private static final String USER_ID = "sa";
    private static final String PASSWORD = "12345";
    
    // Khai báo DataSource dùng chung (Singleton Pattern ngầm)
    private static HikariDataSource dataSource;

    // Static block để khởi tạo Pool ngay khi class DBContext được load vào bộ nhớ lần đầu
    static {
        try {
            HikariConfig config = new HikariConfig();
            
            // Cấu hình URL kết nối tới SQL Server
            String url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT_NUMBER
                    + ";databaseName=" + DB_NAME + ";encrypt=false";
            config.setJdbcUrl(url);
            config.setUsername(USER_ID);
            config.setPassword(PASSWORD);
            config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // --- CẤU HÌNH TỐI ƯU CHO HIKARICP ---
            // Số connection tối đa giữ trong pool
            config.setMaximumPoolSize(10); 
            // Thời gian tối đa (ms) chịu đợi để mượn 1 connection, quá giờ ném Exception
            config.setConnectionTimeout(30000); 
            // Thời gian (ms) một connection được phép nằm không (nhàn rỗi) trước khi bị thu hồi
            config.setIdleTimeout(600000); 
            // Đặt tên pool để dễ debug sau này
            config.setPoolName("AutoWash-DB-Pool");

            // Khởi tạo Pool!
            dataSource = new HikariDataSource(config);
            
            System.out.println("HikariCP Connection Pool đã được khởi tạo thành công!");
            
        } catch (Exception e) {
            System.err.println("Lỗi nghiêm trọng khi khởi tạo HikariCP: ");
            e.printStackTrace();
        }
    }

    /**
     * Lấy một connection từ Pool thay vì tạo mới.
     * CỰC KỲ QUAN TRỌNG: Lấy xong phải gọi conn.close() (trong DAO) 
     * để trả connection lại cho Pool, nếu không Pool sẽ cạn kiệt.
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
    
    /**
     * Dùng để đóng toàn bộ Pool khi Tomcat bị tắt (thường viết trong Listener)
     */
    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("Đã đóng HikariCP Connection Pool.");
        }
    }

    // Hàm Main để Dev test local xem file jar đã nhận và kết nối được chưa
    public static void main(String[] args) {
        System.out.println("=== Test mượn Connection từ HikariCP Pool ===");
        try (Connection conn = DBContext.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Tuyệt vời! Đã lấy được connection: " + conn.toString());
            }
        } catch (SQLException e) {
            System.err.println("Lỗi rồi, check lại cấu hình hoặc xem SQL Server đã bật chưa:");
            e.printStackTrace();
        }
    }
}
