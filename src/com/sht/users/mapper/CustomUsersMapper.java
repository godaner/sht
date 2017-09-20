package com.sht.users.mapper;

import com.sht.users.po.CustomUsers;

/**
 * Title:CustomUsersMapper
 * <p>
 * Description:自定义用户mapper接口
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:28:36
 * @version 1.0
 */
public interface CustomUsersMapper {
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
	
	/**
	 * 增加一个user
	 */
	public CustomUsers insertUser(CustomUsers po);
}
