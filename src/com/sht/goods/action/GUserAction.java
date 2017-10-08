package com.sht.goods.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GUser;
import com.sht.goods.service.UsersServiceI;

@Controller
@Scope("prototype")
public class GUserAction extends GBaseAction<GUser, UsersServiceI> {

	public void updateUsersMoney() throws Exception{
		info("GUserAction--updateUsersMoney");
		int result = -1;
		try {
			
			result = service.updateUsersMoney(po);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		writeJSON(result);
	}
	
	public void selectUsersInfo()throws Exception{
		info("GUserAction--selectUsersInfo");
		GUser user = new GUser();
		try {
			user = service.selectUsersInfo(po.getId());
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		writeJSON(user);
	}
}
