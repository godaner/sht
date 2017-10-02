package com.sht.goods.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GRegion;
import com.sht.goods.service.RegionServiceI;

@Controller
@Scope("prototype")
public class GRegionAction extends GBaseAction<GRegion, RegionServiceI> {

	public void selectAllRegions() throws Exception{
		info("GRegionAction-selectAllRegions");
		List<GRegion> regionList = getList();
		try {
			regionList = service.selectAllRegions(po);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		writeJSON(regionList);
	}
}
