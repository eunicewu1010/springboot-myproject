<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
   <meta charset="UTF-8">
   <title>🔑 變更密碼</title>
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

       .change-container {
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

       input[type="password"] {
           width: 100%;
           padding: 12px;
           margin-top: 8px;
           border-radius: 8px;
           border: 1px solid #caa17e;
           font-size: 16px;
           background-color: #fff9f3;
           transition: border-color 0.3s;
       }

       input[type="password"]:focus {
           border-color: #8B4513;
           outline: none;
       }

       .form-group {
           margin-bottom: 18px;
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

       .info-text {
           text-align: center;
           color: #8B4513;
           margin-bottom: 20px;
           font-size: 14px;
       }

       .back-btn {
           display: block;
           width: 100%;
           text-align: center;
           margin-bottom: 20px;
           padding: 12px 0;
           background: #8B4513;
           color: #FFF8E7;
           border-radius: 8px;
           font-weight: bold;
           text-decoration: none;
           box-shadow: 0 4px 12px rgba(139, 69, 19, 0.4);
           transition: background-color 0.3s ease;
       }
       .back-btn:hover {
           background: #D4A574;
           color: #4A2C15;
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
           .change-container {
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
   <div class="change-container">
       <h2>🔐 密碼變更專區</h2>

       <a href="${pageContext.request.contextPath}/profile" class="back-btn">⬅️ 返回使用者頁面</a>

       <p class="info-text">如需更改其他資料請用 mail 聯絡我們，謝謝。</p>

       <!-- 錯誤/成功訊息 -->
       <c:if test="${not empty errorMsg}">
           <div class="error-msg">❌ ${errorMsg}</div>
       </c:if>
       <c:if test="${not empty successMsg}">
           <div class="success-msg">✅ ${successMsg}</div>
       </c:if>

       <!-- 表單 -->
       <form method="post" action="${pageContext.request.contextPath}/changePassword" onsubmit="return validatePassword()">
           <div class="form-group">
               <label for="oldPassword">🔓 原密碼：</label>
               <input type="password" id="oldPassword" name="oldPassword" required />
           </div>
           <div class="form-group">
               <label for="newPassword">🆕 新密碼：</label>
               <input type="password" id="newPassword" name="newPassword" required />
           </div>
           <div class="form-group">
               <label for="confirmPassword">✅ 確認新密碼：</label>
               <input type="password" id="confirmPassword" name="confirmPassword" required />
           </div>
           <button class="btn" type="submit">💾 確認變更</button>
       </form>
   </div>

   <script>
       function validatePassword() {
           const newPassword = document.getElementById('newPassword').value;
           const confirmPassword = document.getElementById('confirmPassword').value;

           if (newPassword !== confirmPassword) {
               alert("⚠️ 新密碼與確認密碼不一致！");
               return false;
           }

           if (newPassword.length < 6) {
               alert("🔐 新密碼至少需要 6 個字元！");
               return false;
           }

           return true;
       }
   </script>
</body>
</html>
