package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.model.entity.Reservation;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    @Query("SELECT r FROM Reservation r WHERE r.date = :date AND r.timeSlots.timeId = :timeId")
    List<Reservation> findReservations(@Param("date") String date, @Param("timeId") Integer timeId);

    @Query("SELECT r FROM Reservation r WHERE r.user.userId = :userId ORDER BY r.date DESC")
    List<Reservation> findReservationsByUserId(@Param("userId") Integer userId);

}
