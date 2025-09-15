package com.example.demo.mapper;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.demo.model.dto.ReservationDto;
import com.example.demo.model.dto.UserDto;
import com.example.demo.model.entity.Reservation;
import com.example.demo.model.entity.User;

@Component
public class ReservationMapper {
	@Autowired
	private ModelMapper modelMapper;
	
	public ReservationDto toDto(Reservation reservation) {
		// Entity 轉 DTO
		return modelMapper.map(reservation, ReservationDto.class);
	}
	
	public Reservation toEntity(ReservationDto reservationDto) {
		// DTO 轉 Entity
		return modelMapper.map(reservationDto, Reservation.class);
	}
	
}
