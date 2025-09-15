package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.demo.model.entity.Dtable;

// Spring JPA
@Repository
public interface DtableRepository extends JpaRepository<Dtable, Integer> { // Room: entity, Integer: @Id 的型別
	
	
	
	
	@Query(value = "select dtable_id, dtable_name, dtable_size from dtable where dtable_size > :dtableSize", nativeQuery = true)
	List<Dtable> findDtables(Integer dtableSize);
	
	@Query(value = "select r from Dtable r where r.dtableSize > :dtableSize")
	List<Dtable> readDtables(Integer dtableSize);
	
	

	
}