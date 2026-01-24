package com.csms.servlet;

import com.csms.util.DBUtil;
import com.csms.entity.User;
import com.csms.entity.Staff;
import com.csms.dao.StaffDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password"); // 明文密码

        try (Connection conn = DBUtil.getConnection()) {

            // ❌ 不再加密
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password); // 直接用明文

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // 登录成功
                User userObj = new User();
                userObj.setId(rs.getInt("id"));
                userObj.setUsername(rs.getString("username"));
                userObj.setName(rs.getString("username"));

                HttpSession session = request.getSession();
                session.setAttribute("currentUser", userObj);

                // 查询员工数据
                StaffDAO staffDAO = new StaffDAO();
                List<Staff> staffList = staffDAO.searchStaff("");
                request.setAttribute("staffList", staffList);

                // forward 保留 request 数据
                request.getRequestDispatcher("index.jsp").forward(request, response);

            } else {
                // 用户名或密码错误
                response.sendRedirect("login.jsp?error=auth");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=system");
        }
    }
}
