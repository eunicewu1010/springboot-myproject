<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 

<!-- 客服機器人圖示 -->
<div id="chatbot-icon" 
     style="position:fixed; bottom:20px; right:20px; width:55px; height:55px; 
            border-radius:50%; background:linear-gradient(135deg,#8B4513,#D4A574); 
            color:white; display:flex; align-items:center; justify-content:center; 
            cursor:pointer; font-size:28px; box-shadow:0 4px 10px rgba(0,0,0,0.3); 
            transition: transform 0.2s;">
    🤖
</div>

<!-- 聊天視窗 -->
<div id="chatbot-window" 
     style="position:fixed; bottom:85px; right:20px; width:250px; height:280px; 
            background:linear-gradient(145deg,#D4A574,#8B4513); 
            border-radius:15px; display:none; flex-direction:column; 
            box-shadow:0 6px 18px rgba(0,0,0,0.25); overflow:hidden;">

    <div style="background:#8B4513; color:white; padding:10px; font-weight:bold; 
                border-radius:15px 15px 0 0; text-align:center;">
        客服小幫手 ☕
    </div>

    <!-- 訊息區 -->
    <div id="chat-messages" style="flex:1; padding:8px; overflow-y:auto; 
                                   font-size:13px; scroll-behavior:smooth;
                                   display:flex; flex-direction:column;">
    </div>

    <div style="display:flex; border-top:1px solid #D4A574; padding:5px; background:#F5E0C3;">
        <input id="chat-input" type="text" placeholder="輸入訊息..." 
               style="flex:1; border:none; padding:6px 8px; border-radius:8px; 
                      font-size:13px; outline:none;" 
               onkeydown="if(event.key==='Enter'){sendMessage()}"/>
        <button onclick="sendMessage()" 
                style="margin-left:5px; background:#8B4513; color:white; border:none; 
                       border-radius:8px; padding:6px 10px; cursor:pointer; 
                       transition: background 0.2s;">
            送出
        </button>
    </div>
</div>

<style>
    /* 機器人按鈕 hover 動效 */
    #chatbot-icon:hover {
        transform: scale(1.1);
    }

    /* 送出按鈕 hover 動效 */
    #chatbot-window button:hover {
        background:#D4A574;
        color:#8B4513;
    }

    /* 使用者訊息樣式 */
    #chat-messages .msg.user {
        display: inline-block;
        max-width: 80%;
        word-wrap: break-word;
        background:#F5E0C3;
        color:#4B2E1E;
        text-align:right;
        padding:5px 8px;
        border-radius:10px 10px 2px 10px;
        margin:3px 0;
        animation: fadeIn 0.3s ease;
        align-self:flex-end;
    }

    /* 機器人訊息樣式 */
    #chat-messages .msg.bot {
        display: inline-block;
        max-width: 80%;
        word-wrap: break-word;
        background:#8B4513;
        color:white;
        text-align:left;
        padding:5px 8px;
        border-radius:10px 10px 10px 2px;
        margin:3px 0;
        animation: fadeIn 0.3s ease;
        align-self:flex-start;
    }

    @keyframes fadeIn {
        from {opacity:0; transform:translateY(5px);}
        to {opacity:1; transform:translateY(0);}
    }

    /* ☕ 打字中動畫 */
    .typing {
        display: inline-flex;
        align-items: center;
        padding: 5px 8px;
        background: #8B4513;
        color: white;
        border-radius: 10px 10px 10px 2px;
        margin: 3px 0;
        align-self: flex-start;
        font-size: 14px;
    }

    .steam {
        font-size: 10px;
        margin-left: 4px;
        animation: steamUp 1.5s infinite;
        opacity: 0.7;
    }

    @keyframes steamUp {
        0% { transform: translateY(5px); opacity: 0.2; }
        50% { transform: translateY(-2px); opacity: 1; }
        100% { transform: translateY(-6px); opacity: 0; }
    }
</style>

<script>
    const chatbotIcon = document.getElementById("chatbot-icon");
    const chatbotWindow = document.getElementById("chatbot-window");
    const messagesDiv = document.getElementById("chat-messages");
    const chatInput = document.getElementById("chat-input");

    // 開關聊天視窗
    chatbotIcon.addEventListener("click", () => {
        chatbotWindow.style.display = chatbotWindow.style.display === "none" ? "flex" : "none";
    });

    // 顯示訊息
    function appendMessage(text, sender, typingEffect = false) {
        const div = document.createElement("div");
        div.classList.add("msg", sender);

        if (typingEffect) {
            let i = 0;
            const interval = setInterval(() => {
                div.textContent = text.substring(0, i++);
                messagesDiv.scrollTop = messagesDiv.scrollHeight;
                if (i > text.length) clearInterval(interval);
            }, 40); // 打字機速度
        } else {
            div.textContent = text;
        }

        messagesDiv.appendChild(div);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    // 顯示咖啡杯冒煙動畫
    function showTyping() {
        const typingDiv = document.createElement("div");
        typingDiv.classList.add("typing");
        typingDiv.id = "typing-indicator";
        typingDiv.innerHTML = "☕ <span class='steam'>~</span><span class='steam'>~</span><span class='steam'>~</span>";
        messagesDiv.appendChild(typingDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    // 移除動畫
    function hideTyping() {
        const typingDiv = document.getElementById("typing-indicator");
        if (typingDiv) typingDiv.remove();
    }

    // 送出訊息
    async function sendMessage() {
        const msg = chatInput.value.trim();
        if (!msg) return;

        appendMessage(msg, "user");
        chatInput.value = "";

        // 顯示動畫
        showTyping();

        try {
            const res = await fetch("/chatbot/ask", {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify({ message: msg })
            });

            let data;
            const contentType = res.headers.get("content-type") || "";
            if (contentType.includes("application/json")) {
                data = await res.json();
            } else {
                const text = await res.text();
                data = { reply: text };
            }

            hideTyping();

            if (!res.ok) {
                appendMessage("❌ 後端錯誤：" + (data.reply || res.statusText), "bot");
                console.error("Backend error:", res.status, data);
            } else {
                appendMessage(data.reply || "⚠️ 無回覆內容", "bot", true);
            }
        } catch (err) {
            hideTyping();
            console.error("Fetch error:", err);
            appendMessage("❌ 系統錯誤，請稍後再試", "bot");
        }
    }
</script>
