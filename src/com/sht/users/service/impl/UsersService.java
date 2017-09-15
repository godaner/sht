package com.sht.users.service.impl;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.UsersMapper;
import com.sht.users.mapper.CustomUsersMapper;
import com.sht.users.po.CustomUsers;
import com.sht.users.service.UsersServiceI;
/**
 * Title:UsersService
 * <p>
 * Description:用户业务接口实现
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:24:50
 * @version 1.0
 */
@Service
public class UsersService extends UBaseService implements UsersServiceI {
	@Autowired
	private CustomUsersMapper customUsersMapper;

	@Autowired
	private UsersMapper usersMapper;
	
	@Override
	public CustomUsers login(CustomUsers po) throws Exception {
		
		logger.info("UsersService");
		
		CustomUsers dbUser = customUsersMapper.selectUserByUsername((String) po.getUsername());
		
		//判断用户是否存在
		if(dbUser != null){
			//判断密码
			if(dbUser.getPassword().equals(md5(po.getPassword()))){
				return dbUser;
			}else{ 
				eject(false,"密码错误");
			}
		}else{
			eject(false, "用户不存在");
		}
		
		return dbUser;
		
		
		
	}

	@Override
	public void regist(CustomUsers po) throws Exception {
		
		CustomUsers dbUser = customUsersMapper.selectUserByUsername((String) po.getUsername());
		
		//用户名相同
		eject(null!=dbUser && dbUser.getUsername().equals(po.getUsername()), "用户已存在");
		
		po.setId(UUID.randomUUID().toString());
		
		po.setIsdelete("0");
		
		po.setLocked("0");
		
		po.setSalt("");
		
		usersMapper.insert(po);
		
	}
	

	
	
}
