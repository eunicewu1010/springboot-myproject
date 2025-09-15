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
@Table(name = "dtable") // 若資料表名稱與實體類一致可以不用設定此行
public class Dtable {
	@Id // 主鍵
	//@GeneratedValue(strategy = GenerationType.IDENTITY) // room_id 會從 1 開始自動生成, 每次 +1, 過號不補
	@Column(name = "dtable_id")
	private Integer dtableId;
	
	@Column(name = "dtable_name", nullable = false, unique = true)
	private String dtable;
	
	@Column(name = "dtable_size", columnDefinition = "integer default 0")
	private Integer dtableSize;

	
}