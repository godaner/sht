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
	/**
	 * 
	 * 根据id获取商品信息
	 * @param id
	 * @return
	 * @throws Exception
	 */

	public UGoods getGoodsDetailById(String id) throws Exception;

	/**
	 * 
	 * 根据id删除商品信息
	 * @param id
	 */
	public void updateGoodsByidAndStatus(UGoods po);

	/**
	 * 
	 * 更新商品信息
	 * @param po
	 */
	public void UpdateUGoodsById(UGoods po);

	/**
	 * 
	 * 根据id和status查询指定的商品
	 * @param id
	 * @param status
	 * @param pageStar
	 * @param pageEnd
	 * @return
	 * @throws Exception 
	 */
	public List<UGoods> getGoodsByIdAndStatus(String id, String status,
			String pageStar, String pageEnd) throws Exception;
	/**
	 * 通过id获取已购买的商品信息
	 * 
	 * @param id
	 * @return
	 * @throws Exception 
	 */

	public int getBuyGoodsCountById(String id) throws Exception;

	/**
	 * 根据id获取购买信息
	 * 
	 * @param id
	 * @param pageStar
	 * @param pageEnd
	 * @return
	 * @throws Exception 
	 */
	public List<UGoods> getBuyGoodsById(String id, String pageStar,
			String pageEnd) throws Exception;

	/**
	 * 
	 * 根据id和status获取购买信息
	 * @param id
	 * @param status
	 * @param pageStar
	 * @param pageEnd
	 * @return
	 * @throws Exception 
	 */
	public List<UGoods> getBuyGoodsByIdAndStatus(String id, String status,
			String pageStar, String pageEnd) throws Exception;

	/**
	 * 
	 * 根据title查找购买信息
	 * @param title
	 * @param pageStar
	 * @param pageEnd
	 * @return
	 * @throws Exception 
	 */
	public List<UGoods> searchBuyUGoodsBuyBytitle(String title,
			String pageStar, String pageEnd) throws Exception;
	/**
	 * 
	 *根据id和status对购买商品进行相应操作
	 * @param id
	 */
	public void udateBuyGoodsByidAndStatus(UGoods po);


	public void goodsCheckImgUpload(UGoods po);


	
}
