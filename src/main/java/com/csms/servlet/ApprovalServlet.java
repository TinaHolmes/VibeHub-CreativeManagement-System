package com.csms.servlet;
import com.csms.dao.ApprovalDAO;
import com.csms.entity.Approval;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/approvals")
public class ApprovalServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Approval> list = new ApprovalDAO().getAllApprovals();
        request.setAttribute("approvalList", list);
        request.getRequestDispatcher("approval_list.jsp").forward(request, response);
    }
}