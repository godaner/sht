package com.sht.users.service;

import java.util.List;

import com.sht.users.po.CustomAddrs;

public interface AddrsServiceI {
	
	/**
	 * 新增地址
	 * 
	 */
	public void addAddress(CustomAddrs po) throws Exception;
	
	/**
	 * 修改收货地址
	 */
	public void updateAddress(CustomAddrs po);

	/**
	 * 删除收货地址
	 * 
	 */
	public void deleteAddress(CustomAddrs po);

	/**
	 * 
	 * 显示收货地址
	 */
	public List<CustomAddrs> displayAddrs(CustomAddrs po);

	/**
	 * 
	 * 根据ID查询收货地址
	 */
	public CustomAddrs selectAddrsByID(CustomAddrs po);

}
