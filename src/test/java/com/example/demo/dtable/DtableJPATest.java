package com.example.demo.dtable;

import java.util.Scanner;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.demo.model.entity.Dtable;
import com.example.demo.repository.DtableRepository;

@SpringBootTest
public class DtableJPATest {
	
	@Autowired
	private DtableRepository dtableRepository;
	
	@Test
	public void testDtableAdd() {
		Scanner scanner = new Scanner(System.in);
		System.out.print("請輸入桌號:");
		Integer dtableId = scanner.nextInt();
		System.out.print("請輸入桌名:");
		String dtableName = scanner.next();
		System.out.print("請輸入人數:");
		Integer dtableSize = scanner.nextInt();
		// --------------------------------------
		Dtable dtable = new Dtable(dtableId, dtableName, dtableSize);
		// 新增到資料庫
		dtable = dtableRepository.save(dtable);
		System.out.println("測試新增:" + dtable);
	}
	
}