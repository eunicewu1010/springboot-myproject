package com.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity // 實體類與資料表對應(會自動建立資料表)
@Table(name = "time_slots") // 可選:可以手動建立資料表名
public class TimeSlots {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 自動生成 id
	@Column(name = "time_id") // 資料表 user 中預設的欄位名稱
	private Integer timeId; // 使用者 ID
	
	@Column(name = "time_slot", unique = true, nullable = false, length = 50)
	private String timeSlot;
	
	
}
