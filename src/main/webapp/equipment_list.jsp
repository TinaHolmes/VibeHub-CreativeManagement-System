<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.csms.entity.Equipment, com.csms.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>器材调度 | VIBE HUB</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --apple-blue: #0071e3;
            --apple-bg: #f5f5f7;
            --apple-card: #fffff;
            --text-main: #1d1d1f;
            --text-sec: #86868b;
            --status-in: #28a745;   /* 在库-绿 */
            --status-out: #ff9f0a;  /* 借出-橙 */
            --status-fix: #ff3b30;  /* 维护-红 */
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            background-color: var(--apple-bg);
            margin: 0; padding-top: 80px;
            display: flex; flex-direction: column; align-items: center;
        }

        /* 顶部黑色 Apple 导航栏 */
        .vibe-nav {
            position: fixed; top: 0; left: 0; width: 100%; height: 50px;
            background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(20px);
            z-index: 1000; display: flex; justify-content: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .nav-content { width: 90%; max-width: 1100px; display: flex; justify-content: space-between; align-items: center; }
        .nav-logo { color: #fff; font-weight: 700; font-size: 18px; text-decoration: none; }
        .nav-menu { display: flex; gap: 30px; }
        .nav-menu a { color: #ccc; text-decoration: none; font-size: 15px; transition: 0.3s; }
        .nav-menu a:hover { color: #fff; }

        /* 主容器 */
        .container {
            width: 90%; max-width: 1000px;
            background: var(--apple-card); padding: 50px;
            border-radius: 24px; box-shadow: 0 10px 40px rgba(0,0,0,0.05);
        }

        .header-section {
            display: flex; justify-content: space-between; align-items: flex-end;
            margin-bottom: 40px; border-bottom: 1px solid #f2f2f7; padding-bottom: 20px;
        }
        h2 { font-size: 42px; font-weight: 700; margin: 0; letter-spacing: -2px; }

        /* 表格样式 */
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; font-size: 11px; text-transform: uppercase; color: var(--text-sec); padding: 20px 15px; border-bottom: 1px solid #d2d2d7; }
        td { padding: 25px 15px; font-size: 15px; border-bottom: 1px solid #f2f2f7; }
        
        .id-badge { background: #000; color: #fff; padding: 4px 10px; border-radius: 6px; font-family: monospace; }
        
        /* 状态圆点标签 */
        .status-dot {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 5px 12px; border-radius: 20px; font-size: 13px; font-weight: 500;
        }
        .in-stock { background: rgba(40, 167, 69, 0.1); color: var(--status-in); }
        .out-stock { background: rgba(255, 159, 10, 0.1); color: var(--status-out); }
        .fixing { background: rgba(255, 59, 48, 0.1); color: var(--status-fix); }

        /* 借用按钮 */
        .btn-action {
            background: var(--apple-blue); color: #fff;
            padding: 8px 18px; border-radius: 10px; text-decoration: none;
            font-size: 13px; font-weight: 500; transition: 0.2s;
        }
        .btn-action:hover { background: #0077ed; transform: scale(1.05); }
    </style>
</head>
<body>

    <nav class="vibe-nav">
        <div class="nav-content">
            <a href="#" class="nav-logo">Holmes VIBE HUB</a>
            <div class="nav-menu">
                <a href="query">创意人才</a>
            	<a href="spaces">创意空间</a>
            	<a href="equipments">器材调度</a>
            	<a href="approvals">流程审批</a>
            	<a href="community">内部社群</a>
                <a href="logout" style="color:#ff3b30">退出</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="header-section">
            <div>
                <h2>器材调度中心</h2>
                <p style="color:var(--text-sec); margin-top:5px;">VIBE 全球影像资产实时清单</p>
            </div>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>资产编号</th>
                    <th>器材名称</th>
                    <th>型号/类别</th>
                    <th>当前状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Equipment> list = (List<Equipment>) request.getAttribute("equipList");
                    if (list != null && !list.isEmpty()) {
                        for (Equipment e : list) {
                            String statusClass = "";
                            if("在库".equals(e.getStatus())) statusClass = "in-stock";
                            else if("借出".equals(e.getStatus())) statusClass = "out-stock";
                            else statusClass = "fixing";
                %>
                <tr>
                    <td><span class="id-badge">EQ-<%= e.getId() %></span></td>
                    <td style="font-weight:700;"><%= e.getName() %></td>
                    <td><%= e.getModel() %></td>
                    <td>
                        <span class="status-dot <%= statusClass %>">
                            <i class="fa-solid fa-circle" style="font-size: 8px;"></i> <%= e.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <% if("在库".equals(e.getStatus())) { %>
                            <a href="#" class="btn-action">申请领用</a>
                        <% } else { %>
                            <span style="color:#ccc; font-size:13px;">暂不可用</span>
                        <% } %>
                    </td>
                </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>