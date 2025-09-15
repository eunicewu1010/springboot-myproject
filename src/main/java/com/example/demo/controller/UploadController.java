package com.example.demo.controller;

import com.example.demo.model.dto.UserCert;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UploadController {

    @Value("${upload.path}")
    private String uploadDir;

    // 顯示上傳頁面
    @GetMapping("/uploadmenu")
    public String showUploadPage(HttpSession session, Model model) {
        UserCert userCert = (UserCert) session.getAttribute("userCert");
        String role = (userCert != null) ? userCert.getRole() : null;
        model.addAttribute("role", role);

        // 圖片列表
        File dir = new File(uploadDir);
        List<String> imageNames = new ArrayList<>();

        if (dir.exists() && dir.isDirectory()) {
            File[] files = dir.listFiles((d, name) ->
                    name.toLowerCase().matches(".*\\.(jpg|jpeg|png|gif)$"));

            if (files != null) {
                for (File file : files) {
                    imageNames.add(file.getName()); // 只儲存檔名
                }
            }
        }

        model.addAttribute("images", imageNames);

        return "uploadmenu"; // JSP: /WEB-INF/view/uploadmenu.jsp
    }

    // 處理圖片上傳（只限 admin）
    @PostMapping("/uploadmenu")
    public String handleImageUpload(@RequestParam("imageFile") MultipartFile imageFile,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {

        UserCert userCert = (UserCert) session.getAttribute("userCert");
        String role = (userCert != null) ? userCert.getRole() : null;

        if (!"admin".equals(role)) {
            redirectAttributes.addFlashAttribute("message", "您沒有權限上傳圖片！");
            return "redirect:/uploadmenu";
        }

        if (imageFile.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "請選擇一張圖片！");
            return "redirect:/uploadmenu";
        }

        try {
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String originalFilename = imageFile.getOriginalFilename();
            File destFile = new File(dir, originalFilename);
            imageFile.transferTo(destFile);

            redirectAttributes.addFlashAttribute("message", "圖片上傳成功！");
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "上傳失敗：" + e.getMessage());
        }

        return "redirect:/uploadmenu";
    }

    // 處理圖片刪除（只限 admin）
    @PostMapping("/deleteImage")
    public String deleteImage(@RequestParam("filename") String filename,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        UserCert userCert = (UserCert) session.getAttribute("userCert");
        String role = (userCert != null) ? userCert.getRole() : null;

        if (!"admin".equals(role)) {
            redirectAttributes.addFlashAttribute("message", "您沒有權限刪除圖片！");
            return "redirect:/uploadmenu";
        }

        File file = new File(uploadDir, filename);
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                redirectAttributes.addFlashAttribute("message", "圖片刪除成功！");
            } else {
                redirectAttributes.addFlashAttribute("message", "刪除失敗！");
            }
        } else {
            redirectAttributes.addFlashAttribute("message", "找不到指定圖片！");
        }

        return "redirect:/uploadmenu";
    }
}
