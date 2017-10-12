package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.common.action.CGoodsAction;
import com.sht.goods.po.GGoods;
import com.sht.goods.service.GoodsServiceI;
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
public class GGoodsAction extends GBaseAction<GGoods,GoodsServiceI> {
	
	
	
	/**
	 * Title:showInfo
	 * <p>
	 * Description:显示商品主页面信息
	 * <p>
	 * 
	 */
	public void showInfo() throws Exception{
		logger.info("GoodsAction-showInfo");

		List<GGoods> goodsList = getList();
	
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
			totalNum = service.selectGoodsAllNum(po);
			 
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
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
		String result = null;
		try {
			 
			 String region = getRequest().getParameter("county");
			 String condition = getRequest().getParameter("condition");
			 
			 po.setRegion(Double.valueOf(region));
			 po.setCondition(Short.valueOf(condition));
			 po.setClazz(getRequest().getParameter("clazzs"));
			 
			 result = service.createGoodsInfo(po);
			
		} catch (Exception e) {
			e.printStackTrace();
			result = "createError";
		}
		
		return result;
		
	}
	
	
	public String showGoodsDetailInfo() throws Exception{
		info("GoodsAction--showGoodsDetailInfo");
		
		try {
			GGoods goods = service.selectGoodsDetailInfo(po.getId());
			setSessionAttr("goodsDetailInfo", goods);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			setSessionAttr("goodsDetailInfo", "error");
		}
		
		return "showDetailInfo";
	}
	
	
	public void selectGoodsImgs() throws Exception{
		info("GoodsAction--selectGoodsImgs");
		
		String path = "default";
		try {
			String id = getRequest().getParameter("id");
			path = service.selectGoodsImgs(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writeJSON(path);
	}
	
	
	
	
	
}
