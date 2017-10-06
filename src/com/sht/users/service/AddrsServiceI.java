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
	public void updateAddress(CustomAddrs po) throws Exception;

	/**
	 * 删除收货地址
	 * 
	 */
	public void deleteAddress(CustomAddrs po) throws Exception;

	/**
	 * 
	 * 显示收货地址
	 */
	public List<CustomAddrs> displayAddrs(CustomAddrs po) throws Exception;

	/**
	 * 
	 * 根据ID查询收货地址
	 */
	public CustomAddrs selectAddrsByID(CustomAddrs po);

	/**
	 * 设置默认收货地址
	 * 
	 **/
	public void updateDefault(CustomAddrs po);

}
