<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工注册 | VIBE HUB</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --apple-blue: #0071e3;
            --apple-blue-hover: #0077ed;
            --text-main: #1d1d1f;
            --text-sec: #86868b;
            --vibe-black: #1d1d1f;
            --success-green: #34c759;
            --error-red: #ff3b30;
        }

        * { box-sizing: border-box; }

        body {
            margin: 0; padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #ffff99 120%);
            min-height: 120vh;
            display: flex;
            justify-content: center;
            align-items: center;
            -webkit-font-smoothing: antialiased;
        }

        .register-container {
            background: white;
            border-radius: 30px;
            padding: 60px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 30px 60px rgba(0,0,0,0.2);
            animation: slideUp 0.6s ease;
        }

        .register-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .register-header h1 {
            font-size: 36px;
            font-weight: 700;
            margin: 0 0 10px 0;
            color: var(--vibe-black);
        }

        .register-header p {
            color: var(--text-sec);
            font-size: 15px;
            margin: 0;
        }

        .info-box {
            background: #f5f5f7;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 30px;
            border-left: 4px solid var(--apple-blue);
        }

        .info-box p {
            margin: 0;
            color: var(--text-sec);
            font-size: 14px;
            line-height: 1.5;
        }

        .info-box strong {
            color: var(--text-main);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-main);
        }

        .form-group label .required {
            color: var(--error-red);
        }

        .form-group input {
            width: 100%;
            padding: 16px;
            border: 1px solid #d2d2d7;
            border-radius: 12px;
            font-size: 16px;
            background: #f5f5f7;
            outline: none;
            transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .form-group input:focus {
            border-color: var(--apple-blue);
            background: #fff;
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.1);
        }

        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #e5e5e7;
            border-radius: 2px;
            overflow: hidden;
            display: none;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: 0.3s;
            border-radius: 2px;
        }

        .password-hint {
            font-size: 12px;
            color: var(--text-sec);
            margin-top: 6px;
        }

        .register-btn {
            width: 100%;
            padding: 18px;
            background: var(--vibe-black);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 17px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }

        .register-btn:hover {
            background: #ccc;
            transform: scale(1.01);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        .register-btn:active {
            transform: scale(0.99);
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .back-link a {
            color: var(--apple-blue);
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: 0.3s;
        }

        .back-link a:hover {
            color: var(--apple-blue-hover);
        }

        .error-message {
            background: #ffe5e5;
            color: var(--error-red);
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            display: none;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .register-container {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>

    <div class="register-container">
        <div class="register-header">
            <h1><i class="fa-solid fa-user-plus" style="color: var(--apple-blue); margin-right: 10px;"></i>员工注册</h1>
            <p>请使用公司分配的员工工号完成注册</p>
        </div>

        <div class="info-box">
            <p><strong><i class="fa-solid fa-circle-info"></i> 注意事项</strong></p>
            <p>• 仅限公司内部员工注册<br>
               • 请输入 IT 部门分配的员工工号（UID）<br>
               • 首次注册请联系管理员获取验证码</p>
        </div>

        <% 
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error-message" style="display: block;">
                <i class="fa-solid fa-triangle-exclamation"></i>
                <% 
                    if ("uid".equals(error)) {
                        out.print(" 员工工号不存在或已被注册");
                    } else if ("code".equals(error)) {
                        out.print(" 验证码错误");
                    } else if ("password".equals(error)) {
                        out.print(" 两次输入的密码不一致");
                    } else if ("exists".equals(error)) {
                        out.print(" 该用户名已被使用");
                    } else {
                        out.print(" 注册失败，请稍后重试");
                    }
                %>
            </div>
        <% } %>

        <form action="register" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label>员工工号 (UID) <span class="required">*</span></label>
                <input type="text" name="uid" id="uid" placeholder="例如: ID-1" required>
            </div>

            <div class="form-group">
                <label>验证码 <span class="required">*</span></label>
                <input type="text" name="verifyCode" id="verifyCode" placeholder="请联系 IT 部门获取" required>
            </div>

            <div class="form-group">
                <label>用户名 <span class="required">*</span></label>
                <input type="text" name="username" id="username" placeholder="设置登录用户名" required>
            </div>

            <div class="form-group">
                <label>密码 <span class="required">*</span></label>
                <input type="password" name="password" id="password" placeholder="至少 6 位字符" required minlength="6">
                <div class="password-strength" id="strengthBar">
                    <div class="password-strength-bar" id="strengthBarFill"></div>
                </div>
                <div class="password-hint">密码强度建议：包含大小写字母、数字</div>
            </div>

            <div class="form-group">
                <label>确认密码 <span class="required">*</span></label>
                <input type="password" name="confirmPassword" id="confirmPassword" placeholder="再次输入密码" required>
            </div>

            <button type="submit" class="register-btn">
                <i class="fa-solid fa-check"></i> 完成注册
            </button>
        </form>

        <div class="back-link">
            <a href="login.jsp"><i class="fa-solid fa-arrow-left"></i> 返回登录</a>
        </div>
    </div>

    <script>
        // 密码强度检测
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthBarFill = document.getElementById('strengthBarFill');
            
            if (password.length > 0) {
                strengthBar.style.display = 'block';
                let strength = 0;
                
                if (password.length >= 6) strength += 25;
                if (password.length >= 10) strength += 25;
                if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength += 25;
                if (/\d/.test(password)) strength += 25;
                
                strengthBarFill.style.width = strength + '%';
                
                if (strength <= 25) {
                    strengthBarFill.style.background = '#ff3b30';
                } else if (strength <= 50) {
                    strengthBarFill.style.background = '#ff9500';
                } else if (strength <= 75) {
                    strengthBarFill.style.background = '#ffcc00';
                } else {
                    strengthBarFill.style.background = '#34c759';
                }
            } else {
                strengthBar.style.display = 'none';
            }
        });

        // 表单验证
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('两次输入的密码不一致！');
                return false;
            }
            
            if (password.length < 6) {
                alert('密码长度至少为 6 位！');
                return false;
            }
            
            return true;
        }
    </script>

</body>
</html>