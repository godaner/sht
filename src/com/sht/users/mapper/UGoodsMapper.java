package com.sht.users.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sht.users.po.UGoods;

/**
 * 
 * 自定义用户-商品接口
 * 
 * @author yyfjsn
 *
 */
public interface UGoodsMapper {

	List<UGoods> getGoodsById(@Param("id")String id, @Param("pageStar")String pageStar, @Param("pageEnd")String pageEnd);
	
	List<UGoods> searchUGoodsBytitle(@Param("title")String title, @Param("pageStar")String pageStar, @Param("pageEnd")String pageEnd);

	int getGoodsCountById(String id);

	UGoods getGoodsDetailById(String id);

	void deleteGoodsByid(String id);

	void UpdateUGoodsById(UGoods po);

}
