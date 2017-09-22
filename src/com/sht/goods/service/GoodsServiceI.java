package com.sht.goods.service;


import java.util.List;

import com.sht.goods.po.CustomGoods;

/**
 * Title:GoodsServiceI
 * <p>
 * Description:本模块业务接口
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:25:06
 * @version 1.0
 */
public interface GoodsServiceI {
	
	/**
	 * 
	 * Title:displayGoodsInfo
	 * <p>
	 * Description:Display the goods' first page information
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:22:34
	 * @version 1.0
	 * @param po
	 * @return
	 * @throws Exception 登录成功返回数据库的用户数据
	 */

	public List<CustomGoods> dispalyGoodsInfo() throws Exception;

	
}
