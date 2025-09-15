<%-- logout.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登出成功</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom right, #f3e9dd, #d4a574);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            scroll-behavior: smooth;
        }

        .container {
            background-color: #fff;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            text-align: center;
            animation: fadeIn 1s ease;
            max-width: 400px;
            width: 90%;
        }

        h1 {
            color: #8B4513;
            margin-bottom: 20px;
            font-size: 2em;
        }

        p {
            font-size: 1.1em;
            color: #444;
            margin-bottom: 30px;
        }

        a.button-secondary {
            display: inline-block;
            background-color: #D4A574;
            color: white;
            padding: 12px 30px;
            border-radius: 30px;
            text-decoration: none;
            font-size: 1em;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        a.button-secondary:hover {
            background-color: #b77d48;
            transform: scale(1.05);
        }

        a.button-secondary:active {
            background-color: #a1673b;
            transform: scale(1.0);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👋 您已成功登出</h1>
        <p>期待再次與您相見！<br>祝您有美好的一天 ☀️</p>
        <a href="/homepage" class="button-secondary">🏠 返回首頁</a>
    </div>
</body>
</html>
