package com.sht.goods.action;

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
	
	
}
