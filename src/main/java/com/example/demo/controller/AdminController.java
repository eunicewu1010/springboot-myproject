package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.dto.UserCert;
import com.example.demo.model.dto.UserDto;
import com.example.demo.model.entity.Reservation;
import com.example.demo.service.ReservationService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private ReservationService reservationService;

    // 管理員首頁
    @GetMapping("/adminpage")
    public String adminHome(HttpSession session, Model model) {
        UserCert user = (UserCert) session.getAttribute("userCert");

        if (user == null) {
            return "redirect:/login";
        }

        if (!"admin".equalsIgnoreCase(user.getRole())) {
            model.addAttribute("noPermission", true);
        }

        return "admin/adminpage";
    }

    // 使用者管理畫面
    @GetMapping("/usermanagement")  
    public String userManagement(Model model) {
        List<UserDto> userList = userService.findAllUsers();
        model.addAttribute("userList", userList);
        return "admin/usermanagement";
    }

    // 編輯使用者
    @GetMapping("/editUser")
    public String editUser(@RequestParam("userId") Integer userId, Model model) {
        UserDto selectedUser = userService.findUserById(userId);
        model.addAttribute("selectedUser", selectedUser);
        model.addAttribute("userList", userService.findAllUsers());
        return "admin/usermanagement";
    }

    // 更新使用者
    @PostMapping("/updateUser")
    public String updateUser(@RequestParam("userId") Integer userId,
                             @RequestParam("username") String username,
                             @RequestParam("email") String email,
                             @RequestParam("role") String role,
                             @RequestParam(value = "password", required = false) String password,
                             Model model) {

        userService.updateUser(userId, username, email, role, password);
        model.addAttribute("userList", userService.findAllUsers());
        model.addAttribute("message", "使用者資料已成功更新！");
        return "admin/usermanagement";
    }

    // 刪除使用者
    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("userId") Integer userId, Model model) {
        userService.deleteUserById(userId);
        model.addAttribute("userList", userService.findAllUsers());
        model.addAttribute("message", "使用者已刪除！");
        return "admin/usermanagement";
    }

    // 新增使用者
    @PostMapping("/addUser")
    public String addUser(@RequestParam("username") String username,
                          @RequestParam("email") String email,
                          @RequestParam("password") String password,
                          @RequestParam("role") String role,
                          Model model) {

        userService.addUser(username, password, email, role);
        model.addAttribute("userList", userService.findAllUsers());
        model.addAttribute("message", "使用者「" + username + "」已成功新增！");
        return "admin/usermanagement";
    }

    // 查看所有訂位
    @GetMapping("/reservations")
    public String showReservationList(HttpSession session, Model model) {
        UserCert userCert = (UserCert) session.getAttribute("userCert");
        if (userCert == null || !"admin".equalsIgnoreCase(userCert.getRole())) {
            return "redirect:/userpage";
        }

        List<Reservation> reservationList = reservationService.findAllReservations();
        model.addAttribute("reservationList", reservationList);
        return "admin/reservations";
    }

    // 編輯訂位表單
    @GetMapping("/editReservation")
    public String showEditReservationForm(@RequestParam("id") Integer reservationId, Model model) {
        Reservation reservation = reservationService.findById(reservationId);
        if (reservation == null) {
            model.addAttribute("error", "查無此訂位資料");
            return "redirect:/admin/reservations";
        }
        model.addAttribute("reservation", reservation);
        return "admin/reservationForm";
    }

    // 更新訂位
    @PostMapping("/updateReservation")
    public String updateReservation(@ModelAttribute Reservation reservation, Model model) {
        try {
            reservationService.updateReservation(reservation);
            model.addAttribute("message", "修改成功！");
        } catch (Exception e) {
            model.addAttribute("error", "修改失敗：" + e.getMessage());
        }
        return "admin/reservationForm";
    }
    
    @PostMapping("/deleteReservation")
    public String deleteReservation(@RequestParam("reservationId") Integer reservationId, Model model) {
        Reservation reservation = reservationService.findById(reservationId);
        if (reservation != null) {
            reservationService.deleteReservation(reservationId);  // 你需要新增這個方法
            model.addAttribute("message", "成功刪除訂位！");
        } else {
            model.addAttribute("error", "查無此訂位！");
        }
        model.addAttribute("reservationList", reservationService.findAllReservations());
        return "admin/reservations";
    }

}
