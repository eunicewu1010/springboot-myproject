package com.example.demo.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.model.dto.UserCert;
import com.example.demo.model.entity.Reservation;
import com.example.demo.service.ReservationService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    // 顯示預約表單頁面
    @GetMapping
    public String showForm(Model model) {
        model.addAttribute("reservation", new Reservation());
        return "reservation/form";  // 對應 reservation/form.jsp
    }

    @PostMapping("/make")
    public String makeReservation(@ModelAttribute Reservation reservation, Model model, HttpSession session) {
        try {
            UserCert userCert = (UserCert) session.getAttribute("userCert");
            if (userCert == null) {
                return "redirect:/login";
            }

            // 把 userId 設到 Reservation 內的 User Entity
            // 需要先建立 User 物件並設 userId
            com.example.demo.model.entity.User user = new com.example.demo.model.entity.User();
            user.setUserId(userCert.getUserId());

            reservation.setUser(user);

            reservationService.makeReservation(reservation);

            model.addAttribute("msg", "預約成功！");
            return "reservation/success";
        } catch (Exception e) {
            model.addAttribute("errorMsg", e.getMessage());
            model.addAttribute("reservation", reservation);
            return "reservation/form";
        }
    }

    @GetMapping("/history")
    public String getReservationHistory(HttpSession session, Model model) {
        UserCert userCert = (UserCert) session.getAttribute("userCert");
        if (userCert == null) {
            return "redirect:/login";
        }

        List<Reservation> reservations = reservationService.getReservationsByUserId(userCert.getUserId());
        model.addAttribute("username", userCert.getUsername());
        model.addAttribute("reservations", reservations);

        // 傳送明天日期字串給 JSP 判斷是否可刪除
        model.addAttribute("tomorrow", LocalDate.now().plusDays(1).toString());

        return "reservation/history"; // 對應你的 JSP 檔名
    }

    @PostMapping("/delete/{reservationId}")
    public String deleteReservation(@PathVariable Integer reservationId, HttpSession session, RedirectAttributes redirectAttributes) {
        UserCert userCert = (UserCert) session.getAttribute("userCert");
        if (userCert == null) {
            return "redirect:/login";
        }

        try {
            boolean success = reservationService.deleteReservationIfAllowed(reservationId, userCert.getUserId());
            if (!success) {
                redirectAttributes.addFlashAttribute("errorMsg", "刪除失敗：只能在訂位日期前一天23:59前刪除訂單。");
            } else {
                redirectAttributes.addFlashAttribute("msg", "訂單已成功刪除。");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMsg", "系統錯誤：" + e.getMessage());
        }
        return "redirect:/reservation/history";
    }

}