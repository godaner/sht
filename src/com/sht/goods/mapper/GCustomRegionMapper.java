package com.sht.goods.mapper;

import java.util.List;



import com.sht.goods.po.GRegion;

public interface GCustomRegionMapper {
	
	/**
	 * 查询所有省份地区
	 * @return
	 * @throws Exception
	 */
	public List<GRegion> selectAllRegions(int pid) throws Exception;

}
