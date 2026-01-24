package com.csms.dao;
import com.csms.entity.Post;
import com.csms.util.DBUtil;
import java.sql.*;
import java.util.*;

public class PostDAO {
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM community_posts ORDER BY publish_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Post p = new Post();
                p.setId(rs.getInt("id"));
                p.setAuthor(rs.getString("author"));
                p.setTitle(rs.getString("title"));
                p.setContent(rs.getString("content"));
                p.setLikes(rs.getInt("likes"));
                p.setPublishTime(rs.getTimestamp("publish_time"));
                list.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}