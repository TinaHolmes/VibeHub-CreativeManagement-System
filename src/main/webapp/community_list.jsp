<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.csms.entity.Post, com.csms.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>内部社群 | VIBE HUB</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --vibe-black: #1d1d1f;
            --apple-bg: #f5f5f7;
            --apple-card: #ffffff;
            --apple-blue: #0071e3;
            --text-main: #1d1d1f;
            --text-sec: #86868b;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            background-color: var(--apple-bg);
            margin: 0; padding-top: 60px;
            display: flex; flex-direction: column; align-items: center;
            -webkit-font-smoothing: antialiased;
        }

        /* --- 页面标题区 --- */
        .page-header {
            width: 90%; max-width: 700px; margin-bottom: 50px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .page-header h2 { font-size: 48px; font-weight: 700; margin: 0; letter-spacing: -2.5px; }

        /* --- 发帖按钮 --- */
        .post-btn {
            background: var(--vibe-black); color: #fff;
            padding: 12px 24px; border-radius: 30px;
            text-decoration: none; font-size: 14px; font-weight: 500;
            transition: 0.3s ease;
        }
        .post-btn:hover { background: var(--apple-blue); transform: scale(1.05); }

        /* --- 帖子卡片 --- */
        .post-card {
            width: 90%; max-width: 700px;
            background: var(--apple-card); padding: 40px;
            border-radius: 32px; margin-bottom: 40px;
            box-shadow: 0 4px 30px rgba(0,0,0,0.03);
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .post-card:hover { transform: translateY(-8px); box-shadow: 0 20px 50px rgba(0,0,0,0.08); }

        /* --- 极简风光头像 --- */
        .avatar-box {
            width: 50px; height: 50px;
            border-radius: 16px;
            overflow: hidden;
            margin-right: 18px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .avatar-img { width: 100%; height: 100%; object-fit: cover; }

        .author-info { display: flex; flex-direction: column; }
        .author-name { font-weight: 700; font-size: 18px; color: var(--text-main); }
        .post-tag { font-size: 11px; color: var(--apple-blue); font-weight: 600; letter-spacing: 1px; margin-top: 4px; }

        .post-title { font-size: 28px; font-weight: 700; margin: 25px 0 15px 0; letter-spacing: -1px; line-height: 1.2; }
        .post-content { font-size: 17px; color: #48484a; line-height: 1.8; margin-bottom: 20px; }

        /* --- 🎨 新增：帖子图片展示区 --- */
        .post-images {
            margin: 25px 0;
            display: grid;
            gap: 12px;
        }
        
        /* 单张图片 */
        .post-images.single-image {
            grid-template-columns: 1fr;
        }
        .post-images.single-image .post-img {
            height: 400px;
        }
        
        /* 两张图片 */
        .post-images.two-images {
            grid-template-columns: repeat(2, 1fr);
        }
        .post-images.two-images .post-img {
            height: 250px;
        }
        
        /* 三张或更多图片 */
        .post-images.multi-images {
            grid-template-columns: repeat(3, 1fr);
        }
        .post-images.multi-images .post-img {
            height: 180px;
        }
        
        .post-img {
            width: 100%;
            border-radius: 16px;
            object-fit: cover;
            cursor: pointer;
            transition: 0.3s ease;
            box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        }
        .post-img:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        /* --- 图片查看器 --- */
        .image-viewer {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            background: rgba(0,0,0,0.95);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        .image-viewer.active { display: flex; }
        
        .viewer-img {
            max-width: 90%;
            max-height: 90vh;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
        }
        
        .close-viewer {
            position: absolute;
            top: 30px; right: 30px;
            font-size: 32px;
            color: #fff;
            cursor: pointer;
            width: 50px; height: 50px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: 0.3s;
        }
        .close-viewer:hover {
            background: rgba(255,255,255,0.2);
            transform: rotate(90deg);
        }

        .post-footer { display: flex; gap: 35px; border-top: 1px solid #f2f2f7; padding-top: 25px; margin-top: 25px; }
        .footer-item { font-size: 14px; color: var(--text-sec); display: flex; align-items: center; gap: 10px; cursor: pointer; transition: 0.2s; }
        .footer-item:hover { color: var(--apple-blue); }

        /* --- 核心：返回主界面的悬浮按钮 --- */
        .floating-back {
            position: fixed; top: 40px; left: 40px;
            width: 50px; height: 50px; background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px); border-radius: 50%;
            display: flex; justify-content: center; align-items: center;
            color: var(--vibe-black); text-decoration: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: 0.3s; z-index: 1001;
        }
        .floating-back:hover { background: var(--vibe-black); color: #fff; transform: translateX(-5px); }

    </style>
</head>
<body>

    <!-- 🔙 左上角悬浮返回按钮 -->
    <a href="query" class="floating-back" title="返回主页">
        <i class="fa-solid fa-arrow-left"></i>
    </a>

    <div class="page-header">
        <h2>VIBE 社群</h2>
        <a href="#" class="post-btn">发布新灵感</a>
    </div>

    <%
        // 准备一些精选风光图片库
        String[] landscapeImages = {
            "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1200", // 山景
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200", // 海岸
            "https://images.unsplash.com/photo-1511497584788-876760111969?w=1200", // 森林
            "https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=1200", // 雪山
            "https://images.unsplash.com/photo-1495616811223-4d98c6e9c869?w=1200", // 日落
            "https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=1200", // 山脉
            "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=1200", // 自然
            "https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=1200"  // 湖泊
        };
    
        List<Post> posts = (List<Post>) request.getAttribute("postList");
        if (posts != null && !posts.isEmpty()) {
            for (int i = 0; i < posts.size(); i++) {
                Post p = posts.get(i);
                
                // 头像逻辑
                String avatar = p.getAvatarUrl();
                if (avatar == null || avatar.isEmpty()) {
                    avatar = "https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=100";
                }
                
                // 🎨 为每个帖子分配1-3张随机风光图
                int imageCount = (i % 3) + 1; // 1, 2, 或 3 张图片
                String imageClass = imageCount == 1 ? "single-image" : 
                                   imageCount == 2 ? "two-images" : "multi-images";
    %>
    <div class="post-card">
        <div style="display:flex; align-items:center;">
            <div class="avatar-box">
                <img src="<%= avatar %>" class="avatar-img" alt="landscape">
            </div>
            <div class="author-info">
                <span class="author-name"><%= p.getAuthor() %></span>
                <span class="post-tag">
                    <%= p.getTitle().contains("风光") ? "Nature & Landscape" : "Visual Arts" %>
                </span>
            </div>
        </div>
        
        <div class="post-title"><%= p.getTitle() %></div>
        <div class="post-content"><%= p.getContent() %></div>

        <!-- 🎨 图片展示区 -->
        <div class="post-images <%= imageClass %>">
            <%
                for (int j = 0; j < imageCount; j++) {
                    int imgIndex = (i * 3 + j) % landscapeImages.length;
            %>
            <img src="<%= landscapeImages[imgIndex] %>" 
                 class="post-img" 
                 alt="风光摄影"
                 onclick="openViewer(this.src)">
            <% } %>
        </div>

        <div class="post-footer">
            <div class="footer-item"><i class="fa-regular fa-heart"></i> <%= p.getLikes() %> 赞</div>
            <div class="footer-item"><i class="fa-regular fa-comment"></i> 交流</div>
            <div class="footer-item"><i class="fa-regular fa-share-from-square"></i></div>
        </div>
    </div>
    <% 
            }
        }
    %>

    <!-- 图片查看器 -->
    <div class="image-viewer" id="imageViewer" onclick="closeViewer()">
        <span class="close-viewer">&times;</span>
        <img src="" class="viewer-img" id="viewerImg" onclick="event.stopPropagation()">
    </div>

    <script>
        function openViewer(src) {
            document.getElementById('viewerImg').src = src;
            document.getElementById('imageViewer').classList.add('active');
            document.body.style.overflow = 'hidden';
        }
        
        function closeViewer() {
            document.getElementById('imageViewer').classList.remove('active');
            document.body.style.overflow = 'auto';
        }
        
        // ESC键关闭查看器
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') closeViewer();
        });
    </script>

</body>
</html>