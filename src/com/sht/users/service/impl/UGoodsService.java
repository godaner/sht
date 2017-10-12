package com.sht.users.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.mapper.GoodsMapper;
import com.sht.users.mapper.UGoodsMapper;
import com.sht.users.po.UGoods;
import com.sht.users.service.UGoodsServiceI;
import com.sht.util.Static.CONFIG;
@Service
public class UGoodsService extends UBaseService implements UGoodsServiceI {

@Autowired
private UGoodsMapper UGoodsMapper;

@Autowired
private GoodsMapper GoodsMapper;

@Override
public List<UGoods> getGoodsById(String id, String pageStar, String pageEnd) throws Exception {
	
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
public void updateGoodsByidAndStatus(UGoods po) {

	UGoodsMapper.updateGoodsByidAndStatus(po);
	
}


@Override
public void UpdateUGoodsById(UGoods po) {
	
	po.setLastupdatetime(new Timestamp(new Date().getTime()));

	UGoodsMapper.UpdateUGoodsById(po);
	
}

@Override
public List<UGoods> getGoodsByIdAndStatus(String id, String status,
	String pageStar, String pageEnd) throws Exception {
	
	List<UGoods> dbGoods = UGoodsMapper.getGoodsByIdAndStatus(id,status,pageStar,pageEnd);
	
	eject(dbGoods == null, "您还未发布任何信息");
	
	return dbGoods;
}

@Override
public int getBuyGoodsCountById(String id) throws Exception {
	
	int goodsCount = UGoodsMapper.getBuyGoodsCountById(id);
	
	eject(goodsCount==0, "您还未发布任何信息");
	
	return goodsCount;
}

@Override
public List<UGoods> getBuyGoodsById(String id, String pageStar, String pageEnd) throws Exception {

	List<UGoods> dbGoods = UGoodsMapper.getBuyGoodsById(id, pageStar,pageEnd);
	
	eject(dbGoods == null, "您还未购买任何商品");
	
	return dbGoods;
}

@Override
public List<UGoods> getBuyGoodsByIdAndStatus(String id, String status,
		String pageStar, String pageEnd) throws Exception {
	
	List<UGoods> dbGoods = UGoodsMapper.getBuyGoodsByIdAndStatus(id,status,pageStar,pageEnd);
	
	eject(dbGoods == null, "您还未发布任何信息");
	
	return dbGoods;
}

@Override
public List<UGoods> searchBuyUGoodsBuyBytitle(String title, String pageStar,
		String pageEnd) throws Exception {
	
	List<UGoods> dbGoods = UGoodsMapper.searchBuyUGoodsBuyBytitle(title, pageStar,pageEnd);
	
	eject(dbGoods == null, "无匹配信息");
	
	return dbGoods;
}

@Override
public void udateBuyGoodsByidAndStatus(UGoods po) {
	//收货时
	if(po.getStatus()==-1){
		
		po.setFinishtime(new Timestamp(new Date().getTime()));
		
		UGoods dbGoods = UGoodsMapper.getGoodsDetailById(po.getId());
		
		//给卖家打款
		
		UGoodsMapper.solderAddMoney(dbGoods);
		
		//给买家加积分
		UGoodsMapper.buyerAddScore(dbGoods);
		
		
		//  取消购买
	}else if(po.getStatus()==-3){
		
		UGoods dbGoods = UGoodsMapper.getGoodsDetailById(po.getId());
		
		//给买家打款
		
		UGoodsMapper.buyerAddMoney(dbGoods);
		
	}
	
	UGoodsMapper.udateBuyGoodsByidAndStatus(po);
}

@Override
public void goodsCheckImgUpload(UGoods po) {

	 
	 String savePath = getValue(CONFIG.FILED_SRC_RETURN_MONEY_BILL).toString();
	 
	 String fileName = po.getId()+".jpg";
	 
	 writeFileToDisk(po.getFiile(), savePath, fileName);
	 
	 po.setRefusereturnmoneybill(fileName);
	 
	 UGoodsMapper.goodsCheckImgUpload(po);
	
}

}
