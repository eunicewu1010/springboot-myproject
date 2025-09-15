<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    java.time.LocalDate today = java.time.LocalDate.now();
    String minDate = today.toString(); // 今天
    String maxDate = today.plusMonths(1).toString(); // 一個月後
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8" />
<title>編輯訂位資料</title>
<style>
  body {
    font-family: "Microsoft JhengHei", Arial, sans-serif;
    background: linear-gradient(135deg, #D4A574, #8B4513);
    color: #4B2E05;
    min-height: 100vh;
    padding: 2rem;
  }
  .container {
    background: #FFF9F0;
    max-width: 600px;
    margin: 0 auto;
    padding: 2rem 3rem;
    border-radius: 15px;
    box-shadow: 0 12px 25px rgba(139,69,19,0.25);
  }
  h1 {
    text-align: center;
    margin-bottom: 1.5rem;
  }
  label {
    display: block;
    margin: 1rem 0 0.3rem;
    font-weight: bold;
  }
  input, select, textarea {
    width: 100%;
    padding: 0.5rem 1rem;
    border-radius: 10px;
    border: 2px solid #D4A574;
    font-size: 1rem;
    box-shadow: inset 2px 2px 5px rgba(211, 165, 116, 0.3);
  }
  input:focus, select:focus, textarea:focus {
    border-color: #8B4513;
    outline: none;
    box-shadow: 0 0 8px #8B4513;
  }
  .btn-submit {
    margin-top: 2rem;
    background: linear-gradient(90deg, #8B4513, #D4A574);
    color: #FFF9F0;
    padding: 1rem;
    font-size: 1.2rem;
    font-weight: 700;
    border: none;
    border-radius: 18px;
    cursor: pointer;
    box-shadow: 0 6px 15px rgba(139,69,19,0.5);
    width: 100%;
  }
  .btn-submit:hover {
    background: linear-gradient(90deg, #D4A574, #8B4513);
    box-shadow: 0 10px 25px rgba(212,165,116,0.7);
  }
  .message {
    margin-bottom: 1rem;
    padding: 1rem;
    border-radius: 12px;
  }
  .message.success {
    background-color: #d4edda;
    color: #155724;
  }
  .message.error {
    background-color: #f8d7da;
    color: #721c24;
  }
  .btn-group {
    margin-top: 1rem;
    display: flex;
    justify-content: space-between;
  }
  .btn-secondary {
    background: linear-gradient(90deg, #A0522D, #D2B48C);
    color: #FFF9F0;
    padding: 0.75rem 1.5rem;
    font-size: 1rem;
    font-weight: 600;
    border: none;
    border-radius: 18px;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(139,69,19,0.4);
    transition: background 0.3s ease;
  }
  .btn-secondary:hover {
    background: linear-gradient(90deg, #D2B48C, #A0522D);
  }
</style>
</head>
<body>
<div class="container">
  <h1>編輯訂位資料</h1>
  <c:if test="${not empty message}">
    <div class="message success">${message}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="message error">${error}</div>
  </c:if>

  <form:form method="post" action="${pageContext.request.contextPath}/admin/updateReservation" modelAttribute="reservation" id="reservationForm">
    <form:hidden path="reservationId" />

    <label for="name">預約人姓名</label>
    <form:input path="name" id="name" required="required" />

    <label for="phone">預約人電話</label>
    <form:input path="phone" id="phone" required="required" />

    <label for="email">預約人郵件</label>
    <form:input path="email" id="email" type="email" required="required" />

    <label for="date">可預約日期</label>
    <form:input path="date" id="date" type="date" required="required" min="<%= minDate %>" max="<%= maxDate %>" />

    <label for="timeSlots.timeId">可選擇時段</label>
    <form:select path="timeSlots.timeId" id="timeSlots.timeId" required="required">
      <form:option value="" label="請選擇時段" />
      <form:option value="1" label="10:00 - 11:30" />
      <form:option value="2" label="12:00 - 13:30" />
      <form:option value="3" label="14:00 - 15:30" />
      <form:option value="4" label="16:00 - 17:30" />
      <form:option value="5" label="18:00 - 19:30" />
    </form:select>

    <label for="people">用餐人數</label>
    <form:select path="people" id="people" required="required">
      <form:option value="" label="請選擇" />
      <form:option value="1" label="1位" />
      <form:option value="2" label="2位" />
      <form:option value="3" label="3位" />
      <form:option value="4" label="4位" />
      <form:option value="5" label="5位" />
      <form:option value="6" label="6位" />
    </form:select>

    <label for="message">特殊需求備註</label>
    <form:textarea path="message" id="message" rows="4" placeholder="例如：慶生、過敏資訊、指定座位區等" />

    <button type="submit" class="btn-submit">✅ 更新訂位</button>
  </form:form>

  <div class="btn-group">
    <button type="button" class="btn-secondary" onclick="history.back()">← 回上一頁</button>
    <button type="button" class="btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/admin/adminpage'">🏠 回管理員首頁</button>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('reservationForm');
  const dateInput = document.getElementById('date');

  form.addEventListener('submit', function (e) {
    const minDate = dateInput.getAttribute('min');
    const maxDate = dateInput.getAttribute('max');
    const selectedDate = dateInput.value;

    if (!selectedDate) {
      alert('請選擇日期');
      e.preventDefault();
      return;
    }

    if (selectedDate < minDate || selectedDate > maxDate) {
      alert('日期必須介於 ' + minDate + ' 與 ' + maxDate + ' 之間');
      e.preventDefault();
      return;
    }
  });
});
</script>
</body>
</html>
