package com.sht.users.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.RegionMapper;
import com.sht.po.Region;
import com.sht.po.RegionExample;
import com.sht.po.RegionExample.Criteria;
import com.sht.service.impl.BaseService;
import com.sht.users.po.URegion;
import com.sht.users.service.URegionServiceI;

/**
 * @author Administrator
 * region业务接口实现;
 *
 */
@Service
public class URegionService extends BaseService implements URegionServiceI {

	
	@Autowired
	private RegionMapper regionMapper;
	
	
	@Override
	public URegion getRegionByPid(Integer pid) throws Exception {
		
		/**
		 * 放置查询条件
		 */
		RegionExample example = new RegionExample();
		
		Criteria criteria = example.createCriteria();
		
		criteria.andPidEqualTo(pid);
		
		/**
		 * 查询
		 */
		List<Region> childs = regionMapper.selectByExample(example);
		
		
		URegion ur = new URegion();
		
		
		ur.setChilds(childs);
		
		return ur;
	}
	
}
