package com.sht.users.service.impl;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.UsersMapper;
import com.sht.users.mapper.CustomUsersMapper;
import com.sht.users.po.CustomAddrs;
import com.sht.users.service.AddrsServiceI;

@Service
public class AddrsService extends UBaseService implements AddrsServiceI {
	
	@Autowired
	private CustomUsersMapper customUsersMapper;
	
	@Autowired
	private UsersMapper usersMapper;

	@Override
	public void addAddress(CustomAddrs po) throws Exception {
		
		po.setId(UUID.randomUUID().toString());
		
		po.setMaster(po.getMaster());
		
		po.setRegion(po.getRegion());
		
		po.setDetail(po.getDetail());
		
		po.setPohne(po.getPohne());
		
		po.setPostcode(po.getPostcode());
		
		po.setRealname(po.getRealname());
		
		po.setIsdefault(po.getIsdefault());
		
		customUsersMapper.addAddress(po);
		

	}

}
