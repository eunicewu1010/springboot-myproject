<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>預約成功 🎉</title>
<style>
  /* 全局字體及背景漸層 */
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0; padding: 0;
    background: linear-gradient(135deg, #D4A574 0%, #8B4513 100%);
    color: #3E2F1C;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    scroll-behavior: smooth;
  }

  /* 導覽列 */
  .navbar {
    background: rgba(139,69,19, 0.85);
    width: 100%;
    display: flex;
    justify-content: center;
    gap: 2rem;
    padding: 1rem 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    position: sticky;
    top: 0;
    z-index: 100;
  }
  .navbar a {
    color: #E3D5B8; /* 顏色淡一點的米咖啡色 */
    text-decoration: none;
    font-weight: 600;
    padding: 0.5rem 1.5rem;
    border-radius: 25px;
    background-color: rgba(211, 165, 116, 0.3); /* 淡淡的背景色 */
    box-shadow: 0 2px 5px rgba(0,0,0,0.15);
    transition: background-color 0.3s ease, transform 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    font-size: 1rem;
    user-select: none;
  }
  .navbar a:hover {
    background-color: rgba(211, 165, 116, 0.5);
    color: #6F4E37; /* 深咖啡色 */
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(211,165,116,0.5);
  }

  /* 內容容器 */
  .container {
    background: #FDF6E3;
    max-width: 600px;
    width: 90%;
    margin: 4rem auto 2rem;
    padding: 3rem 2rem;
    border-radius: 20px;
    box-shadow:
      0 10px 20px rgba(139,69,19,0.2),
      0 6px 6px rgba(211,165,116,0.4);
    text-align: center;
    animation: fadeInUp 1s ease forwards;
  }

  h1 {
    font-size: 2.8rem;
    margin-bottom: 1rem;
    color: #8B4513;
    text-shadow: 1px 1px 3px #D4A574;
  }

  p {
    font-size: 1.2rem;
    margin: 0.6rem 0;
    line-height: 1.5;
  }

  /* 主要按鈕 */
  .button {
    margin-top: 2rem;
    background: linear-gradient(45deg, #8B4513, #D4A574);
    color: #FFF8E7;
    font-weight: 700;
    font-size: 1.1rem;
    padding: 0.75rem 2rem;
    border: none;
    border-radius: 30px;
    box-shadow: 0 6px 12px rgba(211,165,116,0.7);
    cursor: pointer;
    transition: background 0.4s ease, transform 0.3s ease;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    user-select: none;
  }
  .button:hover {
    background: linear-gradient(45deg, #D4A574, #8B4513);
    transform: translateY(-3px);
    box-shadow: 0 10px 20px rgba(211,165,116,0.9);
  }

  /* 頁尾 */
  .footer {
    width: 100%;
    background: rgba(139,69,19, 0.9);
    color: #F3E5D3;
    text-align: center;
    padding: 1.5rem 1rem;
    font-size: 0.95rem;
    box-shadow: inset 0 1px 5px rgba(255, 255, 255, 0.1);
    margin-top: auto;
  }

  /* 響應式調整 */
  @media (max-width: 480px) {
    .navbar {
      flex-direction: column;
      gap: 1rem;
      padding: 1rem 0.5rem;
    }
    .navbar a {
      font-size: 0.9rem;
      padding: 0.5rem 1rem;
    }
    .container {
      padding: 2rem 1rem;
    }
    h1 {
      font-size: 2.2rem;
    }
    p {
      font-size: 1rem;
    }
  }

  /* 動畫效果 */
  @keyframes fadeInUp {
    0% {
      opacity: 0;
      transform: translateY(40px);
    }
    100% {
      opacity: 1;
      transform: translateY(0);
    }
  }
</style>
<script>
  // 點擊返回首頁按鈕時添加平滑滾動到頂部
  document.addEventListener('DOMContentLoaded', () => {
    const btn = document.querySelector('.button');
    if (btn) {
      btn.addEventListener('click', e => {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
        setTimeout(() => {
          window.location.href = btn.href;
        }, 400);
      });
    }
  });
</script>
</head>
<body>
  <nav class="navbar" aria-label="主要導覽">
    <a href="${pageContext.request.contextPath}/reservation">➕ 再訂一筆</a>
    <a href="${pageContext.request.contextPath}/reservation/history">📜 訂位資料</a>
    <a href="${pageContext.request.contextPath}/uploadmenu">🍽️ 查看菜單</a>
  </nav>

  <main class="container" role="main" aria-labelledby="mainTitle">
    <h1 id="mainTitle">預約成功！🎉</h1>
    <p>感謝您的預約，我們已收到您的訂位資訊 📝。</p>
    <p>請留意手機與電子郵件通知 📱📧。</p>
    <p>期待您的光臨，祝您用餐愉快！🍽️</p>
    <a href="${pageContext.request.contextPath}/homepage" class="button" role="button" aria-label="返回首頁">🏠 返回首頁</a>
  </main>

  <footer class="footer" role="contentinfo">
    <p>🏠 餐廳地址：台北市大安區忠孝東路四段 123 號</p>
    <p>📞 連絡電話：(02) 1234-5678</p>
  </footer>
</body>
</html>
