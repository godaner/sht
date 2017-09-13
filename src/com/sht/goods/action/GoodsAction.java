package com.sht.goods.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.CustomGoods;
import com.sht.goods.service.impl.GoodsService;


@Controller
@Scope("prototype")
public class GoodsAction extends GBaseAction<CustomGoods,GoodsService> {
	
	
}
