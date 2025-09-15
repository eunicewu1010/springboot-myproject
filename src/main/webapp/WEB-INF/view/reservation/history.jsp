<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8" />
    <title>${username} 的歷史訂位紀錄</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        :root {
            --main-dark: #8B4513;
            --main-light: #D4A574;
            --bg-color: #FFF9F3;
            --text-dark: #3E2F1C;
            --text-light: #6B4F3A;
        }

        body {
            font-family: "微軟正黑體", sans-serif;
            background-color: var(--bg-color);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            background: #fff;
            width: 95%;
            max-width: 960px;
            margin: 40px auto;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(139, 69, 19, 0.1);
        }

        h2 {
            text-align: center;
            color: var(--main-dark);
            font-size: 1.6rem;
            margin-bottom: 1rem;
        }

        p {
            text-align: center;
            margin-bottom: 1rem;
            color: var(--text-light);
        }

        .alert-info {
            background-color: #fff3e5;
            border-left: 5px solid var(--main-light);
            padding: 12px 16px;
            border-radius: 6px;
            color: var(--main-dark);
            text-align: center;
            font-weight: 500;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        thead {
            background-color: var(--main-dark);
            color: white;
        }

        thead th {
            padding: 12px;
            text-align: left;
        }

        tbody tr {
            background-color: #fffaf2;
            border-bottom: 1px solid #e3d1b6;
        }

        tbody tr:hover {
            background-color: #f9f0e4;
        }

        tbody td {
            padding: 12px;
            vertical-align: middle;
        }

        .btn-danger {
            background-color: var(--main-dark);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .btn-danger:hover {
            background-color: #6f3510;
        }

        .btn-secondary {
            display: inline-block;
            background-color: var(--main-light);
            color: var(--text-dark);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            margin-top: 30px;
            text-align: center;
            transition: background-color 0.3s;
        }

        .btn-secondary:hover {
            background-color: #b9884d;
            color: white;
        }

        .text-muted {
            color: #aaa;
            font-style: italic;
            font-size: 0.9rem;
        }

        footer {
            background-color: #f5f0ea;
            color: #6b4f3a;
            font-size: 0.8rem;
            text-align: center;
            padding: 12px 0;
            border-top: 1px solid #e0d1c0;
            margin-top: auto;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            table, th, td {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📅 ${username} 的歷史訂位紀錄</h2>
    <p>共 <strong>${fn:length(reservations)}</strong> 筆訂位資料</p>
    <p style="color: var(--main-dark); font-size: 0.95rem; font-weight: 500;">
        ※ 最晚請在前一天晚上 11:59 前取消訂位，當天取消請來電 📞
    </p>

    <c:if test="${empty reservations}">
        <div class="alert-info">您尚無任何訂位紀錄。</div>
    </c:if>

    <c:if test="${not empty reservations}">
        <table role="table">
            <thead>
                <tr>
                    <th>日期</th>
                    <th>時段</th>
                    <th>備註</th>
                    <th style="width:120px;">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${reservations}">
                    <tr>
                        <td>${r.date}</td>
                        <td>${r.timeSlots.timeSlot}</td>
                        <td>${r.message != null && !r.message.isEmpty() ? r.message : "無"}</td>
                        <td>
                           <c:choose>
							    <c:when test="${r.date >= tomorrow}">
							        <form method="post" action="${pageContext.request.contextPath}/reservation/delete/${r.reservationId}" 
							              onsubmit="return confirm('❗️確定要取消這筆訂位紀錄嗎？');">
							            <button type="submit" class="btn-danger">🗑 取消訂位</button>
							        </form>
							    </c:when>
							    <c:otherwise>
							        <span class="text-muted">不可取消</span>
							    </c:otherwise>
							</c:choose>
                           
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div style="text-align: center;">
        <a href="${pageContext.request.contextPath}/userpage" class="btn-secondary">🏠 回使用者頁</a>
    </div>
</div>

<footer>
    🏠 台北市大安區咖啡街123號 ｜📞 (02)2345-6789｜📧 meowmeowcafe@gmail.com
</footer>

</body>
</html>
