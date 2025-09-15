package com.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity 
@Table 
public class Reservation {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 自動生成 id
	@Column(name = "reservation_id") // 資料表 user 中預設的欄位名稱
	private Integer reservationId; // 使用者 ID
	
	@Column(name = "name", unique = false, nullable = false, length = 50)
	private String name;
	
	@Column(name = "people",nullable = false, length = 2)
	private Integer people;
	
	@Column(name = "email", nullable = false)
	private String email;
	
	@Column(name = "phone", nullable = false)
	private String phone;
	
	@Column(name = "date", nullable = false, length = 10)
	private String date;
	
	@ManyToOne
	@JoinColumn(name = "time_id", nullable = false)
	private TimeSlots timeSlots;
	
	@Column(name = "message", length = 200)
	private String message;
	
	@ManyToOne
	@JoinColumn(name = "dtable_id", nullable = false)
	private Dtable dtable;
	
	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private User user;


	
	
	
}