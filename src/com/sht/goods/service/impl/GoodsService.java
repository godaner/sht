package com.sht.goods.service.impl;



import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.CustomGoodsMapper;
import com.sht.goods.po.CustomGoods;
import com.sht.goods.po.CustomGoodsImgs;
import com.sht.goods.service.GoodsServiceI;
import com.sht.mapper.GoodsImgsMapper;
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
	
	@Autowired
	private GoodsImgsMapper goodsImgsMapper;
	
	/**
	 * 	显示商品主页面商品信息
	 */
	@Override

	public List<CustomGoods> dispalyGoodsInfo() throws Exception {
		List<CustomGoods> dbGoods = customGoodsMapper.selectAllGoodsInfo();
		logger.info("GoodsService");
		eject(dbGoods == null || dbGoods.size() == 0, "无商品信息");
		
		return dbGoods;

	}

	/**
	 * 发布商品信息
	 */
	@Override
	public void createGoodsInfo(CustomGoods goods) throws Exception {
		// TODO Auto-generated method stub
		goods.setId(uuid());
		
		goods.setCreatetime(new Date());
		
		int result = goodsMapper.insert(goods);
		
		System.out.println(result);
	}

	/**
	 * 发布商品图片信息
	 */
	@Override
	public void createGoodsImagsInfo(CustomGoodsImgs goodsImgs) throws Exception {
		// TODO Auto-generated method stub
		goodsImgs.setId(uuid());
		goodsImgsMapper.insert(goodsImgs);
	}
	
	
	
	
}
