package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GRegion;
import com.sht.goods.service.RegionServiceI;

@Controller
@Scope("prototype")
public class GRegionAction extends GBaseAction<GRegion, RegionServiceI> {

	public void selectAllProvices() throws Exception{
		info("GRegionAction-selectAllProvices");
		List<GRegion> regionList = null;
		try {
			regionList = service.selectAllProvices();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		writeJSON(regionList);
	}
}
