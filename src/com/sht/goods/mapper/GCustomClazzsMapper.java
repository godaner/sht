package com.sht.goods.mapper;

import java.util.List;

import com.sht.goods.po.GClazzs;


/**
 * Title:CustomClazzsMapper
 * <p>
 * Description:自定义本模块mapper接口
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:28:36
 * @version 1.0
 */
public interface GCustomClazzsMapper {

	/**
	 * Title:selectAllGoodsInfo
	 * <p>
	 * Description:查询所有的商品类别
	 * <p>
	 * @param i 
	 
	 */
	public List<GClazzs> selectAllClazzs() throws Exception;
	
	/**
	 * 查询商品类别
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String selectGoodsClazz(String id) throws Exception;
	
	/**
	 * 修改商品总类别数量
	 * @param clazzs
	 * @return
	 * @throws Exception
	 */
	public int updateClazzNum(String id)throws Exception;
	
}
