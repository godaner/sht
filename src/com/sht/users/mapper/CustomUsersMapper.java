package com.sht.users.mapper;

import org.apache.ibatis.annotations.Param;

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
	 * Description:通过username查询一个user（登陆）;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 上午11:30:29
	 * @version 1.0
	 * @param username
	 * @return
	 */
	public CustomUsers selectUserByUsername(String username);
	
	/**
	 * 根据email查询一个user（登陆）
	 * 
	 */
	public CustomUsers selectUserByEmail(String email);
	
	/**
	 * 根据username查询一个user（注册）
	 * 
	 */
	public CustomUsers selectUserByUsername_reg(String email);
	/**
	 * 根据email查询一个user（注册）
	 * 
	 */
	public CustomUsers selectUserByEmail_reg(String email);
	
	/**
	 * 增加一个user
	 */
	public CustomUsers insertUser(CustomUsers po);
	
	/**
	 * @param email:根据email激活账户
	 */
	public void updateStatusByEmail(String email);
	
	/**
	 * 根据用户id获取发布信息
	 * @param id
	 * @return 
	 */
	public com.sht.po.Goods getGoodsById(String id);

	
	/**
	 * 
	 * 更新用户信息
	 * @param id
	 */
	public void updatePersonalInfo(CustomUsers po);
	
	/**
	 * 
	 * 上传用户头像
	 * @param fileName
	 * @param id
	 */

	public void personalImgUpload(CustomUsers po);

}
