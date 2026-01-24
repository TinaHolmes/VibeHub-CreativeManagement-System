<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.csms.entity.Space" %>
<%@ page import="com.csms.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>创意空间 | VIBE HUB</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* --- Apple 风格全局变量 --- */
        :root {
            --vibe-black: #000000;
            --apple-bg: #f5f5f7;
            --apple-card: #ffffff;
            --apple-blue: #0071e3;
            --text-main: #1d1d1f;
            --text-sec: #86868b;
            --border-color: #d2d2d7;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            background-color: var(--apple-bg);
            margin: 0;
            padding-top: 80px;
            display: flex;
            flex-direction: column;
            align-items: center;
            -webkit-font-smoothing: antialiased;
        }

        /* --- 顶部 Apple 导航栏 --- */
        .vibe-nav {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 50px;
            background: rgba(0, 0, 0, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            z-index: 1000;
            display: flex;
            justify-content: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .nav-content {
            width: 90%; max-width: 1100px;
            display: flex; justify-content: space-between; align-items: center;
        }

        .nav-logo { color: #fff; font-weight: 700; font-size: 18px; text-decoration: none; }
        .nav-menu { display: flex; gap: 30px; }
        .nav-menu a { color: #ccc; text-decoration: none; font-size: 15px; transition: 0.3s; }
        .nav-menu a:hover { color: #fff; }
        .logout-btn { color: #ff3b30 !important; font-weight: 600; }

        /* --- 主内容容器 --- */
        .container {
            width: 90%;
            max-width: 1000px;
            background: var(--apple-card);
            padding: 50px;
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.05);
            animation: slideUp 0.8s ease;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 40px;
            border-bottom: 1px solid #f2f2f7;
            padding-bottom: 20px;
        }

        h2 { font-size: 42px; font-weight: 700; margin: 0; letter-spacing: -2px; }
        .user-tag { font-size: 14px; color: var(--text-sec); }

        /* --- 表格样式 --- */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        
        th {
            text-align: left;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-sec);
            padding: 20px 15px;
            border-bottom: 1px solid var(--border-color);
        }

        td {
            padding: 25px 15px;
            font-size: 15px;
            border-bottom: 1px solid #f2f2f7;
            color: #333;
        }

        .id-badge {
            background: #000;
            color: #fff;
            padding: 4px 10px;
            border-radius: 6px;
            font-family: monospace;
            font-size: 12px;
        }

        .status-tag {
            background: rgba(0, 113, 227, 0.08);
            color: var(--apple-blue);
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        tr:hover td { background-color: #fafafa; }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <!-- 🍎 顶部导航 -->
    <nav class="vibe-nav">
        <div class="nav-content">
            <a href="#" class="nav-logo">Holmes VIBE HUB</a>
            <div class="nav-menu">
                <a href="query">创意人才</a>
                <a href="spaces">创意空间</a>
                <a href="equipments">器材调度</a>
                <a href="approvals">流程审批</a>
                <a href="community">内部社群</a>
                <a href="logout" class="logout-btn">退出 HUB</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="header-section">
            <div>
                <h2>创意空间管理</h2>
                <p style="color:var(--text-sec); margin-top:5px;">VIBE 摄影棚与协作室实时状态监控</p>
            </div>
            <% 
                User user = (User)session.getAttribute("currentUser");
                if(user != null) {
            %>
                <div class="user-tag">
                    Operator: <span><%= user.getUsername() %></span>
                </div>
            <% } %>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>编号</th>
                    <th>空间名称</th>
                    <th>功能类型</th>
                    <th>容纳人数</th>
                    <th>当前状态</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Space> spaceList = (List<Space>) request.getAttribute("spaceList");
                    if (spaceList != null && !spaceList.isEmpty()) {
                        for (Space s : spaceList) {
                %>
                <tr>
                    <td><span class="id-badge">ID-<%= s.getId() %></span></td>
                    <td style="font-weight:700;"><%= s.getName() %></td>
                    <td><%= s.getType() %></td>
                    <td><%= s.getCapacity() %> 人</td>
                    <td><span class="status-tag"><%= s.getStatus() %></span></td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="5" style="text-align:center; padding: 100px; color: var(--text-sec); font-style: italic;">
                        🔍 暂无空间数据，请检查数据库配置
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>