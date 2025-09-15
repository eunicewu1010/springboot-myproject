<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>☕ 使用者頁面</title>
    <style>
        /* 背景與整體字型 */
        body {
            font-family: 'Segoe UI', '微軟正黑體', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #fffaf4, #f5e8d3);
            scroll-behavior: smooth;
        }

        /* 導覽列 */
        .navbar {
            background-color: #8B4513;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            padding: 10px 18px;
            font-weight: bold;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .navbar a:hover {
            background-color: #D4A574;
            color: #4b2b0a;
        }

        /* 內容容器 */
        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff8ee;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
        }

        h1 {
            color: #8B4513;
            font-size: 32px;
            margin-bottom: 30px;
        }

        /* 按鈕區域 */
        .button-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .button-group button {
            background: linear-gradient(to right, #D4A574, #8B4513);
            border: none;
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border-radius: 10px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            transition: transform 0.2s ease, background-color 0.3s ease;
        }

        .button-group button:hover {
            transform: translateY(-4px);
            background: linear-gradient(to right, #c69559, #5a3413);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .button-group {
                flex-direction: column;
                align-items: center;
            }
            .button-group button {
                width: 80%;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

    <!-- 🍫 導覽列 -->
    <div class="navbar">
        <div>
            <a href="#">👤 ${ (userCert eq null) ? "尚未登入" : userCert.username }</a>
        </div>
        <div>
            <a href="homepage">🏠 回首頁</a>
            <a href="login/logout">🚪 登出</a>
        </div>
    </div>

    <!-- ☕ 主容器 -->
    <div class="container">
        <h1>🌟 歡迎來到使用者頁面 🌟</h1>
        <div class="button-group">
            <button onclick="location.href='reservation'">🍽️ 來去訂位</button>
            <button onclick="location.href='reservation/history'">📖 歷史訂位查詢</button>
            <button onclick="location.href='profile'">📝 查看會員資料</button>
        </div>
    </div>

</body>
</html>
