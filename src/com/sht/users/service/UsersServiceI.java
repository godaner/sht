package com.sht.users.service;

import com.sht.users.po.CustomUsers;

/**
 * Title:UsersServiceI
 * <p>
 * Description:用户业务接口
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:25:06
 * @version 1.0
 */
public interface UsersServiceI {
	/**
	 * Title:selectUserByUsername
	 * <p>
	 * Description:通过username查询一个user;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 上午11:30:29
	 * @version 1.0
	 * @param username
	 * @return
	 */
	public CustomUsers selectUserByUsername(String username);
}
