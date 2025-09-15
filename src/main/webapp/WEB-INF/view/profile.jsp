<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>個人資料</title>
   <style>
       body {
           font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
           margin: 0;
           padding: 0;
           background: linear-gradient(to bottom right, #f7f0e8, #e0c3a8);
           scroll-behavior: smooth;
       }
       /* 導覽列 */
       nav {
           background-color: #8B4513;
           padding: 15px 30px;
           display: flex;
           justify-content: space-between;
           align-items: center;
           color: white;
           box-shadow: 0 4px 8px rgba(0,0,0,0.1);
       }
       nav .nav-left {
           font-size: 20px;
           font-weight: bold;
       }
       nav .nav-links a {
           color: white;
           text-decoration: none;
           margin-left: 20px;
           transition: color 0.3s ease;
       }
       nav .nav-links a:hover {
           color: #D4A574;
       }
       .profile-container {
           background-color: white;
           padding: 30px;
           margin: 40px auto;
           max-width: 600px;
           border-radius: 15px;
           box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
           animation: fadeIn 1s ease;
       }
       h2 {
           text-align: center;
           color: #8B4513;
           margin-bottom: 30px;
       }
       .profile-field {
           display: flex;
           margin: 15px 0;
           align-items: center;
       }
       .profile-field label {
           width: 120px;
           font-weight: bold;
           color: #8B4513;
       }
       .profile-field span {
           flex-grow: 1;
           color: #444;
       }
       button {
           background-color: #D4A574;
           border: none;
           padding: 10px 20px;
           border-radius: 25px;
           cursor: pointer;
           color: #fff;
           font-weight: bold;
           transition: background-color 0.3s ease, transform 0.2s;
       }
       button:hover {
           background-color: #b07c47;
           transform: scale(1.05);
       }
       .info-text {
           margin-top: 25px;
           color: #8B4513;
           font-size: 14px;
           text-align: center;
           font-style: italic;
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
       /* 響應式 */
       @media (max-width: 600px) {
           .profile-field {
               flex-direction: column;
               align-items: flex-start;
           }
           .profile-field label {
               width: 100%;
               margin-bottom: 5px;
           }
       }
   </style>
</head>
<body>
<!-- 導覽列 -->
<nav>
   <div class="nav-left">🐱 喵喵貓咖</div>
   <div class="nav-links">
       <a href="/homepage">🏠 回首頁</a>
       <a href="/userpage">👤 使用者頁面</a>
   </div>
</nav>
<!-- 主內容 -->
<div class="profile-container">
   <h2>👤 個人資料</h2>
   <div class="profile-field">
       <label>帳號：</label>
       <span><c:out value="${user.username}"/></span>
   </div>
   <div class="profile-field">
       <label>電子信箱：</label>
       <span><c:out value="${user.email}"/></span>
   </div>
   <div class="profile-field">
       <label></label>
       <button onclick="location.href='/changePassword'">🔒 更改密碼</button>
   </div>
   
   <!-- 新增的說明文字 -->
   <div class="info-text">
       如帳號有問題，請發 mail 至 <a href="mailto:meowmeowcafe@gmail.com">meowmeowcafe@gmail.com</a>
   </div>
</div>
</body>
</html>
