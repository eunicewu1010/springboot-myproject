<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>喵喵貓咖使用者管理系統 🐾</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    margin: 0; padding: 0;
    background: linear-gradient(135deg, #D4A574 0%, #8B4513 100%);
    color: #4A2C15;
    min-height: 100vh;
    display: flex; flex-direction: column; align-items: center;
}
.container {
    background: #FFF8E7;
    margin: 2rem auto;
    padding: 2rem;
    border-radius: 20px;
    box-shadow: 0 10px 20px rgba(139,69,19,0.3);
    width: 90%;
    max-width: 800px;
    animation: fadeInUp 1s ease forwards;
}
h1, h2 {
    text-align: center;
    color: #8B4513;
    text-shadow: 1px 1px 4px #D4A574;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1.5rem;
}
th, td {
    border: 1px solid #8B4513;
    padding: 10px;
    text-align: center;
}
th {
    background-color: #D4A574;
    color: #4A2C15;
}
.button {
    display: inline-block;
    margin: 0.5rem 0.2rem;
    padding: 0.5rem 1rem;
    font-size: 1rem;
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
.button.delete {
    background-color: #B22222;
}
.button.delete:hover {
    background-color: #8B0000;
}
input, select {
    padding: 0.5rem;
    border-radius: 8px;
    border: 1px solid #ccc;
    width: 100%;
    margin-top: 0.3rem;
}
label {
    font-weight: bold;
}
.footer {
    text-align: center;
    color: #E8D3B2;
    margin-top: auto;
    padding: 2rem 1rem;
    font-size: 0.9rem;
}
@keyframes fadeInUp {
    0% { opacity: 0; transform: translateY(30px); }
    100% { opacity: 1; transform: translateY(0); }
}
</style>

<!-- 非 admin 導回 -->
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
    <h1>喵喵貓咖使用者管理系統 🐱☕</h1>

    <c:if test="${sessionScope.userCert.role eq 'admin'}">
        <a href="${pageContext.request.contextPath}/admin/adminpage" class="button">👤 管理員首頁</a>
        <a href="${pageContext.request.contextPath}/admin/reservations" class="button">🧾 訂位管理</a>
        <a href="${pageContext.request.contextPath}/homepage" class="button">🐱 喵喵貓咖訂位系統</a>
    </c:if>
    <a href="${pageContext.request.contextPath}/login/logout" class="button">🚪 登出</a>

    <c:if test="${not empty message}">
        <p style="color: green; font-weight: bold;">${message}</p>
    </c:if>

    <!-- 使用者列表 -->
    <table>
        <thead>
            <tr>
                <th>帳號</th>
                <th>電子信箱</th>
                <th>身分</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.email}</td>
                    <td>${user.role}</td>
                    <td>
                        <!-- 修改 -->
                        <form action="${pageContext.request.contextPath}/admin/editUser" method="get" style="display:inline;">
                            <input type="hidden" name="userId" value="${user.userId}" />
                            <button type="submit" class="button">✏️ 修改</button>
                        </form>
                        <!-- 刪除 -->
                        <form action="${pageContext.request.contextPath}/admin/deleteUser" method="post" style="display:inline;"
                              onsubmit="return confirm('確定要刪除使用者「${user.username}」嗎？');">
                            <input type="hidden" name="userId" value="${user.userId}" />
                            <button type="submit" class="button delete">🗑️ 刪除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 修改使用者表單 -->
<c:if test="${not empty selectedUser}">
    <div class="container">
        <h2>🔧 修改使用者資料</h2>
        <form action="${pageContext.request.contextPath}/admin/updateUser" method="post">
            <input type="hidden" name="userId" value="${selectedUser.userId}" />
            <p>
                <label for="username">帳號：</label><br>
                <input type="text" name="username" id="username" value="${selectedUser.username}" required />
            </p>
            <p>
                <label for="email">電子信箱：</label><br>
                <input type="email" name="email" id="email" value="${selectedUser.email}" required />
            </p>
            <p>
                <label for="role">身分：</label><br>
                <select name="role" id="role">
                    <option value="user" <c:if test="${selectedUser.role eq 'user'}">selected</c:if>>一般使用者</option>
                    <option value="admin" <c:if test="${selectedUser.role eq 'admin'}">selected</c:if>>管理員</option>
                </select>
            </p>
            <p>
                <label for="password">新密碼（留空不修改）：</label><br>
                <input type="password" name="password" id="password" />
                <span style="font-size: 0.9rem; color: #555;">若未輸入，將保留原密碼</span>
            </p>
            <button type="submit" class="button">💾 儲存修改</button>
        </form>
    </div>
</c:if>

<!-- 新增使用者表單 -->
<div class="container">
    <h2>➕ 新增使用者</h2>
    <form action="${pageContext.request.contextPath}/admin/addUser" method="post">
        <p>
            <label for="newUsername">帳號：</label><br>
            <input type="text" name="username" id="newUsername" required />
        </p>
        <p>
            <label for="newEmail">電子信箱：</label><br>
            <input type="email" name="email" id="newEmail" required />
        </p>
        <p>
            <label for="newPassword">密碼：</label><br>
            <input type="password" name="password" id="newPassword" required />
        </p>
        <p>
            <label for="newRole">身分：</label><br>
            <select name="role" id="newRole">
                <option value="user">一般使用者</option>
                <option value="admin">管理員</option>
            </select>
        </p>
        <button type="submit" class="button">➕ 建立帳號</button>
    </form>
</div>

<div class="footer">
    <p>🐾 本系統僅限喵喵貓咖管理員使用！</p>
</div>

</body>
</html>
