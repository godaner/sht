package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GAddrs;
import com.sht.goods.service.GAddrServiceI;

@Controller
@Scope("prototype")
public class GAddrAction extends GBaseAction<GAddrs, GAddrServiceI> {
	
	public void selectAddrs() throws Exception{
		info("GAddrAction--selectAddrs");
		List<GAddrs> addrsList = getList();
		try {
			addrsList = service.selectAddrsByUser(po.getMaster());
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		writeJSON(addrsList);
	}
}
