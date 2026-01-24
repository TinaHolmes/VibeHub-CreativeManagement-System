package com.csms.servlet;

import com.csms.dao.SpaceDAO;
import com.csms.entity.Space;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// 这里的 "/spaces" 必须和导航栏 href="spaces" 完全对应
@WebServlet("/spaces")
public class SpaceServlet extends HttpServlet {
    
    private SpaceDAO spaceDAO = new SpaceDAO();

    // 点击导航栏链接触发的是 GET 请求
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 调用下面的 doPost 逻辑，统一处理
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 设置编码
        request.setCharacterEncoding("UTF-8");
        
        // 2. 从 DAO 获取数据库里 spaces 表的所有数据
        List<Space> spaceList = spaceDAO.getAllSpaces();
        
        // 3. 将数据存入 request 作用域
        request.setAttribute("spaceList", spaceList);
        
        // 4. 转发到具体的展示页面
        // 请确保 webapp 目录下确实有一个叫 space_list.jsp 的文件
        request.getRequestDispatcher("space_list.jsp").forward(request, response);
    }
}