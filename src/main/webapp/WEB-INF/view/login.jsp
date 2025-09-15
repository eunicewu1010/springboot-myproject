<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>登入</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Microsoft JhengHei", sans-serif;
            background: linear-gradient(135deg, #D4A574, #8B4513);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #FFF5EC;
            padding: 35px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
        }

        .login-container h2 {
            color: #8B4513;
            text-align: center;
            margin-bottom: 25px;
            font-size: 1.8em;
        }

        label {
            display: block;
            margin: 12px 0 6px;
            font-weight: bold;
            color: #5a4635;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .captcha-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .captcha-group input[type="text"] {
            flex: 1;
        }

        .captcha-group img {
            height: 40px;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        button {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button[type="reset"] {
            background: #D4A574;
            color: #fff;
        }

        button[type="reset"]:hover {
            background: #c08d54;
        }

        button[type="submit"] {
            background: #8B4513;
            color: #fff;
        }

        button[type="submit"]:hover {
            background: #5f3010;
        }

        .error-msg {
            background: #ffd9d9;
            color: #a94442;
            padding: 8px 12px;
            border-radius: 6px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: bold;
        }

        .extra-links {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }

        .extra-links a {
            color: #8B4513;
            text-decoration: none;
            margin: 0 8px;
            transition: color 0.3s ease;
        }

        .extra-links a:hover {
            color: #5f3010;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>📇 歡迎登入</h2>

        <c:if test="${not empty errorMsg}">
            <div class="error-msg">${errorMsg}</div>
        </c:if>

        <form method="post" action="/login">
            <label for="username">👤 帳號：</label>
            <input type="text" id="username" name="username" placeholder="請輸入帳號" required />

            <label for="password">🔒 密碼：</label>
            <input type="password" id="password" name="password" placeholder="請輸入密碼" required />

            <label for="authcode">📝 驗證碼：</label>
            <div class="captcha-group">
                <input type="text" id="authcode" name="authcode" placeholder="請輸入驗證碼" required />
                <img src="/authcode?<%= System.currentTimeMillis() %>" alt="驗證碼" title="點擊刷新驗證碼" onclick="refreshAuthcode()" />
            </div>

            <div class="button-group">
                <button type="reset">重置</button>
                <button type="submit">登入</button>
            </div>
        </form>

        <div class="extra-links">
            <a href="/forgotPassword">❓ 忘記密碼</a> | 
            <a href="/register">🆕 尚未註冊？點我註冊</a>
        </div>
    </div>

    <script>
        function refreshAuthcode() {
            const img = document.querySelector('.captcha-group img');
            img.src = '/authcode?' + new Date().getTime();
        }
    </script>
</body>
</html>
