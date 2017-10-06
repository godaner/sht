package com.sht.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.GCustomClazzsMapper;
import com.sht.goods.po.GClazzs;
import com.sht.goods.service.ClazzsServiceI;

@Service
public class GClazzsService extends GBaseService implements ClazzsServiceI {

	@Autowired
	private GCustomClazzsMapper customClazzsMapper;
	
	@Override
	public List<GClazzs> selectAllClazzs(GClazzs clazzs) throws Exception {
		// TODO Auto-generated method stub
		List<GClazzs> clazzsList = customClazzsMapper.selectAllClazzs();
		
		return clazzsList;
	}

}
