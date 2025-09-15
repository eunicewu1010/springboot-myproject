package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.exception.DtableException;
import com.example.demo.model.dto.DtableDto;
import com.example.demo.service.DtableService;

import jakarta.validation.Valid;

/**
 * Method URI            功能
 * --------------------------------------------------------------------
 * GET    /rooms                查詢所有會議室(多筆)
 * GET    /room/{roomId}        查詢指定會議室(單筆)-修改專用
 * POST   /room                 新增會議室
 * PUT    /room/update/{roomId} 完整修改會議室(同時修改 roomName 與 roomSize)
 * DELETE /room/delete/{roomId} 刪除會議室
 * --------------------------------------------------------------------
 * */

@Controller
@RequestMapping(value = {"/dtable", "/dtables"})
public class DtableController {
	
	@Autowired
	private DtableService dtableService;
	
	@GetMapping
	public String getRooms(Model model, @ModelAttribute DtableDto roomDto) {
		List<DtableDto> dtableDtos = dtableService.findAllDtables();
		model.addAttribute("dtableDtos", dtableDtos);
		return "dtable/dtable";
	}
	
	@GetMapping("/{dtableId}")
	public String getDtable(@PathVariable Integer dtableId, Model model) {
		DtableDto dtableDto = dtableService.getDtableById(dtableId);
		model.addAttribute("dtableDto", dtableDto);
		return "dtable/dtable_update";
	}
	
	/*
	 * @Valid RoomDto roomDto, BindingResult bindingResult
	 * RoomDto 要進行屬性資料驗證, 驗證結果放到 bindingResult
	 * */
	@PostMapping
	public String addDtable(@Valid DtableDto dtableDto, BindingResult bindingResult, Model model) {
		// 驗證資料
		if(bindingResult.hasErrors()) { // 若驗證時有錯誤發生
			model.addAttribute("dtableDtos", dtableService.findAllDtables());
			return "dtable/dtable";
		}
		
		// 進行新增
		dtableService.addDtable(dtableDto);
		return "redirect:/dtables";
	}
	
	@PutMapping("/update/{dtableId}")
	public String updateDtable(@PathVariable Integer dtableId, @Valid DtableDto dtableDto, BindingResult bindingResult) {
		// 驗證資料
		if(bindingResult.hasErrors()) { // 若驗證時有錯誤發生
			return "dtable/dtable_update";
		}
		
		// 進行修改
		dtableService.updateDtable(dtableId, dtableDto);
		return "redirect:/dtables";
	}
	
	@DeleteMapping("/delete/{dtableId}")
	public String deleteDtable(@PathVariable Integer dtableId) {
		dtableService.deleteDtable(dtableId);
		return "redirect:/dtables"; // 重導到 /rooms 頁面
	}
	
	@ExceptionHandler({DtableException.class})
	public String handleException(Exception e, Model model) {
		e.printStackTrace();
		model.addAttribute("message", e.getMessage());
		return "error";
	}
	
}