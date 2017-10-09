package com.sht.goods.service;

import com.sht.goods.po.GUser;
import com.sht.po.Users;

public interface UsersServiceI {

	/**
	 * 更改用户余额
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int updateUsersMoney(GUser user)throws Exception;
	
	/**
	 * 根据用户id查询用户信息
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Users selectUsersInfo(String id)throws Exception;
}
