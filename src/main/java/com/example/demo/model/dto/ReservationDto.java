package com.example.demo.model.dto;

import org.hibernate.validator.constraints.Range;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationDto {
	 	private String username;
	    private Integer people;
	    private String email;
	    private String phone;
	    private String date;
	    private String timeSlot;
		@Range(max = 200, message = "{reservationDto.message.range}")
	    private String message;
}
