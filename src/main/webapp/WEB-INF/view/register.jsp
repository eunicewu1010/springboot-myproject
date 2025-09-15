<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
   <meta charset="UTF-8">
   <title>使用者註冊</title>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <style>
       body {
           margin: 0;
           padding: 0;
           font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
           background: linear-gradient(to bottom right, #f3e9dd, #d4a574);
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
           scroll-behavior: smooth;
       }
       .register-container {
           background-color: #fff;
           padding: 40px 30px;
           border-radius: 15px;
           box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
           width: 100%;
           max-width: 420px;
           animation: fadeIn 0.8s ease;
       }
       h2 {
           text-align: center;
           color: #8B4513;
           margin-bottom: 25px;
           font-size: 1.8em;
       }
       .form-group {
           margin-bottom: 20px;
       }
       .form-group label {
           display: block;
           margin-bottom: 8px;
           color: #5a4635;
           font-weight: bold;
       }
       .form-group input[type="text"],
       .form-group input[type="password"],
       .form-group input[type="email"] {
           width: 100%;
           padding: 10px;
           border: 1px solid #ddd;
           border-radius: 8px;
           font-size: 16px;
           transition: box-shadow 0.3s ease;
       }
       .form-group input:focus {
           outline: none;
           box-shadow: 0 0 8px #d4a574;
       }
       .form-group input[type="submit"] {
           width: 100%;
           padding: 12px;
           background-color: #d4a574;
           color: white;
           border: none;
           border-radius: 25px;
           font-size: 18px;
           font-weight: bold;
           cursor: pointer;
           transition: background-color 0.3s ease, transform 0.2s ease;
       }
       .form-group input[type="submit"]:hover {
           background-color: #b77d48;
           transform: scale(1.05);
       }
       .form-group input[type="submit"]:active {
           background-color: #a1673b;
           transform: scale(1.0);
       }
       .message {
           text-align: center;
           margin-top: 20px;
           color: green;
           font-weight: bold;
       }
       .error-message {
           color: red;
           margin-top: 10px;
           text-align: center;
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
   </style>
</head>
<body>
   <form class="register-container" method="post" action="/register">
       <h2>📝 使用者註冊</h2>
       <div class="form-group">
           <label for="username">👤 使用者名稱:</label>
           <input type="text" id="username" name="username" required>
       </div>
       <div class="form-group">
           <label for="password">🔒 密碼（至少6碼）:</label>
           <input type="password" id="password" name="password" required pattern=".{6,}" title="密碼需至少 6 碼">
       </div>
       <div class="form-group">
           <label for="email">📧 電子信箱:</label>
           <input type="email" id="email" name="email" required>
       </div>
       <!-- 隱藏的角色欄位，預設為 user -->
       <input type="hidden" name="role" value="user">

       <div class="form-group">
           <input type="submit" value="✅ 註冊">
       </div>
   </form>
</body>
</html>
