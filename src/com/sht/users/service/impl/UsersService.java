package com.sht.users.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.UsersMapper;
import com.sht.service.impl.BaseService;
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
public class UsersService extends BaseService implements UsersServiceI {
	@Autowired
	private CustomUsersMapper customUsersMapper;

	@Override
	public CustomUsers selectUserByUsername(String username) {
		return customUsersMapper.selectUserByUsername(username);
	}
	
	
}
