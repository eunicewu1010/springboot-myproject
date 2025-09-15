package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/userpage")
public class UserpageController {

	 @GetMapping
	 public String userpage() {
	        
		 return "userpage";
		 
	    }
	 
}
