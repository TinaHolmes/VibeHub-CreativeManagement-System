package com.csms.util;
import java.sql.*;

public class DBUtil {
    
    private static final String URL = "jdbc:mysql://localhost:3306/company_db?useSSL=false&serverTimezone=UTC&characterEncoding=utf-8";
    private static final String USER = "root";
    private static final String PASSWORD = "123456"; // 确认是 123456 还是 root

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) { e.printStackTrace(); }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}