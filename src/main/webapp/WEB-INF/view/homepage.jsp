<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>喵喵貓咖 - 與貓咪共度美好時光</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #fef8f0;
        }

        /* Navigation Bar */
        .navbar {
            background: linear-gradient(135deg, #8B4513, #D4A574);
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .nav-buttons {
            display: flex;
            gap: 1rem;
        }

        .nav-btn {
            background: rgba(255,255,255,0.9);
            color: #8B4513;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .nav-btn:hover {
            background: #fff;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(139,69,19,0.1), rgba(212,165,116,0.1)), 
                        url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 600"><rect fill="%23f5e6d3" width="1000" height="600"/><circle fill="%23e6d2b7" cx="200" cy="150" r="80"/><circle fill="%23d4a574" cx="800" cy="100" r="60"/><path fill="%23c99660" d="M0,300 Q250,200 500,300 T1000,300 V600 H0 Z"/></svg>');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding-top: 80px;
        }

        .hero-content h1 {
            font-size: 3.5rem;
            color: #8B4513;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .hero-content p {
            font-size: 1.3rem;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }

        /* About Section */
        .about {
            padding: 5rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .about h2 {
            font-size: 2.5rem;
            color: #8B4513;
            margin-bottom: 2rem;
            position: relative;
        }

        .about h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(135deg, #8B4513, #D4A574);
            border-radius: 2px;
        }

        .about-text {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255,255,255,0.8);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        /* Cat Gallery */
        .cat-gallery {
            padding: 5rem 2rem;
            background: linear-gradient(135deg, #fef8f0, #f5e6d3);
        }

        .gallery-container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .gallery-container h2 {
            font-size: 2.5rem;
            color: #8B4513;
            margin-bottom: 3rem;
        }

        .cat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .cat-card {
            background: #fff;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .cat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        .cat-placeholder {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #D4A574, #e6d2b7);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .cat-photo {
		    width: 100%;
		    height: 200px;
		    object-fit: cover;
		    border-radius: 15px;
		    margin-bottom: 1rem;
		}
        

        .cat-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #8B4513;
            margin-bottom: 0.5rem;
        }

        .cat-description {
            color: #666;
            font-size: 0.9rem;
        }

        /* Reservation Section */
       .reservation {
		    padding: 5rem 2rem;
		    text-align: center;
		    background: linear-gradient(rgba(255,255,255,0.8), rgba(255,255,255,0.8)),
		                url('images/reservation-bg.png'); /* 可替換成你自己的圖片路徑 */
		    background-size: cover;
		    background-position: center;
		    background-repeat: no-repeat;
		    
		}


        .reservation-btn {
            background: linear-gradient(135deg, #8B4513, #D4A574);
            color: white;
            border: none;
            padding: 1.5rem 3rem;
            font-size: 1.3rem;
            font-weight: 600;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(139,69,19,0.3);
        }

        .reservation-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(139,69,19,0.4);
        }

        /* Menu Section */
        .menu {
            padding: 5rem 2rem;
            background: #fff;
        }

        .menu-container {
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .menu h2 {
            font-size: 2.5rem;
            color: #8B4513;
            margin-bottom: 3rem;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .menu-category {
            background: linear-gradient(135deg, #fef8f0, #f5e6d3);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .menu-category h3 {
            font-size: 1.5rem;
            color: #8B4513;
            margin-bottom: 1.5rem;
        }

        .menu-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.5rem 0;
            border-bottom: 1px dotted #D4A574;
        }

        .menu-item:last-child {
            border-bottom: none;
        }

        .item-name {
            font-weight: 600;
            color: #333;
        }

        .item-price {
            color: #8B4513;
            font-weight: 600;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #8B4513, #D4A574);
            color: white;
            padding: 3rem 2rem 2rem;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .footer-section h3 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            color: #fff;
        }

        .footer-section p {
            margin-bottom: 0.5rem;
            color: rgba(255,255,255,0.9);
        }

        .footer-bottom {
            text-align: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.3);
            color: rgba(255,255,255,0.8);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 2.5rem;
            }
            
            .nav-container {
                padding: 0 1rem;
            }
            
            .logo {
                font-size: 1.5rem;
            }
            
            .nav-buttons {
                gap: 0.5rem;
            }
            
            .nav-btn {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }
        }
        
        
        
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
		<div class="nav-container">
		<div class="logo">🐱 喵喵貓咖</div>
	    <div class="nav-buttons">
	    <c:choose>
	        <c:when test="${userCert == null}">
	            <p style="color:white;">尚未登入</p>
	            <button class="nav-btn" onclick="register()">註冊</button>
	            <button class="nav-btn" onclick="login()">登入</button>
	        </c:when>
	        
	        <c:otherwise>
	            <p style="color:white;">您好，${userCert.username}</p>
	            
	            <c:if test="${userDto.role == 'USER'}">
	                <button class="nav-btn" onclick="memberCenter()">會員中心</button>
	                <button class="nav-btn" onclick="makeReservation()">訂位</button>
	            </c:if>
	
	            <c:if test="${userDto.role == 'ADMIN'}">
	                <button class="nav-btn" onclick="adminPanel()">後台管理</button>
	                <button class="nav-btn" onclick="manageReservations()">訂位管理</button>
	            </c:if>
				<button class="nav-btn" onclick="userpage()">使用者頁面</button>
	            <button class="nav-btn" onclick="logout()">登出</button>
	        </c:otherwise>
	    </c:choose>
	</div>
	</div>
	</nav>
    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>歡迎來到喵喵貓咖</h1>
            <p>在溫馨的環境中，與可愛的貓咪們共度美好時光，享受香醇咖啡與療癒陪伴</p>
        </div>
    </section>

    <!-- About Section -->
    <section class="about">
        <h2>關於我們</h2>
        <div class="about-text">
            <p>喵喵貓咖是一個充滿溫暖與愛的地方，我們致力於為貓咪提供一個安全舒適的家，同時讓愛貓人士能夠在這裡放鬆身心。我們的每一隻貓咪都經過悉心照料，性格溫順親人，歡迎來跟貓貓玩，貓貓也都很歡迎大家唷~</p>
            <br>
            <p>在這裡，您可以一邊品嚐精心調製的咖啡和美味點心，一邊與貓咪互動玩耍。我們相信，貓咪的陪伴能夠帶給人們內心的平靜與快樂，讓繁忙的生活節奏得到舒緩。</p>
            <br>
            <p>我們也積極參與貓咪救助活動，店內的部分貓咪正在尋找永遠的家。如果您在這裡遇到了心動的小夥伴，歡迎考慮領養，給牠們一個溫暖的家。</p>
        </div>
    </section>

    <!-- Cat Gallery -->
    <section class="cat-gallery">
        <div class="gallery-container">
            <h2>我們的貓咪家族</h2>
            <div class="cat-grid">
				<div class="cat-card">
                <img src="images/orangecat.png" alt="小橘" class="cat-photo" />
                <div class="cat-name">小橘</div>
                <div class="cat-description">活潑好動的橘貓，最愛玩逗貓棒</div>
            	</div>

                <div class="cat-card">
                <img src="images/whitecat.png" alt="雪球" class="cat-photo" />
                <div class="cat-name">雪球</div>
                <div class="cat-description">溫柔的白色長毛貓，喜歡默默地觀察大家</div>
                </div>
                <div class="cat-card">
                <img src="images/blackcat.png" alt="歐嚕嚕" class="cat-photo" />
                <div class="cat-name">歐嚕嚕</div>
                <div class="cat-description">神秘的黑貓，聰明伶俐，愛躲在奇怪地方</div>
                </div>
                <div class="cat-card">
                <img src="images/calicocat.png" alt="花花" class="cat-photo" />
                    <div class="cat-name">花花</div>
                    <div class="cat-description">美麗的三花貓，性格獨立但很親人</div>
                </div>
                <div class="cat-card">
                <img src="images/tabbycat.png" alt="小寶" class="cat-photo" />
                    <div class="cat-name">小寶</div>
                    <div class="cat-description">嬌小的虎斑貓，最愛撒嬌求摸摸</div>
                </div>
                <div class="cat-card">
                <img src="images/graycat.png" alt="哼哼" class="cat-photo" />
                    <div class="cat-name">哼哼</div>
                    <div class="cat-description">沉穩的英短貓，溫和、安靜討人喜歡</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Reservation Section -->
    <section class="reservation">
        <h2 style="font-size: 2.5rem; color: #8B4513; margin-bottom: 2rem;">現在就來預約吧！</h2>
        <p style="font-size: 1.1rem; color: #666; margin-bottom: 2rem;">點擊下方按鈕開始預約，與可愛的貓咪們度過美好時光</p>
        <button class="reservation-btn" onclick="makeReservation()">🐾 開始訂位</button>
    </section>

    <!-- Menu Section -->
    <section class="menu">
        <div class="menu-container">
            <h2>精選菜單</h2>
            <div class="menu-grid">
                <div class="menu-category">
                    <h3>☕ 精品咖啡</h3>
                    <div class="menu-item">
                        <span class="item-name">美式咖啡</span>
                        <span class="item-price">NT$ 120</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">拿鐵咖啡</span>
                        <span class="item-price">NT$ 150</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">卡布奇諾</span>
                        <span class="item-price">NT$ 140</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">貓爪拉花特調</span>
                        <span class="item-price">NT$ 180</span>
                    </div>
                </div>
                
                <div class="menu-category">
                    <h3>🫖 特色茶飲</h3>
                    <div class="menu-item">
                        <span class="item-name">招牌奶茶</span>
                        <span class="item-price">NT$ 110</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">蘋果冰茶</span>
                        <span class="item-price">NT$ 130</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">花草茶</span>
                        <span class="item-price">NT$ 100</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">貓薄荷特調</span>
                        <span class="item-price">NT$ 160</span>
                    </div>
                </div>

                <div class="menu-category">
                    <h3>🥯 早午餐套餐</h3>
                    <div class="menu-item">
                        <span class="item-name">歐嗨唷早餐盤</span>
                        <span class="item-price">NT$ 260</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">貓掌鬆餅餐盤</span>
                        <span class="item-price">NT$ 240</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">水果沙拉法式吐司</span>
                        <span class="item-price">NT$ 180</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">鮭魚酪梨貝果</span>
                        <span class="item-price">NT$ 250</span>
                    </div>
                </div>
                
                <div class="menu-category">
                    <h3>🍝 麵飯主食</h3>
                    <div class="menu-item">
                        <span class="item-name">喵皇咖哩豬排飯</span>
                        <span class="item-price">NT$ 230</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">肉丸起司焗烤飯</span>
                        <span class="item-price">NT$ 240</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">貓耳朵肉醬義大利麵</span>
                        <span class="item-price">NT$ 220</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">奶油白醬鮮蝦筆管麵</span>
                        <span class="item-price">NT$ 260</span>
                    </div>
                </div>
                
                <div class="menu-category">
                    <h3>🧁 美味點心</h3>
                    <div class="menu-item">
                        <span class="item-name">貓爪造型馬卡龍</span>
                        <span class="item-price">NT$ 90</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">黑白貓起司蛋糕</span>
                        <span class="item-price">NT$ 120</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">鮮奶油布丁</span>
                        <span class="item-price">NT$ 80</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">貓咪造型餅乾</span>
                        <span class="item-price">NT$ 60</span>
                    </div>
                </div>

                <div class="menu-category">
                    <h3>🍟 加購小點</h3>
                    <div class="menu-item">
                        <span class="item-name">雙色地瓜球</span>
                        <span class="item-price">NT$ 80</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">日式薯條</span>
                        <span class="item-price">NT$ 130</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">辣味雞翅</span>
                        <span class="item-price">NT$ 150</span>
                    </div>
                    <div class="menu-item">
                        <span class="item-name">脆皮起司條</span>
                        <span class="item-price">NT$ 80</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-section">
                <h3>📞 聯絡電話</h3>
                <p>(02) 2345-6789</p>
                <p>營業時間：10:00 - 20:00</p>
            </div>
            <div class="footer-section">
                <h3>✉️ 電子信箱</h3>
                <p>meowmeowcafe@gmail.com</p>
            </div>
            <div class="footer-section">
                <h3>📍 店面地址</h3>
                <p>台北市大安區咖啡街123號</p>
                <p>捷運大安站2號出口站步行5分鐘</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 喵喵貓咖 All Rights Reserved. | 與貓咪一起創造美好回憶 🐾</p>
        </div>
     <jsp:include page="/WEB-INF/view/chatbot.jsp"/>
        
        
    </footer>

    <script>
    
	    function register() {
	        window.location.href = '/register';
	    }
	    function login() {
	        window.location.href = '/login';
	    }
	    function logout() {
	        window.location.href = '/login/logout';
	    }
	    function userpage() {
	        window.location.href = '/userpage';
	    }
	    function adminPanel() {
	        window.location.href = '/admin';
	    }
	    function makeReservation() {
	        window.location.href = '/reservation';
	    }

        // 平滑滾動效果
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // 滾動時導航欄效果
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 100) {
                navbar.style.background = 'linear-gradient(135deg, rgba(139,69,19,0.95), rgba(212,165,116,0.95))';
                navbar.style.backdropFilter = 'blur(10px)';
            } else {
                navbar.style.background = 'linear-gradient(135deg, #8B4513, #D4A574)';
                navbar.style.backdropFilter = 'none';
            }
        });

        // 卡片hover動畫增強
        document.querySelectorAll('.cat-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-15px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
    </script>
    
    
</body>
</html>