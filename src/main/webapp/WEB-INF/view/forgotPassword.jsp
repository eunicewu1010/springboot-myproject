<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>🔑 忘記密碼</title>
    <style>
        body {
            font-family: "Microsoft JhengHei", sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #fef6f0, #f5e0c3);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            scroll-behavior: smooth;
        }
        .forgot-container {
            background-color: #fffaf4;
            padding: 40px 35px;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(139, 69, 19, 0.2);
            width: 100%;
            max-width: 420px;
            animation: fadeIn 0.7s ease-in-out;
        }
        h2 {
            text-align: center;
            color: #8B4513;
            margin-bottom: 25px;
            font-size: 26px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            color: #5a3410;
        }
        input[type="email"] {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 8px;
            border: 1px solid #caa17e;
            font-size: 16px;
            background-color: #fff9f3;
            transition: border-color 0.3s;
        }
        input[type="email"]:focus {
            border-color: #8B4513;
            outline: none;
        }
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(to right, #D4A574, #8B4513);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
            transition: background 0.3s ease, transform 0.2s;
        }
        .btn:hover {
            background: linear-gradient(to right, #bb8d57, #6e3a11);
            transform: translateY(-2px);
        }
        .error-msg, .success-msg {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: bold;
        }
        .error-msg {
            background: #ffe5e0;
            color: #a10000;
            border: 1px solid #ffbbbb;
        }
        .success-msg {
            background: #e6ffed;
            color: #006b3c;
            border: 1px solid #a2f0c2;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @media (max-width: 480px) {
            .forgot-container {
                padding: 30px 20px;
            }
            h2 {
                font-size: 22px;
            }
            .btn {
                font-size: 15px;
                padding: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <h2>🔐 忘記密碼</h2>

        <!-- 錯誤/成功訊息 -->
        <c:if test="${not empty errorMsg}">
            <div class="error-msg">❌ ${errorMsg}</div>
        </c:if>
        <c:if test="${not empty successMsg}">
            <div class="success-msg">✅ ${successMsg}</div>
        </c:if>

	<form method="post" action="/forgotPassword" onsubmit="return validateEmail()">
            <label for="email">請輸入註冊時的 Email：</label>
            <input type="email" id="email" name="email" placeholder="your-email@example.com" required />
            <button class="btn" type="submit">📧 發送重設連結</button>
        </form>
    </div>

    <script>
        function validateEmail() {
            const email = document.getElementById('email').value.trim();
            if (email === "") {
                alert("請輸入 Email");
                return false;
            }
            // 簡單 Email 格式檢查
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("請輸入有效的 Email 格式");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
