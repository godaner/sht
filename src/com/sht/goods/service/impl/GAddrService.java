package com.sht.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.GCustomAddrsMapper;
import com.sht.goods.po.GAddrs;
import com.sht.goods.service.GAddrServiceI;
import com.sht.mapper.AddrsMapper;
@Service
public class GAddrService extends GBaseService implements GAddrServiceI {
	@Autowired
	private AddrsMapper addrMapper;
	
	@Autowired
	private GCustomAddrsMapper customAddrsMapper;
	

	@Override
	public List<GAddrs> selectAddrsByUser(String id) throws Exception {
		// TODO Auto-generated method stub
		List<GAddrs> list =   customAddrsMapper.selectAddrsByUser(id);
		return list;
	}

}
