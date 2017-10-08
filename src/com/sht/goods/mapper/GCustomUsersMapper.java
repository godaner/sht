package com.sht.goods.mapper;

import com.sht.goods.po.GUser;


/**
 * Title:CustomClazzsMapper
 * <p>
 * Description:自定义本模块mapper接口
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:28:36
 * @version 1.0
 */
public interface GCustomUsersMapper {

	/**
	 * Title:updateUsersMoney
	 * <p>
	 * Description:更用户余额
	 * <p>
	 * @param i 
	 
	 */
	public int updateUsersMoney(GUser user);
	
}
