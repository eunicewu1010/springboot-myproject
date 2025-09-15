package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.dto.UserCert;
import com.example.demo.model.dto.UserDto;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {
        UserCert userCert = (UserCert) session.getAttribute("userCert");
        if (userCert == null) {
            return "redirect:/login";
        }
        try {
            UserDto user = userService.getUser(userCert.getUsername());
            model.addAttribute("user", user);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "載入個人資料失敗");
        }
        return "profile";
    }
    
    
    @GetMapping("/changePassword")
    public String changePassword(HttpSession session, Model model) {
        UserCert userCert = (UserCert) session.getAttribute("userCert");
        if (userCert == null) {
            return "redirect:/login";
        }
        try {
            UserDto user = userService.getUser(userCert.getUsername());
            model.addAttribute("user", user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "changePassword";
    }

    @PostMapping("/changePassword")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session,
                                 Model model) {

        UserCert userCert = (UserCert) session.getAttribute("userCert");
        Integer userId = (userCert != null) ? userCert.getUserId() : null;

        if (userId == null) {
            model.addAttribute("errorMsg", "請先登入！");
            return "changePassword";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("errorMsg", "新密碼與確認密碼不一致！");
            return "changePassword";
        }

        try {
            boolean success = userService.changePassword(userId, oldPassword, newPassword);
            if (success) {
                model.addAttribute("successMsg", "密碼變更成功！");
            } else {
                model.addAttribute("errorMsg", "原密碼錯誤！");
            }
        } catch (Exception e) {
            model.addAttribute("errorMsg", "發生錯誤：" + e.getMessage());
        }

        return "changePassword";
    }


}
