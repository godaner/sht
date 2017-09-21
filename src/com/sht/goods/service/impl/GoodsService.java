package com.sht.goods.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.CustomGoodsMapper;
import com.sht.goods.po.CustomGoods;
import com.sht.goods.service.GoodsServiceI;
import com.sht.mapper.GoodsMapper;


/**
 * Title:UsersService
 * <p>
 * Description:用户业务接口实现
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:24:50
 * @version 1.0
 */
@Service
public class GoodsService extends GBaseService implements GoodsServiceI {
	@Autowired
	private CustomGoodsMapper customGoodsMapper;

	@Autowired
	private GoodsMapper goodsMapper;
	
	
	@Override
	public CustomGoods dispalyGoodsInfo(CustomGoods po) throws Exception {
		
		return null;
	}
	
	
}
