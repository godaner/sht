package com.sht.goods.service;


import java.util.List;

import com.sht.goods.po.CustomGoods;
import com.sht.goods.po.Goods;

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
	 
	 */
	public List<CustomGoods> dispalyGoodsInfo() throws Exception;
	
	/**
	 * 
	 * createGoodsInfo
	 * <p>
	 * Description:insert goods info
	 */
	public void createGoodsInfo(Goods goods) throws Exception;
	
}
