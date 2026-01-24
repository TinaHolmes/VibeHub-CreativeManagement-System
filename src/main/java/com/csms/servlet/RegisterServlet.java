package com.csms.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.csms.util.DBUtil; // 确保导入了你的工具类

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    request.setCharacterEncoding("UTF-8");
	    
	    // 1. 获取参数
	    String uid = request.getParameter("uid");
	    String verifyCode = request.getParameter("verifyCode");
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String confirmPassword = request.getParameter("confirmPassword");
	    
	    // 基础校验
	    if (uid == null || verifyCode == null || !password.equals(confirmPassword)) {
	        response.sendRedirect("register.jsp?error=password");
	        return;
	    }

	    // 2. 业务逻辑处理
	    try (Connection conn = com.csms.util.DBUtil.getConnection()) {
	        
	        // 步骤 A: 校验白名单和验证码
	        String sqlCheck = "SELECT * FROM employee_whitelist WHERE uid = ? AND verify_code = ?";
	        PreparedStatement ps1 = conn.prepareStatement(sqlCheck);
	        ps1.setString(1, uid);
	        ps1.setString(2, verifyCode);
	        ResultSet rs = ps1.executeQuery();
	        
	        if (!rs.next()) {
	            response.sendRedirect("register.jsp?error=uid"); // 验证码或工号错
	            return;
	        }
	        
	        if (rs.getInt("is_registered") == 1) {
	            response.sendRedirect("register.jsp?error=uid"); // 已经注册过了
	            return;
	        }

	        // 提取白名单中的员工信息
	        String realName = rs.getString("name");
	        String dept = rs.getString("department");
	        String pos = rs.getString("position");
	        String phone = rs.getString("phone");

	        // 步骤 B: 检查用户名是否重复
	        String sqlUserExist = "SELECT id FROM users WHERE username = ?";
	        PreparedStatement ps2 = conn.prepareStatement(sqlUserExist);
	        ps2.setString(1, username);
	        if (ps2.executeQuery().next()) {
	            response.sendRedirect("register.jsp?error=exists");
	            return;
	        }

	        // 步骤 C: 插入新用户 (【注意】这里去掉了加密，存入明文 password)
	        // 请确保你的 users 表有这 7 个字段！
	        String sqlInsert = "INSERT INTO users (uid, username, password, name, department, position, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
	        PreparedStatement ps3 = conn.prepareStatement(sqlInsert);
	        ps3.setString(1, uid);
	        ps3.setString(2, username);
	        ps3.setString(3, password); // 直接存储明文
	        ps3.setString(4, realName);
	        ps3.setString(5, dept);
	        ps3.setString(6, pos);
	        ps3.setString(7, phone);
	        ps3.executeUpdate();

	        // 步骤 D: 更新白名单状态为已注册
	        String sqlUpdate = "UPDATE employee_whitelist SET is_registered = 1 WHERE uid = ?";
	        PreparedStatement ps4 = conn.prepareStatement(sqlUpdate);
	        ps4.setString(1, uid);
	        ps4.executeUpdate();

	        // 成功跳转
	        response.sendRedirect("login.jsp?register=success");

	    } catch (Exception e) {
	        e.printStackTrace(); // 报错了去控制台看红色文字！
	        response.sendRedirect("register.jsp?error=system");
	    }
	}
}
//        // 1. 基础验证
//        if (uid == null || verifyCode == null || username == null || password == null) {
//            response.sendRedirect("register.jsp?error=param");
//            return;
//        }
//        
//        // 2. 密码一致性检查
//        if (!password.equals(confirmPassword)) {
//            response.sendRedirect("register.jsp?error=password");
//            return;
//        }
//
//        // 使用 try-with-resources 自动关闭资源，防止数据库连接被占满
//        try (Connection conn = DBUtil.getConnection()) {
//            
//            // 3. 验证工号和验证码 (查询 employee_whitelist 表)
//            String checkSql = "SELECT * FROM employee_whitelist WHERE uid = ? AND verify_code = ?";
//            PreparedStatement pstmt = conn.prepareStatement(checkSql);
//            pstmt.setString(1, uid);
//            pstmt.setString(2, verifyCode);
//            ResultSet rs = pstmt.executeQuery();
//            
//            if (!rs.next()) {
//                response.sendRedirect("register.jsp?error=uid"); // 工号或码错
//                return;
//            }
//            
//            if (rs.getInt("is_registered") == 1) {
//                response.sendRedirect("register.jsp?error=uid"); // 已注册过
//                return;
//            }
//            
//            // 获取白名单里的员工详情，用于存入 users 表
//            String realName = rs.getString("name");
//            String dept = rs.getString("department");
//            String pos = rs.getString("position");
//            String phone = rs.getString("phone");
//            
//            // 4. 检查用户名是否被占用
//            String userCheckSql = "SELECT id FROM users WHERE username = ?";
//            PreparedStatement pstmt2 = conn.prepareStatement(userCheckSql);
//            pstmt2.setString(1, username);
//            if (pstmt2.executeQuery().next()) {
//                response.sendRedirect("register.jsp?error=exists");
//                return;
//            }
//            
//            // 5. 插入新用户 (注意：这里直接存 password 明文)
//            String insertSql = "INSERT INTO users (uid, username, password, name, department, position, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
//            PreparedStatement pstmt3 = conn.prepareStatement(insertSql);
//            pstmt3.setString(1, uid);
//            pstmt3.setString(2, username);
//            pstmt3.setString(3, password); // 直接存明文
//            pstmt3.setString(4, realName);
//            pstmt3.setString(5, dept);
//            pstmt3.setString(6, pos);
//            pstmt3.setString(7, phone);
//            
//            int rows = pstmt3.executeUpdate();
//            
//            // 6. 更新白名单注册状态
//            if (rows > 0) {
//                PreparedStatement pstmt4 = conn.prepareStatement("UPDATE employee_whitelist SET is_registered = 1 WHERE uid = ?");
//                pstmt4.setString(1, uid);
//                pstmt4.executeUpdate();
//                
//                response.sendRedirect("login.jsp?register=success");
//            } else {
//                response.sendRedirect("register.jsp?error=fail");
//            }
//            
//        } catch (Exception e) {
//            e.printStackTrace(); // 必须在控制台查看这个报错！
//            response.sendRedirect("register.jsp?error=system");
//        }
//    }
//}