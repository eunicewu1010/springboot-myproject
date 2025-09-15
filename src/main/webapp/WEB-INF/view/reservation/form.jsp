<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>🍽️ 餐廳線上訂位</title>
<style>
  /* Reset & Base */
  * {
    box-sizing: border-box;
    scroll-behavior: smooth;
  }
  body {
    font-family: "Microsoft JhengHei", Arial, sans-serif;
    margin: 0; padding: 0;
    background: linear-gradient(135deg, #D4A574, #8B4513);
    color: #4B2E05;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  /* 導航列 */
  .navbar {
    background: linear-gradient(90deg, #6B3E07, #A97447);
    padding: 12px 0;
    text-align: center;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    position: sticky;
    top: 0;
    z-index: 100;
  }
  .navbar a {
    color: #fff8e7;
    text-decoration: none;
    padding: 14px 22px;
    font-weight: 600;
    border-radius: 10px;
    transition: background-color 0.3s ease, color 0.3s ease;
    display: inline-block;
  }
  .navbar a:hover {
    background-color: #D4A574;
    color: #4B2E05;
    box-shadow: 0 0 8px #D4A574;
  }

  /* 主容器 */
  .container {
    background: #FFF9F0;
    max-width: 720px;
    width: 90%;
    margin: 30px auto 40px auto;
    padding: 30px 40px;
    border-radius: 20px;
    box-shadow: 0 12px 25px rgba(139,69,19,0.25);
    animation: fadeInUp 0.8s ease forwards;
  }

  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(30px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  /* 標題 */
  h1 {
    text-align: center;
    margin-bottom: 35px;
    font-size: 2.6rem;
    font-weight: 700;
    color: #6B3E07;
    text-shadow: 1px 1px 2px #A97447;
  }

  /* 表單樣式 */
  form {
    display: flex;
    flex-direction: column;
  }
  .form-group {
    margin-bottom: 22px;
  }
  label {
    display: block;
    font-weight: 700;
    margin-bottom: 8px;
    color: #8B4513;
    font-size: 1.1rem;
  }
  input[type="text"],
  input[type="email"],
  select,
  textarea {
    width: 100%;
    padding: 12px 15px;
    border-radius: 12px;
    border: 2px solid #D4A574;
    font-size: 1rem;
    transition: border-color 0.3s ease;
    background: #FFF9F0;
    box-shadow: inset 2px 2px 5px rgba(211, 165, 116, 0.3);
  }
  input[type="text"]:focus,
  input[type="email"]:focus,
  select:focus,
  textarea:focus {
    border-color: #8B4513;
    outline: none;
    box-shadow: 0 0 8px #8B4513;
  }
  textarea {
    resize: vertical;
  }

  /* 備註 */
  .notes {
    font-size: 0.9rem;
    color: #7B4B12;
    margin-top: 6px;
    font-style: italic;
  }

  /* 送出按鈕 */
  .submit-button {
    background: linear-gradient(90deg, #8B4513, #D4A574);
    color: #FFF9F0;
    font-size: 1.3rem;
    font-weight: 700;
    padding: 14px;
    border: none;
    border-radius: 18px;
    cursor: pointer;
    box-shadow: 0 6px 15px rgba(139,69,19,0.5);
    transition: background 0.4s ease, transform 0.3s ease;
  }
  .submit-button:hover {
    background: linear-gradient(90deg, #D4A574, #8B4513);
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(212,165,116,0.7);
  }

  /* 用餐注意事項 */
  .notice {
    background: #FDF6E3;
    border-left: 8px solid #8B4513;
    margin-top: 40px;
    padding: 22px 30px;
    border-radius: 12px;
    color: #6B3E07;
    box-shadow: 2px 2px 10px rgba(212,165,116,0.3);
  }
  .notice h2 {
    margin-top: 0;
    font-size: 1.8rem;
    margin-bottom: 16px;
  }
  .notice ul {
    margin: 0;
    padding-left: 20px;
    list-style: inside disc;
    font-size: 1rem;
    line-height: 1.6;
  }

  /* 頁腳 */
  .footer {
    background: #6B3E07;
    color: #FFF9F0;
    text-align: center;
    padding: 16px 0;
    font-weight: 600;
    box-shadow: 0 -4px 12px rgba(139,69,19,0.6);
  }

  /* 響應式 */
  @media (max-width: 480px) {
    .container {
      padding: 25px 20px;
    }
    h1 {
      font-size: 2rem;
    }
    .submit-button {
      font-size: 1.1rem;
      padding: 12px;
    }
  }
</style>

<!-- jQuery UI 日期選擇器 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function() {
  $("#datepicker").datepicker({
    dateFormat: "yy-mm-dd",
    minDate: 0,
    maxDate: "+1M",
    onSelect: function(dateText) {
      alert("📅 您選擇了日期：" + dateText + "，請接著選擇時段。");
    }
  });
});
</script>

</head>

<c:if test="${empty sessionScope.userCert}">
  <script>
    alert("⚠️ 請先登入！");
    window.location.href = "${pageContext.request.contextPath}/login";
  </script>
</c:if>

<body>

<div class="navbar">
  <a href="homepage">🏠 回到首頁</a>
  <a href="userpage">👤 個人頁面</a>
  <a href="reservation/history">📜 訂位資料</a>
  <a href="uploadmenu">📋 查看菜單</a>
  <a href="login/logout">🚪 登出</a>
</div>

<div class="container">
  <h1>🍽️ 餐廳線上訂位</h1>
  <form:form modelAttribute="reservation" action="${pageContext.request.contextPath}/reservation/make" method="post" autocomplete="off">
    <div class="form-group">
      <label for="people">👥 用餐人數:</label>
      <form:select path="people" id="people" required="true">
        <form:option value="" label="請選擇" />
        <form:option value="1" label="1位" />
        <form:option value="2" label="2位" />
        <form:option value="3" label="3位" />
        <form:option value="4" label="4位" />
        <form:option value="5" label="5位" />
        <form:option value="6" label="6位" />
      </form:select>
      <div class="notes">備註：七位(含)以上的客人請打電話預約，謝謝🙏。</div>
    </div>

    <div class="form-group">
      <label for="datepicker">📅 可預約日期:</label>
      <form:input path="date" id="datepicker" placeholder="請點選選擇日期" readonly="true" required="true"/>
    </div>

    <div class="form-group">
      <label for="timeId">⏰ 可選擇時段:</label>
      <form:select path="timeSlots.timeId" id="timeId" required="true">
        <form:option value="" label="請選擇時段" />
        <form:option value="1" label="10:00 - 11:30" />
        <form:option value="2" label="12:00 - 13:30" />
        <form:option value="3" label="14:00 - 15:30" />
        <form:option value="4" label="16:00 - 17:30" />
        <form:option value="5" label="18:00 - 19:30" />
      </form:select>
    </div>

    <div class="form-group">
      <label for="name">📝 預約人姓名:</label>
      <form:input path="name" id="name" placeholder="請填寫真實名稱" required="true"/>
    </div>

    <div class="form-group">
      <label for="phone">📞 預約人電話:</label>
      <form:input path="phone" id="phone" placeholder="請填寫聯絡電話" required="true"/>
    </div>

    <div class="form-group">
      <label for="email">📧 預約人郵件:</label>
      <form:input path="email" id="email" placeholder="請填寫電子郵件" required="true"/>
    </div>

    <div class="form-group">
      <label for="message">📝 特殊需求:</label>
      <form:textarea path="message" id="message" rows="4" placeholder="例如：慶生、過敏資訊、指定座位區等"/>
    </div>

    <c:if test="${not empty errorMsg}">
      <script>
        alert("❗ ${errorMsg}");
      </script>
    </c:if>

    <button type="submit" class="submit-button">✅ 送出訂位</button>
  </form:form>

  <div class="notice">
    <h2>🛎️ 用餐注意事項</h2>
    <ul>
      <li>⏰ 預約保留 10 分鐘，逾時將取消訂位。</li>
      <li>⏳ 為確保用餐品質，請準時抵達。</li>
      <li>📞 若需更改或取消訂位，請提前一天通知。</li>
      <li>🍾 自備酒水將酌收開瓶費。</li>
      <li>📝 如有其他特殊需求，請於備註欄位填寫或來電洽詢。</li>
    </ul>
  </div>
</div>

<div class="footer">
  <p>🏠 餐廳地址：台北市大安區咖啡街123號</p>
  <p>☎️ 連絡電話：(02)2345-6789</p>
</div>

</body>
</html>
