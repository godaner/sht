package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GClazzs;
import com.sht.goods.service.ClazzsServiceI;
@Controller
@Scope("prototype")
public class GClazzsAction extends GBaseAction<GClazzs, ClazzsServiceI> {
	
	/**
	 * Title:selectCategoryGoods
	 * <p>
	 * Description:查询商品总类别
	 * <p>
	 * 
	 */
	public void selectCategoryGoods() throws Exception{
		info("select general category of goods");
		List<GClazzs> goodsClazzs = getList();
		try {
			goodsClazzs = service.selectAllClazzs(po);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		writeJSON(goodsClazzs);
	}
}
