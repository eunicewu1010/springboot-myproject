package com.example.demo.controller;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/chatbot")
public class ChatbotController {

    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/ask")
    public Map<String, Object> ask(@RequestBody Map<String, String> payload) {
        String userMessage = payload.get("message");

        // 組裝 Ollama API 的請求
        String url = "http://localhost:11434/api/generate";  // Ollama 預設在本機跑
        Map<String, Object> request = new HashMap<>();
        request.put("model", "llama3");   // 你有下載的模型名稱
        request.put("prompt", userMessage);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(request, headers);

        try {
            // 呼叫 Ollama API
            ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);

            // Ollama 回傳格式裡面，最終回答通常在 "response"
            Map<String, Object> result = new HashMap<>();
            if (response.getBody() != null) {
                result.put("reply", response.getBody().get("response"));
            } else {
                result.put("reply", "抱歉，我暫時無法回答。");
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("reply", "後端錯誤：" + e.getMessage());
            return error;
        }
    }
}
