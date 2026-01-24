package com.csms.servlet;

import com.csms.dao.StaffDAO;
import com.csms.entity.Staff;
import com.csms.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/query")
public class QueryServlet extends HttpServlet {
    
    private StaffDAO staffDAO = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 设置编码，防止中文乱码
        req.setCharacterEncoding("UTF-8");
        
        // 2. 权限校验：检查 Session 中是否有用户信息
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            // 未登录则跳转回登录页
            resp.sendRedirect("login.jsp?error=please_login");
            return;
        }

        // 3. 获取前端查询参数
        String keyword = req.getParameter("keyword");
        
        // 4. 调用 Service/DAO 层获取数据
        List<Staff> staffList = staffDAO.queryStaff(keyword);
        
        // 5. 将结果存入 Request 域，转发给 JSP 展示
        req.setAttribute("staffList", staffList);
        req.setAttribute("searchKeyword", keyword); // 回显查询关键词
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}