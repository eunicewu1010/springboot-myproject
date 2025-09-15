package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.CertService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/logout")
public class LogoutController {
	@Autowired
	private CertService certService;
	
	@GetMapping
	public String logoutPage() {
		return "logout";
	}
	
	
	
	@GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();  // 清空 session 資料
        return "homepage";  // 回到登入頁
    }
}
