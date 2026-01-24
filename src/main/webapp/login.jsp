<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>VIBE HUB | 内部员工门户</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --apple-blue: #0071e3;
            --apple-blue-hover: #0077ed;
            --text-main: #1d1d1f;
            --text-sec: #86868b;
            --apple-bg: #f5f5f7;
            --vibe-black: #003f34;
        }

        html { scroll-behavior: smooth; }

        body {
            margin: 0; padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            background-color: #fff;
            color: var(--text-main);
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }

        .section-hero {
            height: 100vh;
            width: 100%;
            display: flex;
            position: relative;
            background: #000;
        }

        .image-side {
            flex: 1.2;
            background-image: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.3)), 
                              url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1920');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 110px;
            color: white;
            animation: fadeIn 1.2s ease;
        }

        .image-side .badge {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            width: fit-content;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .image-side h1 { font-size: 56px; margin: 0; font-weight: 700; letter-spacing: -2px; }
        .image-side p { font-size: 20px; opacity: 0.8; margin-top: 15px; font-weight: 300; max-width: 500px; }

        .form-side {
            flex: 0.8;
            background: #ffe;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .login-card { width: 100%; max-width: 360px; }
        .login-card h2 { font-size: 32px; font-weight: 600; margin-bottom: 8px; }
        .login-card .subtitle { color: var(--text-sec); margin-bottom: 32px; font-size: 15px; }

        .input-group { margin-bottom: 16px; }
        input {
            width: 100%; padding: 18px; 
            border: 1px solid #d2d2d7; border-radius: 12px;
            font-size: 16px; background: #f5f5f7; box-sizing: border-box;
            outline: none; transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        input:focus { border-color: var(--apple-blue); background: #fff; box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1); }

        .login-btn {
            width: 100%; padding: 18px; background: var(--vibe-black);
            color: white; border: none; border-radius: 12px;
            font-size: 17px; font-weight: 500; cursor: pointer; transition: 0.3s;
        }
        .login-btn:hover { background: #000; transform: scale(1.01); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }

        .register-link {
            text-align: center; 
            margin-top: 24px; 
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .register-link a {
            color: var(--apple-blue);
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: 0.3s;
        }

        .register-link a:hover {
            color: var(--apple-blue-hover);
        }

        .scroll-indicator {
            position: absolute; bottom: 30px; left: 50%; transform: translateX(-50%);
            color: white; cursor: pointer; text-align: center; animation: bounce 2s infinite; z-index: 10;
        }

        .section-features {
            padding: 120px 20px;
            background-color: var(--apple-bg);
            text-align: center;
        }

        .features-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 40px; max-width: 1100px; margin: 0 auto;
        }

        .feature-card {
            background: white; padding: 60px 40px; border-radius: 30px;
            transition: 0.4s cubic-bezier(0.2, 0.8, 0.2, 1);
            text-align: left;
        }
        .feature-card:hover { transform: translateY(-12px); box-shadow: 0 20px 40px rgba(0,0,0,0.05); }

        .feature-icon { font-size: 40px; color: var(--apple-blue); margin-bottom: 25px; }
        .feature-card h3 { font-size: 22px; margin-bottom: 15px; font-weight: 600; }
        .feature-card p { color: var(--text-sec); line-height: 1.6; font-size: 15px; margin: 0; }

        .section-about {
            padding: 140px 20px;
            background-color: faf0e6;
            display: flex;
            justify-content: center;
        }

        .about-content {
            max-width: 800px;
            text-align: left;
        }

        .about-content h2 { font-size: 48px; font-weight: 700; letter-spacing: -1.5px; margin-bottom: 40px; line-height: 1.1; }
        .about-content p { 
            font-size: 22px; line-height: 1.6; color: var(--text-sec); 
            margin-bottom: 30px;
        }

        .highlight-blue { color: var(--apple-blue); font-weight: 600; }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {transform: translateY(0) translateX(-50%);}
            40% {transform: translateY(-10px) translateX(-50%);}
        }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>

    <section class="section-hero">
        <div class="image-side">
            <div class="badge">Internal Use Only</div>
            <h1>VIBE HUB</h1>
            <p>连接每一位创作者，整合全球影像资源。这是你的数字化协作空间。</p>
        </div>

        <div class="form-side">
            <div class="login-card">
                <h2>员工登录</h2>
                <div class="subtitle">请输入企业邮箱账号或员工 ID 登录</div>

                <form action="login" method="post">
                    <div class="input-group">
                        <input type="text" name="username" placeholder="员工账号" required>
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" placeholder="密码" required>
                    </div>
                    <button type="submit" class="login-btn">进入空间</button>
                </form>

                <div class="register-link">
                    <span style="color: var(--text-sec); font-size: 14px;">还没有账号？</span>
                    <a href="register.jsp">立即注册</a>
                </div>

                <div style="margin-top: 20px; font-size: 13px; color: #999; text-align: center;">
                    登录遇到问题？联系 IT 支持：<a href="#" style="color: var(--apple-blue); text-decoration: none;">it-support@vibe.com</a>
                </div>
            </div>
        </div>

        <div class="scroll-indicator" onclick="document.getElementById('features').scrollIntoView()">
            <i class="fa-solid fa-chevron-down"></i>
            <span>了解 HUB 功能</span>
        </div>
    </section>

    <section class="section-features" id="features">
        <h2 style="font-size: 40px; margin-bottom: 80px; font-weight: 700;">一切，为了创作效率</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-file-signature"></i></div>
                <h3>智慧审批</h3>
                <p>无论是在外拍现场还是在公司,通过 HUB 一键提交报销、请假或器材采购申请,流程节点实时同步。</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-clock"></i></div>
                <h3>灵活考勤</h3>
                <p>专为摄影师设计的弹性考勤系统。支持外勤定位打卡与项目工时录入,让工作时长清晰透明。</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-database"></i></div>
                <h3>影像资产库</h3>
                <p>集成公司内部 RAW 样片库、后期调色手册及拍摄规范,随时调取全球顶尖摄影平台的培训资源。</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-users-gear"></i></div>
                <h3>部门协作</h3>
                <p>打破部门壁垒。后期团队与拍摄组无缝对接项目进度,快速分配任务,共享创作灵感。</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-id-card"></i></div>
                <h3>员工自助</h3>
                <p>实时查询个人薪酬明细、保险福利与职业晋升路径,打造全透明的企业内部服务中心。</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-user-shield"></i></div>
                <h3>数据主权</h3>
                <p>基于权限管理体系,严格保障企业敏感资料与员工隐私安全,每一笔数据操作均可溯源。</p>
            </div>
        </div>
    </section>

    <section class="section-about">
        <div class="about-content">
            <h2>VIBE HUB 是什么？</h2>
            <p>
                它是我们公司的 <span class="highlight-blue">数字化灵魂</span>。在 VIBE,我们坚信技术是为了解放创意而存在的。
            </p>
            <p>
                我们打造这个内网门户,是为了让每一位年轻人不再被繁琐的审批和杂乱的信息所困扰。从 <span class="highlight-blue">项目立项</span> 到 <span class="highlight-blue">作品发布</span>,VIBE HUB 覆盖了摄影平台工作的每一个环节。
            </p>
            <p>
                通过 HUB,我们实现了资源的最大化整合,让身处不同城市的摄影师能够像在同一个房间一样协同工作。这不只是一个管理工具,更是我们的 <span class="highlight-blue">协作引擎</span>。
            </p>
        </div>
    </section>

    <footer style="padding: 80px 20px; text-align: center; background: #f5f5f7; color: #86868b; font-size: 13px; border-top: 1px solid #d2d2d7;">
        <p>© 2026 Holmes VIBE VISIONARY CORP. | 内部办公门户 | 隐私政策</p>
        <p style="margin-top: 10px; color: #bbb;">版本号: v2.4.0-Stable</p>
    </footer>

</body>
</html>