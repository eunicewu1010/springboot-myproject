<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8" />
    <title>菜單頁面</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
            background: #fafafa;
        }
        h2 {
            color: #5a4635;
            margin-bottom: 20px;
        }
        .upload-section {
            background: #fffbe6;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .image-gallery {
            display: flex;
            flex-direction: column;
            gap: 40px;
        }
        .image-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }
        .image-card img {
            width: auto;
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .image-card form {
            margin-top: 8px;
        }
        .message {
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 8px;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
        }
        button {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            border: none;
            background-color: #e0705e;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #c45140;
        }
        input[type="file"] {
            margin-right: 10px;
        }
    </style>
</head>
<body>

<c:if test="${not empty message}">
    <div class="message ${message.contains('成功') ? 'success' : 'error'}">
        ${message}
    </div>
</c:if>

<!-- 上傳表單（僅 admin 可見） -->
<c:if test="${role == 'admin'}">
    <div class="upload-section">
        <form method="post" action="${pageContext.request.contextPath}/uploadmenu" enctype="multipart/form-data">
            <label for="imageFile">選擇圖片上傳：</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/*" required>
            <button type="submit">📤 上傳</button>
        </form>
    </div>
</c:if>

<!-- 圖片展示區（原圖） -->
<div class="image-gallery">
    <c:choose>
        <c:when test="${not empty images}">
            <c:forEach var="img" items="${images}">
                <div class="image-card">
                    <img src="${pageContext.request.contextPath}/images/uploads/${img}" alt="圖片">
                    
                    <!-- 只有 admin 才能刪除 -->
                    <c:if test="${role == 'admin'}">
                        <form method="post" action="${pageContext.request.contextPath}/deleteImage" onsubmit="return confirm('確定要刪除這張圖片嗎？')">
                            <input type="hidden" name="filename" value="${img}">
                            <button type="submit">🗑️ 刪除</button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>目前沒有圖片可以顯示。</p>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
