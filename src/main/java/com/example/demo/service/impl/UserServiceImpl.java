package com.example.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.UserMapper;
import com.example.demo.model.dto.UserDto;
import com.example.demo.model.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;
import com.example.demo.util.Hash;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserDto getUser(String username) {
		User user = userRepository.findByUsername(username);
		if(user == null) {
			return null;
		}
		return userMapper.toDto(user);
	}

	@Override
	public void addUser(String username, String password, String email, String role) {
		String salt = Hash.getSalt();
		String passwordHash = Hash.getHash(password, salt);
		User user = new User(null, username, passwordHash, salt, email, role);
		userRepository.save(user);
	}

	
	@Override
	public List<UserDto> findAllUsers() {
	    List<User> userList = userRepository.findAll();
	    return userList.stream()
	                   .map(userMapper::toDto)
	                   .toList(); // Java 8 請用 collect(Collectors.toList())
	}
	
	@Override
	public UserDto findUserById(Integer userId) {
	    User user = userRepository.findById(userId).orElse(null);
	    return (user != null) ? userMapper.toDto(user) : null;
	}

	@Override
	public void updateUser(Integer userId, String username, String email, String role, String newPassword) {
	    User user = userRepository.findById(userId).orElse(null);
	    if (user != null) {
	        user.setUsername(username);
	        user.setEmail(email);
	        user.setRole(role);

	        // 如果輸入新密碼，就重新產生 salt + hash
	        if (newPassword != null && !newPassword.trim().isEmpty()) {
	            String salt = Hash.getSalt();
	            String hashedPwd = Hash.getHash(newPassword, salt);
	            user.setSalt(salt);
	            user.setPasswordHash(hashedPwd);
	        }

	        userRepository.save(user);
	    }
	}
	@Override
	public void deleteUserById(Integer userId) {
	    userRepository.deleteById(userId);
	}

	@Override
	public boolean changePassword(Integer userId, String oldPassword, String newPassword) {
	    User user = userRepository.findById(userId).orElse(null);

	    if (user == null) return false;

	    // 驗證原密碼正確性
	    String oldHashed = Hash.getHash(oldPassword, user.getSalt());
	    if (!oldHashed.equals(user.getPasswordHash())) {
	        return false; // 原密碼錯誤
	    }

	    // 生成新 salt 與密碼 hash
	    String newSalt = Hash.getSalt();
	    String newHashed = Hash.getHash(newPassword, newSalt);

	    user.setSalt(newSalt);
	    user.setPasswordHash(newHashed);
	    userRepository.save(user);

	    return true;
	}
	
	@Override
	public boolean changePasswordWithoutOldPwd(Integer userId, String newPassword) {
	    User user = userRepository.findById(userId).orElse(null);
	    if (user == null) return false;

	    String newSalt = Hash.getSalt();
	    String newHashed = Hash.getHash(newPassword, newSalt);
	    user.setSalt(newSalt);
	    user.setPasswordHash(newHashed);
	    userRepository.save(user);
	    return true;
	}

	
	
}