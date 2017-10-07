package com.sht.users.mapper;

import java.util.List;

import com.sht.users.po.CustomAddrs;
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
	
	/**
	 * 新增收货地址
	 *
	 **/
	public CustomAddrs addAddress(CustomAddrs po);

	/**
	 * 修改收货地址
	 */
	public void updateAddress(CustomAddrs po);

	/**
	 * 
	 * 删除收货地址
	 */
	public void deleteAddress(CustomAddrs po);
	
	/**
	 * 
	 * 显示收货地址
	 */
	public List<CustomAddrs> selectAllAddress(CustomAddrs po);

	/**
	 * 根据ID查询收货地址
	 *
	 */
	public CustomAddrs selectAddrsByID(CustomAddrs po);
	
	/**
	 * 支付宝充值成功后的回调
	 * 
	 * @param po
	 */

	public void addMoney(CustomUsers po);

	
	/**
	 * 
	 * 获取用户余额
	 * @param po
	 * @return 
	 */
	public CustomUsers getMoneyById(CustomUsers po);

	
	/**
	 * 根据email更改密码
	 * 
	 * @param po
	 */
	public void changePasswordByEmail(CustomUsers po);
	
	/**
	 * 根据username更改密码
	 * 
	 * @param po
	 */

	public void changePasswordByUsername(CustomUsers po);

}
