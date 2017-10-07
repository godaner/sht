package com.sht.users.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.AddrsMapper;
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
	@Autowired
	private AddrsMapper addrsMapper;

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
		if(po.getIsdefault()==1){
		customUsersMapper.updateDefault(po);
		}
		customUsersMapper.addAddress(po);
		

	}

	@Override
	public void updateAddress(CustomAddrs po) {
		if(po.getIsdefault()==1){
			customUsersMapper.updateDefault(po);
		}
		addrsMapper.updateByPrimaryKeySelective(po);
//		customUsersMapper.updateAddress(po);
	}

	@Override
	public void deleteAddress(CustomAddrs po) {
		customUsersMapper.deleteAddress(po);
		
	}

	@Override
	public List<CustomAddrs> displayAddrs(CustomAddrs po) {
		List<CustomAddrs> addrsList=customUsersMapper.selectAllAddress(po);
		return addrsList;
	}

	@Override
	public CustomAddrs selectAddrsByID(CustomAddrs po) {
		CustomAddrs addrs=customUsersMapper.selectAddrsByID(po);
		return addrs;
	}

	@Override
	public void updateDefault(CustomAddrs po) {
		customUsersMapper.updateDefault(po);
		customUsersMapper.updateDefaults(po);
	}

}
