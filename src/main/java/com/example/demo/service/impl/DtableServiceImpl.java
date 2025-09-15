package com.example.demo.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.exception.DtableAlreadyExistsException;
import com.example.demo.exception.DtableNotFoundException;
import com.example.demo.mapper.DtableMapper;
import com.example.demo.model.dto.DtableDto;
import com.example.demo.model.entity.Dtable;
import com.example.demo.repository.DtableRepository;
import com.example.demo.service.DtableService;

@Service
public class DtableServiceImpl implements DtableService{

	@Autowired
	private DtableRepository dtableRepository;
	
	@Autowired
	private DtableMapper dtableMapper;
	
	
	@Override
	public List<DtableDto> findAllDtables() {
		return dtableRepository.findAll()   // room 集合
				 .stream()    // room 串流
				 .map(dtableMapper::toDto) // roomDto 串流  .map(room -> roomMapper.toDto(room))
				 .toList();   // roomDto 集合
	}

	@Override
	public DtableDto getDtableById(Integer dtableId) {
		Dtable dtable = dtableRepository.findById(dtableId)
				.orElseThrow(() -> new DtableNotFoundException("找不到會議室: dtableId=" + dtableId));
		return dtableMapper.toDto(dtable);
	}

	@Override
	public void addDtable(DtableDto dtableDto) {
		// 判斷該房號是否已經存在 ?
				Optional<Dtable> optDtable = dtableRepository.findById(dtableDto.getDtableId());
				if(optDtable.isPresent()) { // 房間已存在
					throw new DtableAlreadyExistsException("新增失敗: 房號 " + dtableDto.getDtableId() + " 已經存在");
				}
				// 進入新增程序
				// DTO 轉 Entity
				Dtable dtable = dtableMapper.toEntity(dtableDto);
				// 將 Entity room 存入
				dtableRepository.save(dtable); // 更新(可以配合交易模式, 若交易失敗則會回滾), 只是先暫存起來
				dtableRepository.flush(); // 提早手動寫入資料庫
				// ... 其他 code
		
	}

	@Override
	public void addDtable(Integer dtableId, String dtableName, Integer dtableSize) {
		DtableDto dtableDto = new DtableDto(dtableId, dtableName, dtableSize);
		addDtable(dtableDto);
		
	}

	@Override
	public void updateDtable(Integer dtableId, DtableDto dtableDto) {
				// 判斷該房號是否已經存在 ?
				Optional<Dtable> optDtable = dtableRepository.findById(dtableId);
				if(optDtable.isEmpty()) { // 房間不存在
					throw new DtableAlreadyExistsException("修改失敗: 房號 " + dtableId + " 不存在");
				}
				dtableDto.setDtableId(dtableId);
				Dtable dtable = dtableMapper.toEntity(dtableDto);
				dtableRepository.saveAndFlush(dtable); // 更新(馬上強制寫入更新)
				//roomRepository.save(dtable); // 更新(可以配合交易模式, 若交易失敗則會回滾)
		
	}

	@Override
	public void updateDtable(Integer dtableId, String dtableName, Integer dtableSize) {
		DtableDto dtableDto = new DtableDto(dtableId, dtableName, dtableSize);
		updateDtable(dtableId, dtableDto);
		
	}

	@Override
	public void deleteDtable(Integer dtableId) {
				// 判斷該房號是否已經存在 ?
				Optional<Dtable> optDtable = dtableRepository.findById(dtableId);
				if(optDtable.isEmpty()) { // 房間不存在
					throw new DtableAlreadyExistsException("刪除失敗: 房號 " + dtableId + " 不存在");
				}
				dtableRepository.deleteById(dtableId);
		
	}

	
}
