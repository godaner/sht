package com.sht.goods.mapper;

import java.util.List;
import com.sht.goods.po.GGoods;
import com.sht.po.Files;
import com.sht.po.Goods;


/**
 * Title:CustomGoodsMapper
 * <p>
 * Description:自定义本模块mapper接口
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:28:36
 * @version 1.0
 */
public interface GCustomGoodsMapper {

	/**
	 * Title:selectAllGoodsInfo
	 * <p>
	 * Description:查询所有的商品信息
	 * <p>
	 * @param i 
	 
	 */

	public List<GGoods> selectAllGoodsInfo(GGoods goods);
	
	/**
	 * insert goods info
	 * <p>
	 * Description:发布商品
	 * <p>
	 
	 */
	public void insert(Goods goods);
	
	/**
	 * insert files info
	 * <p>
	 * Description:发布商品
	 * <p>
	 
	 */
	public void insert(Files files);
	
	/**
	 * 查询商品的总数量
	 * 
	 * @return
	 */
	public Double selectGoodsTotalNum(GGoods goods);
	
	
	
}
