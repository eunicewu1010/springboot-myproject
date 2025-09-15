package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.demo.exception.CertException;
import com.example.demo.model.dto.UserCert;
import com.example.demo.service.CertService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private CertService certService;

    @GetMapping
    public String loginPage() {
        return "login";
    }

    @PostMapping
    public String checkLogin(@RequestParam String username,
                             @RequestParam String password,
                             @RequestParam String authcode,  // 新增驗證碼參數
                             Model model,
                             HttpSession session) {
        // 驗證驗證碼
        String sessionAuthcode = (String) session.getAttribute("authcode");
        if (sessionAuthcode == null || !sessionAuthcode.equalsIgnoreCase(authcode)) {
            model.addAttribute("errorMsg", "驗證碼錯誤，請重新輸入！");
            return "login";
        }

        // 清除驗證碼，避免重複使用
        session.removeAttribute("authcode");

        // 驗證帳號密碼
        try {
            UserCert userCert = certService.getCert(username, password);
            session.setAttribute("userCert", userCert);

            // 根據 role 導向不同頁面
            if ("admin".equalsIgnoreCase(userCert.getRole())) {
                return "redirect:/admin/adminpage";
            } else if ("user".equalsIgnoreCase(userCert.getRole())) {
                return "redirect:/userpage";
            } else {
                // 預設未知角色處理
                model.addAttribute("errorMsg", "未知身份角色，請聯繫管理員！");
                return "login";
            }

        } catch (CertException e) {
            session.invalidate();
            model.addAttribute("errorMsg", e.getMessage());
            e.printStackTrace();
            return "login";
        }
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();  // 清空 session 資料
        return "logout";  // 回到登出畫面
    }
}
