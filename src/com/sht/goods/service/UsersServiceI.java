package com.sht.goods.service;

import com.sht.goods.po.GUser;

public interface UsersServiceI {

	/**
	 * 更改用户余额
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int updateUsersMoney(GUser user)throws Exception;
}
