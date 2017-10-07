package com.sht.users.service;

import com.sht.users.po.URegion;

/**
 * @author Administrator
 * region业务接口;
 *
 */
public interface URegionServiceI {

	/**
	 * @return
	 * @throws Exception
	 * 通过pid获取子节点;
	 */
	URegion getRegionByPid(Integer pid) throws Exception;

	URegion getRegionById(Integer id) throws Exception;

}
