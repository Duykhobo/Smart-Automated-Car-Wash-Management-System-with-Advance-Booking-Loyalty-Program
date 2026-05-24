
import java.sql.Connection;
import java.sql.SQLException;
import utils.DBContext;

public class Main {

    public static void main(String[] args) {
        System.out.println("=== Initiating Database Connection Test ===");

        try ( Connection conn = DBContext.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("---------------------------------------------------------");
                System.out.println("DBContext: CONNECTION TO [SmartCarWash] SUCCESSFUL!");
                System.out.println("---------------------------------------------------------");
            }
        } catch (ClassNotFoundException e) {
            System.err.println(
                    " FAILURE: SQL Server JDBC Driver not found! (Verify if the .jar file exists in your WEB-INF/lib directory)");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println(
                    " FAILURE: Connection rejected. Please double-check the Port, Credentials, or verify if the Database exists in SSMS.");
            e.printStackTrace();
        }
    }
}
