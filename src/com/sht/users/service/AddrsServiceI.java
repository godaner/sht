package com.sht.users.service;

import com.sht.users.po.CustomAddrs;

public interface AddrsServiceI {
	
	/**
	 * 新增地址
	 * 
	 **/
	public void addAddress(CustomAddrs po) throws Exception;

}
