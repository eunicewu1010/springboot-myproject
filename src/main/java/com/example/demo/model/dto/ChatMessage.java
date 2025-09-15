package com.example.demo.model.dto;

public class ChatMessage {
    private String from;
    private String to;
    private String content;

    // Constructors
    public ChatMessage() {}
    
    public ChatMessage(String from, String to, String content) {
        this.from = from;
        this.to = to;
        this.content = content;
    }

    // Getters and Setters
    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
