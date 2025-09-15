package com.example.demo.reservation;

import java.util.Scanner;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.demo.repository.ReservationRepository;

@SpringBootTest
public class ReservationJPATest {
	
	@Autowired
	private ReservationRepository reservationRepository;
	
	@Test
	public void testReservationAdd() {
	
		
	}
	
	
}
