package com.sht.users.service;

import java.util.List;

import com.sht.users.po.UGoods;


/**
 * 
 * 用户 -商品 业务实现接口
 * @author yyfjsn
 *
 */
public interface UGoodsServiceI {
	/**
	 * 根据id 获取已发布的信息
	 * @param id
	 * @param pageEnd 
	 * @param pageStar 
	 * @return 
	 * @throws Exception 
	 */

	public List<UGoods> getGoodsById(String id, String pageStar, String pageEnd) throws Exception;

	
	/**
	 * 
	 * 根据id获取商品的数量
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	public int getGoodsCountById(String id) throws Exception;

	/**
	 * 根据title获取商品信息
	 * @param title
	 * @param pageStar
	 * @param pageEnd
	 * @param pageEnd2 
	 * @return
	 * @throws Exception 
	 */
	public List<UGoods> searchUGoodsBytitle(String title, String pageStar,String pageEnd) throws Exception;


	public UGoods getGoodsDetailById(String id) throws Exception;


	public void deleteGoodsByid(String id);


	public void UpdateUGoodsById(UGoods po);
}
