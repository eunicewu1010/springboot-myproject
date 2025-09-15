<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>喵喵貓咖管理系統 🐾</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
/* 保留原本樣式不變 */
body {
  font-family: 'Segoe UI', Tahoma, sans-serif;
  margin: 0;
  padding: 0;
  background: linear-gradient(135deg, #D4A574 0%, #8B4513 100%);
  color: #4A2C15;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  scroll-behavior: smooth;
}
.container {
  background: #FFF8E7;
  margin: 5rem auto;
  padding: 3rem 2rem;
  border-radius: 20px;
  box-shadow: 0 10px 20px rgba(139,69,19,0.3);
  text-align: center;
  width: 90%;
  max-width: 600px;
  animation: fadeInUp 1s ease forwards;
}
h1 {
  font-size: 2.5rem;
  margin-bottom: 2rem;
  color: #8B4513;
  text-shadow: 1px 1px 4px #D4A574;
}
.button {
  display: inline-block;
  margin: 1rem;
  padding: 1rem 2rem;
  font-size: 1.2rem;
  font-weight: bold;
  color: #FFF8E7;
  background-color: #8B4513;
  border: none;
  border-radius: 40px;
  text-decoration: none;
  box-shadow: 0 5px 12px rgba(0,0,0,0.2);
  transition: background-color 0.3s ease, transform 0.3s ease;
  cursor: pointer;
}
.button:hover {
  background-color: #A0522D;
  transform: scale(1.05);
}
@keyframes fadeInUp {
  0% { opacity: 0; transform: translateY(30px); }
  100% { opacity: 1; transform: translateY(0); }
}
@media (max-width: 480px) {
  .button {
    width: 80%;
    font-size: 1rem;
    padding: 0.8rem 1rem;
  }
}
.footer {
  text-align: center;
  color: #E8D3B2;
  margin-top: auto;
  padding: 2rem 1rem;
  font-size: 0.9rem;
}
</style>

<!-- 若不是 admin，觸發彈跳視窗並導回 userpage -->
<c:if test="${not empty sessionScope.userCert and sessionScope.userCert.role ne 'admin'}">
<script>
  alert("⚠️ 您沒有管理員權限，將返回使用者首頁");
  window.location.href = "<c:url value='/userpage' />";
</script>
</c:if>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
</script>
</head>
<body>

<div class="container">
  <h1>喵喵貓咖管理系統 🐱☕</h1>

  <!-- 僅 admin 可見 -->
  <c:if test="${sessionScope.userCert.role eq 'admin'}">
    <a href="${pageContext.request.contextPath}/admin/usermanagement" class="button">👤 使用者管理</a>
    <a href="${pageContext.request.contextPath}/admin/reservations" class="button">🧾 訂位管理</a>
    <a href="${pageContext.request.contextPath}/homepage" class="button">🏠 喵喵貓咖訂位系統</a>
  </c:if>

  <!-- 登出 -->
  <a href="${pageContext.request.contextPath}/login/logout" class="button">🚪 登出</a>
</div>

<div class="footer">
  <p>🐾 本系統僅限喵喵貓咖管理員使用！</p>
</div>
</body>
</html>
