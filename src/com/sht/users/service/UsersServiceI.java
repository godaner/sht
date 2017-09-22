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
	 * 
	 * Title:login
	 * <p>
	 * Description:用户登录
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:22:34
	 * @version 1.0
	 * @param po
	 * @return
	 * @throws Exception 登录成功返回数据库的用户数据
	 */
	public CustomUsers login(CustomUsers po) throws Exception;

	/**
	 * Title:regist
	 * <p>
	 * Description:用户注册;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:49:17
	 * @version 1.0
	 * @param po
	 * @return 
	 * @throws Exception
	 */
	public void regist(CustomUsers po) throws Exception;

	public void verifyEmail(String email) throws Exception;

}
