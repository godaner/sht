package com.sht.goods.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GUser;
import com.sht.goods.service.UsersServiceI;

@Controller
@Scope("prototype")
public class GUserAction extends GBaseAction<GUser, UsersServiceI> {

	public void updateUsersMoney() throws Exception{
		info("GoodsAction--buyGoods");
		int result = -1;
		try {
			
			result = service.updateUsersMoney(po);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		writeJSON(result);
	}
}
