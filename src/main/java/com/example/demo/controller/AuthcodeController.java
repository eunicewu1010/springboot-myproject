// AuthcodeController.java
package com.example.demo.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;

@Controller
@RequestMapping("/authcode")
public class AuthcodeController {

    @GetMapping
    public void getAuthCode(HttpSession session, HttpServletResponse response) throws IOException {
        // 設定圖片屬性
        int width = 100, height = 40;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();

        // 繪製背景
        g.setColor(new Color(220, 210, 200));  // 淺咖啡背景
        g.fillRect(0, 0, width, height);

        // 生成隨機驗證碼
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        Random rand = new Random();
        StringBuilder code = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            char c = chars.charAt(rand.nextInt(chars.length()));
            code.append(c);
        }

        // 存入 session
        session.setAttribute("authcode", code.toString());

        // 繪製文字
        g.setFont(new Font("Arial", Font.BOLD, 24));
        g.setColor(Color.BLACK);
        g.drawString(code.toString(), 20, 28);

        g.dispose();

        // 輸出圖片
        response.setContentType("image/png");
        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "png", out);
        out.close();
    }
}
