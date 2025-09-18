package com.example.demo.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/chatbot")
public class ChatbotController {

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper mapper = new ObjectMapper();

    @PostMapping("/ask")
    public ResponseEntity<Map<String, String>> ask(@RequestBody Map<String, String> payload) {
        String userMessage = payload.getOrDefault("message", "");

        // ✅ 系統提示，強制 Ollama 輸出繁體中文
        String finalPrompt =
        		"請你無論收到什麼訊息，不要用英文，一定要用繁體中文回答(很重要)，不要用英文或是其他語言。\n" +
        		"你是一間名叫【喵喵貓咪咖啡館】的客服助理，你的名字是阿咪，以下是店內資訊：\n" +
        		"如果使用者問到無關問題，請溫柔幽默禮貌地帶回咖啡館主題。\n" +
        		"回覆盡量簡短但精要，回覆文字在50字內。\n" +
        	    "- 營業時間：週一至週日 10:00–20:00\n" +
        	    "- 招牌、推薦飲品飲料：招牌奶茶、貓爪拉花特調、貓薄荷特調\n" +
        	    "- 招牌、推薦餐點：歐嗨唷早餐盤、喵皇咖哩豬排飯、黑白貓起司蛋糕、日式薯條\n" +
        	    "- 店址：台北市大安區咖啡街123號\n"+
        	    "- 菜單：請以官網圖片為主\n"+
        	    "- 包場、場地租借：請以打電話洽詢或用郵件詢問\n"+
        	    "- 提供幾個人的座位:提供2-6人的座位，6人以上請來電洽詢\n"+
        	    "- 詢問餐點、飲品配方:用幸福跟愛製作而成\n"+
        	    "- 店裡有幾隻、那些貓:六隻可愛的貓貓，分別是小橘、雪球、歐嚕嚕、花花、小寶、哼哼\n"+
        	    "- 電話聯絡方式:(02) 2345-6789\r\n"+
        	    "- email郵件聯絡方式:meowmeowcafe@gmail.com\r\n"+ 
        	    "- 忘記網頁密碼怎麼辦:請在登入頁面點選忘記密碼的按鈕\n" +
        	    "- 是否提供 WiFi：是，免費使用\n" +

        	    "- 是否可以帶寵物：不行哦~ 店內貓咪較怕生\n" +
        	    "請根據以上資訊用繁體中文回答使用者的問題，不要用英文不要用英文不要用英文不要用英文不要用英文不要用英文。\n" +
        	    "使用者訊息：" + userMessage;

        String url = "http://localhost:11434/api/generate"; // Ollama API

        // 組 request body，確保 stream = false
        Map<String, Object> req = new HashMap<>();
        req.put("model", "llama3");   // 確認這是你有的模型名稱
        req.put("prompt", finalPrompt);
        req.put("stream", false);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(req, headers);

        try {
            ResponseEntity<String> resp = restTemplate.postForEntity(url, entity, String.class);
            String body = resp.getBody() == null ? "" : resp.getBody().trim();

            if (!resp.getStatusCode().is2xxSuccessful()) {
                Map<String, String> err = new HashMap<>();
                err.put("reply", "⚠️ Ollama 回傳錯誤狀態: " + resp.getStatusCodeValue());
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(err);
            }

            String replyText = null;
            try {
                String candidate = body;
                if (body.contains("\n")) {
                    String[] lines = body.split("\\r?\\n");
                    for (int i = lines.length - 1; i >= 0; i--) {
                        if (!lines[i].trim().isEmpty()) {
                            candidate = lines[i].trim();
                            break;
                        }
                    }
                }
                JsonNode node = mapper.readTree(candidate);
                if (node.has("response")) {
                    replyText = node.get("response").asText();
                } else if (node.has("text")) {
                    replyText = node.get("text").asText();
                } else if (node.has("output")) {
                    replyText = node.get("output").asText();
                } else {
                    replyText = node.isTextual() ? node.asText() : node.toString();
                }
            } catch (Exception ex) {
                replyText = body.isEmpty() ? "⚠️ 無法解析 Ollama 回應" : body;
            }

            Map<String, String> result = new HashMap<>();
            result.put("reply", replyText.trim());
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, String> err = new HashMap<>();
            err.put("reply", "⚠️ 伺服器錯誤：" + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(err);
        }
    }
}
