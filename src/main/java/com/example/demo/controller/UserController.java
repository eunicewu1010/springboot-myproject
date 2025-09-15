package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.UserService;

@Controller
@RequestMapping("/register")
public class UserController {
	@Autowired
    private UserService userService;

    @GetMapping
    public String showRegisterPage() {
       
        return "register";
    }

    @PostMapping
    public String registerUser(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               @RequestParam("email") String email,
                               @RequestParam("role") String role,
                               Model model) { // Spring's Model for passing data to the view
		String resultMessage;
    	try {
    		 userService.addUser(username, password, email, role);
    	     resultMessage = "用戶 " + username + " 註冊成功 !";
    	} catch (Exception e) {
    	     resultMessage = " 註冊失敗"+ e ;
		}

        model.addAttribute("resultMessage", resultMessage);

        return "registerResult";
    }
   
   
    
}