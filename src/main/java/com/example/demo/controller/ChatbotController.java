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
        String finalPrompt = "請你無論收到什麼訊息，都要用繁體中文回答。\n使用者訊息：" + userMessage;

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
