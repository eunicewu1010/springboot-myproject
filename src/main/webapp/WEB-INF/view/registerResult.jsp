<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>註冊結果 ✨</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom right, #D4A574, #fff3e6);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            scroll-behavior: smooth;
        }

        .container {
            background-color: #fffaf5;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(139, 69, 19, 0.2);
            text-align: center;
            max-width: 90%;
            width: 400px;
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        h1 {
            color: #8B4513;
            font-size: 1.8em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5em;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 24px;
            background-color: #8B4513;
            color: white;
            text-decoration: none;
            border-radius: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.2s;
            font-size: 1em;
        }

        .back-link:hover {
            background-color: #A0522D;
            transform: scale(1.05);
        }

        @media (max-width: 500px) {
            .container {
                width: 90%;
                padding: 20px;
            }

            h1 {
                font-size: 1.5em;
            }

            .back-link {
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <c:choose>
            <c:when test="${not empty resultMessage}">
                <h1>
                    <c:choose>
                        <c:when test="${fn:contains(resultMessage, '失敗') or fn:contains(resultMessage, '錯誤')}">
                            ❌
                        </c:when>
                        <c:otherwise>
                            🎉
                        </c:otherwise>
                    </c:choose>
                    ${resultMessage}
                </h1>
            </c:when>
            <c:otherwise>
                <h1>❓ 沒有收到任何結果訊息</h1>
            </c:otherwise>
        </c:choose>

        <a href="homepage" class="back-link">🏠 返回首頁或註冊頁</a>
    </div>
</body>
</html>
