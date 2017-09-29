package com.sht.goods.service;

import java.util.List;

import com.sht.goods.po.GRegion;

public interface RegionServiceI {
	
	/**
	 * 查询所有的省份信息
	 * @return
	 * @throws Exception
	 */
	public List<GRegion> selectAllProvices() throws Exception;

}
