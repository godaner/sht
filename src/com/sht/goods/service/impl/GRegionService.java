package com.sht.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.CustomRegionMapper;
import com.sht.goods.po.GRegion;
import com.sht.goods.service.RegionServiceI;
@Service
public class GRegionService extends GBaseService implements RegionServiceI {

	@Autowired
	private CustomRegionMapper customRegionMapper;
	
	/**
	 * 查询所有省份信息
	 */
	@Override
	public List<GRegion> selectAllProvices() throws Exception {
		// TODO Auto-generated method stub
		List<GRegion> regionList = customRegionMapper.selectAllProvices();
		return regionList;
	}
	
}
