package com.sht.goods.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.GCustomRegionMapper;
import com.sht.goods.po.GRegion;
import com.sht.goods.service.RegionServiceI;
@Service
public class GRegionService extends GBaseService implements RegionServiceI {

	@Autowired
	private GCustomRegionMapper customRegionMapper;
	
	/**
	 * 查询所有省份信息
	 */
	@Override
	public List<GRegion> selectAllRegions(GRegion region) throws Exception {
		// TODO Auto-generated method stub
		List<GRegion> regionList = customRegionMapper.selectAllRegions(region.getPid());
		return regionList;
	}
	
}
