package com.autowashpro.utils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBContext {
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=AutoWashPro";
    private static final String USER = "sa";
    private static final String PASS = "12345678"; // Change as needed
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
