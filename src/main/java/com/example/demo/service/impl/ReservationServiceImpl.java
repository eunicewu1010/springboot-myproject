package com.example.demo.service.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.entity.Dtable;
import com.example.demo.model.entity.Reservation;
import com.example.demo.repository.DtableRepository;
import com.example.demo.repository.ReservationRepository;
import com.example.demo.service.ReservationService;

@Service
public class ReservationServiceImpl implements ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private DtableRepository dtableRepository;

    @Override
    public Reservation makeReservation(Reservation reservation) throws Exception {
        String date = reservation.getDate();
        Integer timeId = reservation.getTimeSlots().getTimeId();
        Integer people = reservation.getPeople();

        // 查詢該時段已有的桌號
        List<Reservation> existing = reservationRepository.findReservations(date, timeId);
        Set<Integer> reservedTableIds = existing.stream()
                .map(r -> r.getDtable().getDtableId())
                .collect(Collectors.toSet());

        // 根據人數決定桌型
        List<Dtable> candidates = findAvailableTables(people, reservedTableIds);
        if (candidates.isEmpty()) {
            throw new Exception("該時段座位已滿");
        }

        // 分配第一個可用桌號
        reservation.setDtable(candidates.get(0));
        return reservationRepository.save(reservation);
    }

    @Override
    public Reservation updateReservation(Reservation reservation) throws Exception {
        Integer reservationId = reservation.getReservationId();
        Optional<Reservation> existingOpt = reservationRepository.findById(reservationId);
        if (existingOpt.isEmpty()) {
            throw new Exception("找不到該筆訂位資料");
        }

        Reservation existing = existingOpt.get();

        // 查詢該時段已有的桌號（排除自己）
        String date = reservation.getDate();
        Integer timeId = reservation.getTimeSlots().getTimeId();
        Integer people = reservation.getPeople();

        List<Reservation> others = reservationRepository.findReservations(date, timeId).stream()
                .filter(r -> !r.getReservationId().equals(reservationId))
                .collect(Collectors.toList());

        Set<Integer> reservedTableIds = others.stream()
                .map(r -> r.getDtable().getDtableId())
                .collect(Collectors.toSet());

        List<Dtable> candidates = findAvailableTables(people, reservedTableIds);
        if (candidates.isEmpty()) {
            throw new Exception("該時段座位已滿");
        }

        // 更新資料欄位
        existing.setName(reservation.getName());
        existing.setPhone(reservation.getPhone());
        existing.setEmail(reservation.getEmail());
        existing.setDate(reservation.getDate());
        existing.setTimeSlots(reservation.getTimeSlots());
        existing.setPeople(reservation.getPeople());
        existing.setMessage(reservation.getMessage());
        existing.setDtable(candidates.get(0));

        return reservationRepository.save(existing);
    }

    @Override
    public List<Reservation> getReservationsByDateAndTime(String date, Integer timeId) {
        return reservationRepository.findReservations(date, timeId);
    }

    @Override
    public List<Reservation> getReservationsByUserId(Integer userId) {
        return reservationRepository.findReservationsByUserId(userId);
    }

    @Override
    public List<Reservation> findAllReservations() {
        return reservationRepository.findAll();
    }

    @Override
    public Reservation findById(Integer reservationId) {
        return reservationRepository.findById(reservationId).orElse(null);
    }

    @Override
    public boolean deleteReservationIfAllowed(Integer reservationId, Integer userId) {
        Optional<Reservation> optional = reservationRepository.findById(reservationId);
        if (optional.isEmpty()) {
            return false;
        }

        Reservation reservation = optional.get();

        if (!reservation.getUser().getUserId().equals(userId)) {
            return false;
        }

        LocalDate reservationDate = LocalDate.parse(reservation.getDate());
        LocalDateTime lastDeleteTime = reservationDate.minusDays(1).atTime(23, 59, 59);
        LocalDateTime now = LocalDateTime.now();

        if (now.isAfter(lastDeleteTime)) {
            return false;
        }

        reservationRepository.delete(reservation);
        return true;
    }

    // 🔧 共用方法：根據人數決定可用桌位
    private List<Dtable> findAvailableTables(Integer people, Set<Integer> reservedTableIds) throws Exception {
        if (people <= 4) {
            return dtableRepository.findAll().stream()
                    .filter(t -> t.getDtableSize() == 4)
                    .filter(t -> !reservedTableIds.contains(t.getDtableId()))
                    .collect(Collectors.toList());
        } else if (people >= 5 && people <= 6) {
            return dtableRepository.findAll().stream()
                    .filter(t -> t.getDtableSize() == 6)
                    .filter(t -> !reservedTableIds.contains(t.getDtableId()))
                    .collect(Collectors.toList());
        } else {
            throw new Exception("不支援的用餐人數");
        }
    }
    @Override
    public void deleteReservation(Integer reservationId) {
        reservationRepository.deleteById(reservationId);
    }
}
