package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.common.action.CGoodsAction;
import com.sht.common.po.CGoods;
import com.sht.goods.po.GFiles;
import com.sht.goods.po.GGoods;
import com.sht.goods.service.GoodsServiceI;
import com.sht.po.Goods;
import com.sht.util.Static;



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
public class GoodsAction extends GBaseAction<GGoods,GoodsServiceI> {
	
	private CGoodsAction cGoodsAction;
	
	
	/**
	 * Title:showInfo
	 * <p>
	 * Description:显示商品主页面信息
	 * <p>
	 * 
	 */
	public void showInfo() throws Exception{
		logger.info("GoodsAction-showInfo");

		List<GGoods> goodsList = null;
	
		po.setMaxLine(po.getMinLine()+Static.GOODS.FILED_PAGE_SIZE);
		
		try {
			goodsList = service.dispalyGoodsInfo(po);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			//setSessionAttr(name, value)
		}
		
		//返回一个json的数据
		writeJSON(goodsList);

	}
	
	/**
	 * Title:selectGoodsAllNum
	 * <p>
	 * Description:查询商品总数量
	 * <p>
	 * 
	 */
	public void selectGoodsAllNum() throws Exception{
		info("select goods total num [by region]");
		double totalNum =0;
		try {
			totalNum = service.selectGoodsAllNum(po.getRegion());
			 
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		writeJSON(totalNum);
	}
	
	
	/**
	 * Title:createGoods
	 * <p>
	 * Description:发布商品
	 * <p>
	 * 
	 */
	public String createGoods() throws Exception{
		logger.info("GoodsAction-createGoods");
		
		try {
			 service.createGoodsInfo(po);
			 setSessionAttr("isCreate", "true");
		} catch (Exception e) {
			e.printStackTrace();
			setSessionAttr("isCreate", "false");
		}
		
		return "fCreateGodos";
		
	}
	
	
	
	
}
