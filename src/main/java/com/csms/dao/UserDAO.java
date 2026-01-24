package com.csms.dao;

import com.csms.entity.User;
import com.csms.util.DBUtil;
import java.sql.*;

public class UserDAO {
    
    public boolean register(User user) {
        // 修改了 SQL：现在包含 uid, username, password
        String sql = "INSERT INTO users(uid, username, password) VALUES(?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUid());      // 对应 uid
            pstmt.setString(2, user.getUsername()); // 对应 username
            pstmt.setString(3, user.getPassword()); // 对应 password
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}