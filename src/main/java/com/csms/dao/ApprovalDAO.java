package com.csms.dao;
import com.csms.entity.Approval;
import com.csms.util.DBUtil;
import java.sql.*;
import java.util.*;

public class ApprovalDAO {
    public List<Approval> getAllApprovals() {
        List<Approval> list = new ArrayList<>();
        String sql = "SELECT * FROM approvals ORDER BY create_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Approval a = new Approval();
                a.setId(rs.getInt("id"));
                a.setTitle(rs.getString("title"));
                a.setType(rs.getString("type"));
                a.setContent(rs.getString("content"));
                a.setStatus(rs.getString("status"));
                a.setCreateTime(rs.getTimestamp("create_time"));
                list.add(a);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}