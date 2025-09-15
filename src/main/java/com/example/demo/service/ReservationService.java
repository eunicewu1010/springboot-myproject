package com.example.demo.service;

import java.util.List;

import com.example.demo.model.entity.Reservation;

public interface ReservationService {

    // 新增訂位（含座位分配邏輯）
    Reservation makeReservation(Reservation reservation) throws Exception;

    // 修改訂位（建議與 makeReservation 使用相同驗證邏輯）
    Reservation updateReservation(Reservation reservation) throws Exception;

    // 根據日期與時段查詢訂位（給前台查詢用）
    List<Reservation> getReservationsByDateAndTime(String date, Integer timeId);

    // 查詢使用者個人的訂單（給會員查詢用）
    List<Reservation> getReservationsByUserId(Integer userId);

    // 查詢全部訂單（管理員使用）
    List<Reservation> findAllReservations();

    // 根據 ID 查詢單筆訂位（編輯用）
    Reservation findById(Integer reservationId);

    // 刪除訂位（前台用，有限制條件）
    boolean deleteReservationIfAllowed(Integer reservationId, Integer userId);
    
    // 刪除訂位（給管理員）
    void deleteReservation(Integer reservationId);

}
