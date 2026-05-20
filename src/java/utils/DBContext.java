package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private static final String SERVER_NAME = "localhost";
    private static final String PORT_NUMBER = "1433";
    private static final String DB_NAME = "SmartCarWash";
    private static final String USER_ID = "sa";
    private static final String PASSWORD = "12345";

    /**
     * Establishes a raw connection to the Microsoft SQL Server database.
     *
     * * @return Connection object linked to the specified Database
     * @throws SQLException if a database access error occurs or the url is
     * invalid
     * @throws ClassNotFoundException if the SQL Server JDBC Driver is missing
     * from the classpath
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Constructing the connection string.
        // 'encrypt=false' is explicitly added to bypass SSL Certificate validation issues commonly found in newer JDK versions.
        String url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT_NUMBER
                + ";databaseName=" + DB_NAME + ";user=" + USER_ID + ";password=" + PASSWORD + ";encrypt=false";
        // Dynamic loading of the Microsoft SQL Server JDBC Driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url);
    }

    /**
     * Main method for rapid local Unit Testing. You can right-click this file
     * inside your IDE (NetBeans) and select 'Run File'.
     */
    public static void main(String[] args) {
        System.out.println("=== Initiating Database Connection Test ===");
        // Utilizing Java's Try-With-Resources block to ensure automatic closure of the connection resource
        try ( Connection conn = DBContext.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("---------------------------------------------------------");
                System.out.println("DBContext: CONNECTION TO [SmartCarWash] SUCCESSFUL!");
                System.out.println("---------------------------------------------------------");
            }
        } catch (ClassNotFoundException e) {
            System.err.println(" FAILURE: SQL Server JDBC Driver not found! (Verify if the .jar file exists in your WEB-INF/lib directory)");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println(" FAILURE: Connection rejected. Please double-check the Port, Credentials, or verify if the Database exists in SSMS.");
            e.printStackTrace();
        }
    }
}
