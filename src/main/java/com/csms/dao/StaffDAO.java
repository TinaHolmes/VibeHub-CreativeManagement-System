package com.csms.dao;

import com.csms.entity.Staff;
import com.csms.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    public List<Staff> queryStaff(String keyword) {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM staff WHERE name LIKE ? OR department LIKE ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + (keyword == null ? "" : keyword) + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Staff staff = new Staff(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("department"),
                    rs.getString("position"),
                    rs.getString("phone")
                );
                list.add(staff);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ 补全方法
    public List<Staff> searchStaff(String keyword) {
        return queryStaff(keyword);
    }
}
