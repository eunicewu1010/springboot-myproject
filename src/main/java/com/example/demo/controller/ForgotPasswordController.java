package com.example.demo.controller;

import com.example.demo.model.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.EmailService;
import com.example.demo.util.Hash;
import com.example.demo.util.JwtUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ForgotPasswordController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private EmailService emailService;

    @GetMapping("/forgotPassword")
    public String showForgotPasswordPage() {
        return "forgotPassword";  // 對應 forgotPassword.jsp
    }
    // 處理忘記密碼表單提交
    @PostMapping("/forgotPassword")
    public String processForgotPassword(@RequestParam("email") String email, Model model) {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            model.addAttribute("errorMsg", "查無此 Email，請確認輸入是否正確。");
            return "forgotPassword";
        }

        // 產生 JWT Token（包含 userId 與過期時間）
        String token = JwtUtil.generateToken(user.getUserId());

        // 寄送密碼重設連結
        String resetUrl = "http://localhost:8082/resetPassword?token=" + token;
        emailService.sendEmail(email, resetUrl);

        model.addAttribute("successMsg", "重設密碼連結已寄出，請檢查您的信箱。");
        return "forgotPassword";
    }
    @GetMapping("/resetPassword")
    public String showResetPasswordPage(@RequestParam("token") String token, Model model) {
        try {
            JwtUtil.validateTokenAndGetUserId(token); // 驗證 token 有效性
            model.addAttribute("token", token); // 傳給 JSP
            return "resetPassword"; // 對應 resetPassword.jsp
        } catch (Exception e) {
            model.addAttribute("errorMsg", "連結無效或已過期，請重新申請。");
            return "errorPage"; // 或自訂錯誤頁
        }
    }
    
    @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam("token") String token,
                                @RequestParam("newPassword") String newPassword,
                                Model model) {
        try {
            Integer userId = JwtUtil.validateTokenAndGetUserId(token);
            User user = userRepository.findById(userId).orElse(null);
            if (user == null) {
                model.addAttribute("errorMsg", "使用者不存在");
                return "resetPassword";
            }

            // 產生新鹽
            String newSalt = Hash.getSalt();
            // 用新鹽加密密碼
            String newHashedPassword = Hash.getHash(newPassword, newSalt);

            // 更新 user 的密碼雜湊和鹽
            user.setSalt(newSalt);
            user.setPasswordHash(newHashedPassword);

            userRepository.save(user);

            model.addAttribute("successMsg", "密碼已成功更新，請使用新密碼登入");
            return "login"; // 或重導回登入頁面
        } catch (Exception e) {
            model.addAttribute("errorMsg", "重設密碼失敗：" + e.getMessage());
            return "resetPassword";
        }
    }

    
}
