package com.csms.dao;

import com.csms.entity.Equipment;
import com.csms.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EquipmentDAO {
    // 获取所有器材列表
    public List<Equipment> getAllEquipments() {
        List<Equipment> list = new ArrayList<>();
        String sql = "SELECT * FROM equipments";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Equipment e = new Equipment();
                e.setId(rs.getInt("id"));
                e.setName(rs.getString("name"));
                e.setModel(rs.getString("model"));
                e.setStatus(rs.getString("status"));
                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}