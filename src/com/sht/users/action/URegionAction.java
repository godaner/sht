package com.sht.users.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.action.BaseAction;
import com.sht.users.po.URegion;
import com.sht.users.service.URegionServiceI;

/**
 * @author Administrator
 * region的action
 *
 */
@Controller
@Scope("prototype")
public class URegionAction extends BaseAction<URegion, URegionServiceI> {
	public void getRegionByPid(){
		try{
			
			po = service.getRegionByPid(po.getPid());
			
			
		}catch(Exception e){
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
		}
		po.setMsg(null);
		//返回一个json的数据
		writeJSON(po);
	}
	
	public void getRegionById(){
		try{
			po = service.getRegionById(po.getId());
		}catch(Exception e){
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
		}
		po.setMsg(null);
		//返回一个json的数据
		writeJSON(po);
		
	
	}
	
}
