<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.csms.entity.Approval" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>流程审批 | VIBE HUB</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { 
            --vibe-black: #000; 
            --apple-bg: #f5f5f7; 
            --apple-blue: #0071e3; 
            --apple-green: #34c759;
            --apple-red: #ff3b30;
            --apple-orange: #ff9500;
        }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif; 
            background: var(--apple-bg); 
            margin:0; 
            padding-top:80px; 
            display:flex; 
            justify-content:center;
            -webkit-font-smoothing: antialiased;
        }

        /* 导航栏 */
        .vibe-nav { 
            position: fixed; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 50px; 
            background: rgba(0,0,0,0.85); 
            backdrop-filter: blur(20px); 
            z-index: 2000; /* 提高导航栏层级 */ 
            display: flex; 
            justify-content: center; 
            border-bottom: 1px solid rgba(255,255,255,0.1); 
        }
        .nav-content { 
            width: 90%; 
            max-width: 1100px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }
        .nav-logo { 
            color: #fff; 
            font-weight: 700; 
            text-decoration: none; 
            font-size: 18px;
            letter-spacing: 1px;
        }
        .nav-menu a { 
            color: #ccc; 
            text-decoration: none; 
            font-size: 14px; 
            margin-left: 25px; 
            transition: 0.3s;
        }
        .nav-menu a:hover { color: #fff; }

        .container { 
            width: 90%; 
            max-width: 1200px; 
            background: #fff; 
            padding: 50px; 
            border-radius: 24px; 
            box-shadow: 0 10px 40px rgba(0,0,0,0.05); 
            margin-bottom: 50px;
        }

        /* 头部统计区 */
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .header-section h2 { 
            font-size: 42px; 
            font-weight: 700; 
            letter-spacing: -2px; 
            margin: 0;
        }
        
        .stats-group {
            display: flex;
            gap: 20px;
        }
        .stat-card {
            /* 默认背景 */
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 25px;
            border-radius: 16px;
            color: #fff;
            text-align: center;
            min-width: 100px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        /* 修改后的颜色：待审批 (Apple Orange Style) */
        .stat-card.pending { 
            background: linear-gradient(135deg, #FF9F0A 0%, #FFB340 100%); 
        }
        
        /* 修改后的颜色：已通过 (Apple Green/Teal Style) */
        .stat-card.approved { 
            background: linear-gradient(135deg, #30D158 0%, #63E6BE 100%); 
        }

        .stat-number { font-size: 28px; font-weight: 700; }
        .stat-label { font-size: 12px; opacity: 0.95; margin-top: 5px; font-weight: 500; }

        /* 筛选按钮组 */
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: 15px;
        }
        .filter-tab {
            padding: 8px 20px;
            border-radius: 20px;
            background: transparent;
            border: 1px solid #d2d2d7;
            color: #86868b;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
        }
        .filter-tab:hover { background: #f5f5f7; }
        .filter-tab.active { 
            background: var(--vibe-black); 
            color: #fff; 
            border-color: var(--vibe-black);
        }

        /* 审批表格 */
        table { 
            width: 100%; 
            border-collapse: separate; /* 改为 separate 以支持 tr 的 transform */
            border-spacing: 0;
            margin-top: 20px; 
        }
        th { 
            text-align: left; 
            color: #86868b; 
            font-size: 13px; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            padding: 15px; 
            border-bottom: 2px solid #d2d2d7; 
            font-weight: 600;
        }
        td { 
            padding: 25px 15px; 
            border-bottom: 1px solid #f2f2f7; 
            font-size: 14px; 
            /* 移除 td 的 relative，让 tr 控制层级 */
        }

        /* 审批行悬浮效果 & 修复遮挡问题 */
        tbody tr {
            transition: all 0.2s ease;
            cursor: pointer;
            position: relative; /* 关键：设置为相对定位 */
            z-index: 1; /* 默认层级 */
            background: #fff; /* 确保背景不透明 */
        }
        
        tbody tr:hover {
            background: #f9f9f9;
            transform: scale(1.01); /* 轻微放大 */
            box-shadow: 0 4px 20px rgba(0,0,0,0.08); /* 添加阴影 */
            z-index: 100; /* 关键：悬浮时提高层级，压过下面的一行 */
            border-radius: 12px;
        }

        /* 状态徽章 */
        .status-badge { 
            padding: 6px 16px; 
            border-radius: 20px; 
            font-size: 13px; 
            font-weight: 600; 
            display: inline-block;
        }
        .pending { background: #fff7e6; color: #fa8c16; }
        .approved { background: #f6ffed; color: #52c41a; }
        .rejected { background: #fff1f0; color: #ff4d4f; }

        /* 类型图标 */
        .type-icon {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--apple-blue);
            font-weight: 600;
        }

        /* 操作按钮组 */
        .action-buttons {
            display: flex;
            gap: 8px;
            opacity: 0;
            transition: 0.3s;
        }
        tr:hover .action-buttons { opacity: 1; }
        
        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .approve-btn {
            background: var(--apple-green);
            color: #fff;
        }
        .approve-btn:hover {
            background: #28a745;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 199, 89, 0.3);
        }
        .reject-btn {
            background: var(--apple-red);
            color: #fff;
        }
        .reject-btn:hover {
            background: #dc3545;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 59, 48, 0.3);
        }
        .detail-btn {
            background: var(--apple-blue);
            color: #fff;
        }
        .detail-btn:hover {
            background: #005bb5;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 113, 227, 0.3);
        }

        /* 详细信息悬浮卡片 */
        .detail-popup {
            display: none;
            position: absolute;
            left: 50%;
            top: 80%; /* 稍微向上提一点 */
            transform: translateX(-50%);
            width: 400px;
            background: #fff;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2); /* 加深阴影 */
            z-index: 999; /* 确保非常高 */
            margin-top: 10px;
            animation: slideUp 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
        }
        tr:hover .detail-popup { display: block; }
        
        @keyframes slideUp {
            from { opacity: 0; transform: translateX(-50%) translateY(10px); }
            to { opacity: 1; transform: translateX(-50%) translateY(0); }
        }

        .detail-popup::before {
            content: '';
            position: absolute;
            top: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 8px solid transparent;
            border-right: 8px solid transparent;
            border-bottom: 8px solid #fff;
        }

        .detail-row {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        .detail-row:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
        .detail-label {
            font-size: 13px;
            color: #86868b;
            width: 100px;
            font-weight: 500;
        }
        .detail-value {
            font-size: 14px;
            color: #1d1d1f;
            flex: 1;
            font-weight: 400;
            text-align: left;
        }

        /* 紧急标签 */
        .urgent-tag {
            background: linear-gradient(135deg, #ff6b6b, #ee5a6f);
            color: #fff;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            margin-left: 10px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        /* 查看全部按钮区域 */
        .show-more-container {
            margin-top: 30px;
            text-align: center;
            border-top: 1px solid #f0f0f0;
            padding-top: 20px;
        }
        .btn-show-all {
            background: #f5f5f7;
            color: #666;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-show-all:hover {
            background: var(--vibe-black);
            color: #fff;
            transform: translateY(-2px);
        }

    </style>
</head>
<body>
    <nav class="vibe-nav">
        <div class="nav-content">
            <a href="query" class="nav-logo">🎨 VIBE HUB</a>
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
            <h2>流程审批中心</h2>
            <div class="stats-group">
                <div class="stat-card pending">
                    <div class="stat-number">8</div>
                    <div class="stat-label">待审批</div>
                </div>
                <div class="stat-card approved">
                    <div class="stat-number">24</div>
                    <div class="stat-label">已通过</div>
                </div>
            </div>
        </div>

        <div class="filter-tabs">
            <button class="filter-tab active" data-filter="all">全部</button>
            <button class="filter-tab" data-filter="待审批">待审批</button>
            <button class="filter-tab" data-filter="已通过">已通过</button>
            <button class="filter-tab" data-filter="已驳回">已驳回</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>类型</th>
                    <th>标题</th>
                    <th>提交时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Approval> list = (List<Approval>) request.getAttribute("approvalList");
                    if (list != null && !list.isEmpty()) {
                        for (Approval a : list) {
                            String applicant = "创意部-张三";
                            String reason = "项目需要，请尽快审批";
                            String budget = "¥5,000";
                            boolean isUrgent = Math.random() > 0.7; 
                %>
                <tr class="approval-row" data-status="<%= a.getStatus() %>">
                    <td>
                        <span class="type-icon">
                            <i class="fa-solid fa-<%= 
                                a.getType().contains("请假") ? "calendar-days" : 
                                a.getType().contains("报销") ? "receipt" : 
                                a.getType().contains("采购") ? "cart-shopping" : 
                                a.getType().contains("加班") ? "clock" : "file-lines" 
                            %>"></i>
                            <%= a.getType() %>
                        </span>
                        <% if (isUrgent && "待审批".equals(a.getStatus())) { %>
                            <span class="urgent-tag">紧急</span>
                        <% } %>
                    </td>
                    <td>
                        <strong><%= a.getTitle() %></strong>
                        <div class="detail-popup">
                            <div class="detail-row">
                                <span class="detail-label">申请编号：</span>
                                <span class="detail-value">#<%= a.getId() %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">申请类型：</span>
                                <span class="detail-value"><%= a.getType() %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">申请标题：</span>
                                <span class="detail-value"><%= a.getTitle() %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">申请人：</span>
                                <span class="detail-value"><%= applicant %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">申请原因：</span>
                                <span class="detail-value"><%= reason %></span>
                            </div>
                            <% if (a.getType().contains("报销") || a.getType().contains("采购")) { %>
                            <div class="detail-row">
                                <span class="detail-label">预算金额：</span>
                                <span class="detail-value"><%= budget %></span>
                            </div>
                            <% } %>
                            <div class="detail-row">
                                <span class="detail-label">提交时间：</span>
                                <span class="detail-value"><%= a.getCreateTime() %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">当前状态：</span>
                                <span class="detail-value">
                                    <span class="status-badge <%= 
                                        "已通过".equals(a.getStatus()) ? "approved" : 
                                        "已驳回".equals(a.getStatus()) ? "rejected" : "pending" 
                                    %>">
                                        <%= a.getStatus() %>
                                    </span>
                                </span>
                            </div>
                        </div>
                    </td>
                    <td><%= a.getCreateTime() %></td>
                    <td>
                        <span class="status-badge <%= 
                            "已通过".equals(a.getStatus()) ? "approved" : 
                            "已驳回".equals(a.getStatus()) ? "rejected" : "pending" 
                        %>">
                            <%= a.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <% if ("待审批".equals(a.getStatus())) { %>
                                <button class="action-btn approve-btn" onclick="handleApprove(<%= a.getId() %>, 'approve')">
                                    <i class="fa-solid fa-check"></i> 通过
                                </button>
                                <button class="action-btn reject-btn" onclick="handleApprove(<%= a.getId() %>, 'reject')">
                                    <i class="fa-solid fa-xmark"></i> 驳回
                                </button>
                            <% } %>
                            <button class="action-btn detail-btn" onclick="viewDetail(<%= a.getId() %>)">
                                <i class="fa-solid fa-eye"></i> 详情
                            </button>
                        </div>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" style="text-align: center; color: #86868b; padding: 50px;">
                        <i class="fa-solid fa-inbox" style="font-size: 48px; margin-bottom: 15px; opacity: 0.3;"></i>
                        <div>暂无审批流程</div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="show-more-container">
            <button class="btn-show-all" onclick="alert('即将加载全部历史数据...')">查看全部历史记录</button>
        </div>
    </div>

    <script>
        // 审批操作
        function handleApprove(id, action) {
            const actionText = action === 'approve' ? '通过' : '驳回';
            if (confirm(`确定要${actionText}这个申请吗？`)) {
                window.location.href = 'approveAction?id=' + id + '&action=' + action;
            }
        }

        // 查看详情
        function viewDetail(id) {
            window.location.href = 'approvalDetail?id=' + id;
        }

        // 筛选功能 (已修复)
        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                // 1. 切换按钮激活状态
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                
                // 2. 获取筛选条件
                const filterValue = this.getAttribute('data-filter');
                const rows = document.querySelectorAll('.approval-row');

                // 3. 遍历表格行进行显示/隐藏
                rows.forEach(row => {
                    const status = row.getAttribute('data-status');
                    
                    if (filterValue === 'all' || status === filterValue) {
                        row.style.display = 'table-row'; // 显示
                        // 触发一个小动画让显示更自然
                        row.style.opacity = '0';
                        setTimeout(() => row.style.opacity = '1', 50);
                    } else {
                        row.style.display = 'none'; // 隐藏
                    }
                });
            });
        });
    </script>

</body>
</html>