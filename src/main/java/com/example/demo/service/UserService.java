package com.example.demo.service;

import java.util.List;

import com.example.demo.model.dto.UserDto;

public interface UserService {
	public UserDto getUser(String username);
	public void addUser(String username, String password, String email, String role);	// 可以往下自訂 ...
    public List<UserDto> findAllUsers();
    UserDto findUserById(Integer userId);
    void updateUser(Integer userId, String username, String email, String role, String newPassword);
    void deleteUserById(Integer userId);
    // 一般修改密碼（需原密碼）
    boolean changePassword(Integer userId, String oldPassword, String newPassword);
    // 忘記密碼 - 無需原密碼直接更新（例如透過 Token）
    boolean changePasswordWithoutOldPwd(Integer userId, String newPassword);

}