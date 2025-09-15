<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>

<%
    Map<Integer, String> timeMap = new HashMap<>();
    timeMap.put(1, "10:00 - 11:30");
    timeMap.put(2, "12:00 - 13:30");
    timeMap.put(3, "14:00 - 15:30");
    timeMap.put(4, "16:00 - 17:30");
    timeMap.put(5, "18:00 - 19:30");
    request.setAttribute("timeMap", timeMap);
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <title>🗓️ 顧客訂位總覽</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
      body {
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          margin: 0;
          padding: 0;
          background: linear-gradient(135deg, #D4A574 0%, #8B4513 100%);
          color: #4A2C15;
          display: flex;
          flex-direction: column;
          align-items: center;
          min-height: 100vh;
      }
      .container {
          background: #FFF8E7;
          margin: 3rem auto;
          padding: 2rem;
          border-radius: 20px;
          box-shadow: 0 10px 25px rgba(139, 69, 19, 0.3);
          width: 95%;
          max-width: 1000px;
      }
      h1 {
          font-size: 2.2rem;
          text-align: center;
          margin-bottom: 1rem;
          color: #8B4513;
          text-shadow: 1px 1px 4px #D4A574;
      }
      .btn-group {
          display: flex;
          justify-content: center;
          gap: 1rem;
          margin-bottom: 1.5rem;
      }
      .btn {
          padding: 0.6rem 1.2rem;
          background-color: #8B4513;
          color: #FFF8E7;
          border: none;
          border-radius: 8px;
          font-weight: bold;
          text-decoration: none;
          cursor: pointer;
          box-shadow: 0 4px 12px rgba(139, 69, 19, 0.4);
          transition: background-color 0.3s ease;
          font-size: 1rem;
      }
      .btn:hover {
          background-color: #D4A574;
          color: #4A2C15;
      }
      table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 1rem;
      }
      th, td {
          border: 1px solid #D4A574;
          padding: 12px;
          text-align: center;
      }
      th {
          background-color: #D4A574;
          color: #4A2C15;
      }
      tr:hover {
          background-color: #fdf5e6;
          transition: background-color 0.3s ease;
      }
      .action-buttons {
          display: flex;
          justify-content: center;
          gap: 6px;
      }
      .edit-btn, .delete-btn {
          min-width: 70px;
          padding: 6px 0;
          border: none;
          border-radius: 6px;
          cursor: pointer;
          font-weight: bold;
          text-decoration: none;
          display: inline-block;
          text-align: center;
          font-size: 0.9rem;
      }
      .edit-btn {
          background-color: #8B4513;
          color: #FFF8E7;
      }
      .edit-btn:hover {
          background-color: #D4A574;
          color: #4A2C15;
      }
      .delete-btn {
          background-color: #a52a2a;
          color: #fff0e6;
      }
      .delete-btn:hover {
          background-color: #d46a6a;
      }
  </style>
</head>
<body>
<div class="container">
  <h1>📋 顧客訂位總覽</h1>
  <div class="btn-group">
      <a href="${pageContext.request.contextPath}/admin/adminpage" class="btn">🏠 回管理員首頁</a>
      <a href="${pageContext.request.contextPath}/admin/usermanagement" class="btn">👤 使用者管理</a>
	  <a href="${pageContext.request.contextPath}/reservation" class="btn">🖊️ 訂位頁面</a>
      <a href="${pageContext.request.contextPath}/homepage" class="btn">🐱 喵喵貓咖首頁</a>
      <a href="${pageContext.request.contextPath}/login/logout" class="btn">🚪 登出</a>
  </div>
  <table>
      <thead>
      <tr>
          <th>編號</th>
          <th>日期</th>
          <th>時段</th>
          <th>姓名</th>
          <th>Email</th>
          <th>電話</th>
          <th>人數</th>
          <th>備註</th>
          <th>操作</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="reservation" items="${reservationList}">
          <tr>
              <td>${reservation.reservationId}</td>
              <td>${reservation.date}</td>
              <td>
                  <c:choose>
                      <c:when test="${not empty reservation.timeSlots}">
                          ${timeMap[reservation.timeSlots.timeId]}
                      </c:when>
                      <c:otherwise>無時段</c:otherwise>
                  </c:choose>
              </td>
              <td>${reservation.name}</td>
              <td>${reservation.email}</td>
              <td>${reservation.phone}</td>
              <td>${reservation.people}</td>
              <td>${reservation.message}</td>
              <td>
                  <div class="action-buttons">
                      <a class="edit-btn"
                         href="${pageContext.request.contextPath}/admin/editReservation?id=${reservation.reservationId}">
                          ✏️ 修改
                      </a>
                      <form action="${pageContext.request.contextPath}/admin/deleteReservation" method="post" style="display:inline;">
                          <input type="hidden" name="reservationId" value="${reservation.reservationId}" />
                          <button type="submit" class="delete-btn" onclick="return confirm('確定要刪除此筆訂位嗎？');">🗑️ 刪除</button>
                      </form>
                  </div>
              </td>
          </tr>
      </c:forEach>
      </tbody>
  </table>
</div>
</body>
</html>
