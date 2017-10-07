package com.sht.goods.service;

import java.util.List;

import com.sht.goods.po.GAddrs;

public interface GAddrServiceI {
	
	/**
	 * 获取所有的收货地址
	 * @return
	 * @throws Exception
	 */
	public List<GAddrs> selectAddrsByUser(String id) throws Exception;

	
}
