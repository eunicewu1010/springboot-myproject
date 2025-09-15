package com.example.demo.service;

import java.util.List;

import com.example.demo.model.dto.DtableDto;

public interface DtableService {
	public List<DtableDto> findAllDtables(); // 查詢所有房間
	public DtableDto getDtableById(Integer dtableId); // 查詢單筆房間
	public void addDtable(DtableDto dtableDto); // 新增房間
	public void addDtable(Integer dtableId, String dtableName, Integer dtableSize); // 新增房間
	public void updateDtable(Integer dtableId, DtableDto dtableDto); // 修改房間
	public void updateDtable(Integer dtableId, String dtableName, Integer dtableSize); // 修改房間
	public void deleteDtable(Integer dtableId); // 刪除房間
}