<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.csms.entity.Staff" %>
<%@ page import="com.csms.entity.User" %>
<html>
<head>
    <title>VIBE HUB | 创意人才库</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* --- 1. 定义 VIBE HUB 核心配色 (与登录页完全一致) --- */
        :root {
            --vibe-black: #1b2621;
            --vibe-dark: #ff7e5f;
            --apple-blue: #0071e3;
            --glass-bg: rgba(255, 255, 255, 0.8);
            --text-main: #3a3a3c;
            --text-sec: #86868b;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            background-color: #354f52; /* 苹果灰背景 */
            margin: 0;
            padding-top: 80px;
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
        }

        /* --- 2. 导航栏：同步 VIBE 潮酷感 --- */
        .vibe-nav {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 50px;
            background: rgba(0, 0, 0, 0.85); /* 黑色半透明 */
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

        .nav-logo { color: #fff; font-weight: 700; font-size: 20px; letter-spacing: -2px; text-decoration: none; }
        .nav-menu { display: flex; gap: 30px; }
        .nav-menu a { color: #ccc; text-decoration: none; font-size: 15px; transition: 0.3s; }
        .nav-menu a:hover { color: #fff; }
        .logout-btn { color: #ff3b30 !important; font-weight: 600; }

        /* --- 3. 主容器：告别普通白卡片 --- */
        .container {
            width: 92%;
            max-width: 1050px;
            margin: 0 auto;
            background: #fff;
            padding: 50px;
            border-radius: 24px; /* 更大的圆角 */
            box-shadow: 0 20px 60px rgba(0,0,0,0.05);
            animation: slideUp 0.8s ease;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 40px;
            border-bottom: 1px solid #00000;
            padding-bottom: 20px;
        }

        h2 { font-size: 56px; font-weight: 800; margin: 0; letter-spacing: -1px; }
        .user-tag { font-size: 14px; color: var(--text-sec); }
        .user-tag span { color: var(--vibe-black); font-weight: 600; }

        /* --- 4. 搜索框：摄影平台风格 --- */
        .search-area {
            background: #f5f5f7;
            padding: 25px;
            border-radius: 18px;
            display: flex;
            gap: 15px;
            margin-bottom: 40px;
        }

        input[type="text"] {
            flex: 1;
            padding: 15px 20px;
            border: 1px solid #d2d2d7;
            border-radius: 12px;
            font-size: 16px;
            outline: none;
            transition: 0.3s;
        }

        input[type="text"]:focus {
            border-color: var(--vibe-black);
            box-shadow: 0 0 0 4px rgba(0,0,0,0.05);
        }

        .btn-vibe {
            background: var(--vibe-black);
            color: #fff;
            border: none;
            padding: 0 35px;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-vibe:hover { background: #333; transform: scale(1.02); }

        /* --- 5. 表格：高级画廊排版 --- */
        table { width: 100%; border-collapse: collapse; }
        
        th {
            text-align: left;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-sec);
            padding: 20px 10px;
            border-bottom: 1px solid var(--text-main);
        }

        td {
            padding: 25px 10px;
            font-size: 15px;
            border-bottom: 1px solid #f2f2f7;
            color: #333;
        }

        .id-badge {
            background: #000;
            color: #fff;
            padding: 4px 10px;
            border-radius: 6px;
            font-family: "SF Mono", monospace;
            font-size: 12px;
        }

        .dept-tag {
            background: rgba(0, 113, 227, 0.08);
            color: var(--apple-blue);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        tr:hover td { background-color: #ffe9f4; }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

    </style>
</head>
<body>

    <!-- 🍎 同步登录页风格的导航栏 -->
    <nav class="vibe-nav">
        <div class="nav-content">
            <a href="#" class="nav-logo">Holmes VIBE HUB</a>

<div class="nav-menu">
    <a href="query">创意人才</a>   <!-- 对应 QueryServlet -->
    <a href="spaces">创意空间</a>  <!-- 对应 SpaceServlet -->
    <a href="equipments">器材调度</a>
    <a href="approvals">流程审批</a>
    <a href="community">内部社群</a>
    <a href="logout" class="logout-btn">退出 HUB</a>
</div>
        </div>
    </nav>

    <!-- 📂 主内容 -->
    <div class="container">
        <div class="header-section">
            <div>
                <h2>创意人才库</h2>
                <p style="color:var(--text-sec); margin-top:5px;">VIBE 摄影平台内部人才管理系统</p>
            </div>
            <% 
                User user = (User)session.getAttribute("currentUser");
                if(user != null) {
            %>
                <div class="user-tag">
                    Authenticated: <span><%= user.getUsername() %></span>
                </div>
            <% } %>
        </div>
        
        <!-- 搜索区 -->
        <form action="query" method="post" class="search-area">
            <input type="text" name="keyword" placeholder="搜索摄影师姓名、创意部门..." 
                   value="${searchKeyword != null ? searchKeyword : ''}">
            <button type="submit" class="btn-vibe">检索</button>
        </form>

        <!-- 数据表 -->
        <table>
            <thead>
                <tr>
                    <th>UID</th>
                    <th>姓名</th>
                    <th>所属部门</th>
                    <th>职能岗位</th>
                    <th>联络方式</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Staff> list = (List<Staff>) request.getAttribute("staffList");
                    if (list != null && !list.isEmpty()) {
                        for (Staff s : list) {
                %>
                <tr>
                    <td><span class="id-badge">ID-<%= s.getId() %></span></td>
                    <td style="font-weight:700;"><%= s.getName() %></td>
                    <td><span class="dept-tag"><%= s.getDepartment() %></span></td>
                    <td><%= s.getPosition() %></td>
                    <td style="color:var(--text-sec);"><%= s.getPhone() %></td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="5" style="text-align:center; padding: 100px; color: var(--text-sec);">
                        🔍 库中暂无匹配项，尝试检索其他关键词
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>