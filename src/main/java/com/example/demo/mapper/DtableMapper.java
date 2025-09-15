package com.example.demo.mapper;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.demo.model.dto.DtableDto;
import com.example.demo.model.entity.Dtable;



@Component // 此物件由 Springboot 來管理
public class DtableMapper {
	
	@Autowired
	private ModelMapper modelMapper;
	
	public DtableDto toDto(Dtable dtable) {
		// Entity 轉 DTO
		return modelMapper.map(dtable, DtableDto.class);
	}
	
	public Dtable toEntity(DtableDto dtableDto) {
		// DTO 轉 Entity
		return modelMapper.map(dtableDto, Dtable.class);
	}
	
}