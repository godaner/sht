package com.sht.goods.service;


import java.util.List;

import com.sht.goods.po.GFiles;
import com.sht.goods.po.GGoods;
import com.sht.goods.po.GGoodsImgs;

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
	public List<GGoods> dispalyGoodsInfo() throws Exception;
	
	/**
	 * 
	 * createGoodsInfo
	 * <p>
	 * Description:insert goods info
	 */
	public String createGoodsInfo(GGoods goods) throws Exception;
	
	/**
	 * 
	 * createGoodsImagsInfo
	 * <p>
	 * Description:insert goodsImags info
	 */
	public String createGoodsImagsInfo(GGoodsImgs goodsImgs) throws Exception;
	
	/**
	 * 
	 * createGoodsFileInfo
	 * <p>
	 * Description:insert imags  info into file
	 */
	public String createGoodsFileInfo(GFiles files) throws Exception;
}
