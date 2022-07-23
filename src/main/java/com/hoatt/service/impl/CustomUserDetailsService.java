package com.hoatt.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hoatt.constant.SystemConstant;
import com.hoatt.dto.MyUser;
import com.hoatt.entity.RoleEntity;
import com.hoatt.entity.UserEntity;
import com.hoatt.repository.IUserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private IUserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserEntity userEntity = userRepository.findOneByUserNameAndStatus(username, SystemConstant.ACTIVE_STATUS);
		
		if (userEntity == null) {
			throw new UsernameNotFoundException("User not found");
		}
		
		// Cac quyen co trong he thong
		List<GrantedAuthority> authorities = new ArrayList<>();
		for (RoleEntity role : userEntity.getRoleEntities()) {
			authorities.add(new SimpleGrantedAuthority(role.getCode()));
		}
		
		// Put quyen va thong tin cho user vua dang nhap de duy tri
		MyUser myUser = new MyUser(userEntity.getUserName(), userEntity.getPassword(), true, true, true, true, authorities);
		myUser.setFullName(userEntity.getFullName());
		return myUser;
	}
}
