package com.example.demo.service;

import java.util.Properties;
import javax.mail.*;  
import javax.mail.internet.*;

import org.springframework.stereotype.Service;

@Service
public class EmailService {
    
    // Google應用程式密碼（建議用 application.properties 配置）
    private final String googleAppPassword = "ubst xakp egjn efol";
    private final String from = "wu.eunice1010@gmail.com";
    
    public void sendEmail(String to, String confirmUrl) {
        String host = "smtp.gmail.com";
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, googleAppPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("忘記密碼 - 重設連結");
            message.setText("請點擊以下連結重設密碼：\n" + confirmUrl);
            Transport.send(message);
            System.out.println("發送成功: " + to);
        } catch (MessagingException e) {
            System.out.println("發送失敗: " + e.getMessage());
        }
    }
}
