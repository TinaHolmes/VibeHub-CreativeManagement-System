package com.csms.servlet;

import com.csms.dao.EquipmentDAO;
import com.csms.entity.Equipment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/equipments")
public class EquipmentServlet extends HttpServlet {
    private EquipmentDAO equipmentDAO = new EquipmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 1. 设置编码
        request.setCharacterEncoding("UTF-8");
        // 2. 调用 DAO 获取数据
        List<Equipment> equipList = equipmentDAO.getAllEquipments();
        // 3. 将数据放入 request 作用域
        request.setAttribute("equipList", equipList);
        // 4. 跳转到 JSP 页面
        request.getRequestDispatcher("equipment_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}