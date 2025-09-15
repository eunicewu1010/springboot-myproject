package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.model.entity.TimeSlots;

public interface TimeSlotsRepository extends JpaRepository<TimeSlots, Integer> {
    
}
