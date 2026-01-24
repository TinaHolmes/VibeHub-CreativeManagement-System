package com.csms.servlet;
import com.csms.dao.PostDAO;
import com.csms.entity.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/community")
public class CommmunityServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Post> list = new PostDAO().getAllPosts();
        request.setAttribute("postList", list);
        request.getRequestDispatcher("community_list.jsp").forward(request, response);
    }
}