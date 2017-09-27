package com.sht.users.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.GoodsMapper;
import com.sht.po.Goods;
import com.sht.users.mapper.UGoodsMapper;
import com.sht.users.po.UGoods;
import com.sht.users.service.UGoodsServiceI;
@Service
public class UGoodsService extends UBaseService implements UGoodsServiceI {

@Autowired
private UGoodsMapper UGoodsMapper;

@Autowired
private GoodsMapper GoodsMapper;

@Override
public List<UGoods> getGoodsById(String id, String pageStar, String pageEnd) throws Exception {
	
	logger.info("service");
	
	List<UGoods> dbGoods = UGoodsMapper.getGoodsById(id, pageStar,pageEnd);
	
	eject(dbGoods == null, "您还未发布任何信息");
	
	return dbGoods;
}

@Override
public int getGoodsCountById(String id) throws Exception {
	
	int goodsCount = UGoodsMapper.getGoodsCountById(id);
	
	eject(goodsCount==0, "您还未发布任何信息");
	
	return goodsCount;
}

@Override
public List<UGoods> searchUGoodsBytitle(String title, String pageStar,String pageEnd) throws Exception {
	
	List<UGoods> dbGoods = UGoodsMapper.searchUGoodsBytitle(title, pageStar,pageEnd);
	
	eject(dbGoods == null, "无匹配信息");
	
	return dbGoods;
}

@Override
public UGoods getGoodsDetailById(String id) throws Exception {
		
	UGoods dbGoods = UGoodsMapper.getGoodsDetailById(id);
	
	eject(dbGoods==null, "不存在该商品");
	
	return dbGoods;
}

@Override
public void deleteGoodsByid(String id) {

	UGoodsMapper.deleteGoodsByid(id);
	
}

@Override
public void UpdateUGoodsById(UGoods po) {

	UGoodsMapper.UpdateUGoodsById(po);
	
}





}
