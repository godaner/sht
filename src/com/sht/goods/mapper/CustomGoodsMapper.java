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
public interface CustomGoodsMapper {

	/**
	 * Title:selectAllGoodsInfo
	 * <p>
	 * Description:查询所有的商品信息
	 * <p>
	 
	 */

	public List<GGoods> selectAllGoodsInfo();
	
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
	
	
	
}
