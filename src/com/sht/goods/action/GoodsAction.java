package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.CustomGoods;
import com.sht.goods.service.impl.GoodsService;


/**
 * Title:GoodsAction
 * <p>
 * Description:本模块的action;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月13日 下午11:21:08
 * @version 1.0
 */
@Controller
@Scope("prototype")
public class GoodsAction extends GBaseAction<CustomGoods,GoodsService> {
	
	/**
	 * Title:login
	 * <p>
	 * Description:显示商品主页面信息
	 * <p>
	 * 
	 * @date 2017年9月12日 下午6:24:20
	 */
	public void showInfo() throws Exception{
		logger.info("GoodsAction");
		List<CustomGoods> goodsList = null;
		try {
			goodsList = service.dispalyGoodsInfo();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		//返回一个json的数据
		writeJSON(goodsList);
		
	}
	
	
}
