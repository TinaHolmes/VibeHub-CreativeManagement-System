package com.csms.dao;
import com.csms.entity.Space;
import com.csms.util.DBUtil;
import java.sql.*;
import java.util.*;

public class SpaceDAO {
    public List<Space> getAllSpaces() {
        List<Space> list = new ArrayList<>();
        String sql = "SELECT * FROM spaces";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Space s = new Space();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setType(rs.getString("type"));
                s.setCapacity(rs.getInt("capacity"));
                s.setStatus(rs.getString("status"));
                list.add(s);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}