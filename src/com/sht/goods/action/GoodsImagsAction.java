package com.sht.goods.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.CustomGoodsImgs;
import com.sht.goods.service.GoodsServiceI;

@Controller
@Scope("prototype")
public class GoodsImagsAction extends GBaseAction<CustomGoodsImgs, GoodsServiceI> {
	
	
	public void createGoodsImagsInfo() throws Exception{
		logger.info("GoodsImagsAction");
		try {
			service.createGoodsImagsInfo(po);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
