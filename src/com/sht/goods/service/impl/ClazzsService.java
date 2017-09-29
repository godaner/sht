package com.sht.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.CustomClazzsMapper;
import com.sht.goods.po.GClazzs;
import com.sht.goods.service.ClazzsServiceI;

@Service
public class ClazzsService extends GBaseService implements ClazzsServiceI {

	@Autowired
	private CustomClazzsMapper customClazzsMapper;
	
	@Override
	public List<GClazzs> selectAllClazzs(GClazzs clazzs) throws Exception {
		// TODO Auto-generated method stub
		List<GClazzs> clazzsList = customClazzsMapper.selectAllClazzs();
		
		return clazzsList;
	}

}
