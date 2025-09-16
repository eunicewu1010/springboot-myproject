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
     style="position:fixed; bottom:85px; right:20px; width:250px; height:300px; 
            background:linear-gradient(145deg,#D4A574,#8B4513); 
            border-radius:15px; display:none; flex-direction:column; 
            box-shadow:0 6px 18px rgba(0,0,0,0.25); overflow:hidden;">

    <div style="background:#8B4513; color:white; padding:10px; font-weight:bold; 
                border-radius:15px 15px 0 0; text-align:center;">
        客服小幫手 ☕
    </div>

    <!-- 訊息區改用 flex 方式排列，讓左右對齊生效 -->
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

    /* 使用者訊息樣式：靠右、根據字數調整寬度 */
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
        align-self:flex-end;   /* 讓使用者訊息靠右 */
    }

    /* 機器人訊息樣式：靠左、根據字數調整寬度 */
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
        align-self:flex-start; /* 讓機器人訊息靠左 */
    }

    @keyframes fadeIn {
        from {opacity:0; transform:translateY(5px);}
        to {opacity:1; transform:translateY(0);}
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

    // 載入 localStorage 聊天紀錄
    function loadHistory() {
        const history = JSON.parse(localStorage.getItem("chatHistory") || "[]");
        messagesDiv.innerHTML = "";
        history.forEach(msg => {
            appendMessage(msg.text, msg.sender);
        });
    }

    // 儲存訊息
    function saveMessage(text, sender) {
        const history = JSON.parse(localStorage.getItem("chatHistory") || "[]");
        history.push({text, sender});
        localStorage.setItem("chatHistory", JSON.stringify(history));
    }

    // 顯示訊息並對齊
    function appendMessage(text, sender) {
        const div = document.createElement("div");
        div.classList.add("msg", sender);
        div.textContent = text;
        messagesDiv.appendChild(div);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    // 送出訊息
    async function sendMessage() {
        const msg = chatInput.value.trim();
        if(!msg) return;

        appendMessage(msg, "user");
        saveMessage(msg, "user");
        chatInput.value = "";

        try {
            const response = await fetch("/chatbot/ask", {
                method: "POST",
                headers: {"Content-Type":"application/json"},
                body: JSON.stringify({message: msg})
            });

            const data = await response.json();
            appendMessage(data.reply, "bot");
            saveMessage(data.reply, "bot");
        } catch(err) {
            appendMessage("❌ 系統錯誤，請稍後再試", "bot");
        }
    }

    window.onload = loadHistory;
</script>
