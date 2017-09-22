package com.sht.common.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.action.BaseAction;
import com.sht.common.po.CustomWanderLog;
import com.sht.common.service.WanderServiceI;


/**
 * @author tom
 * 全局action
 */
@Controller
@Scope("prototype")
public class WanderAction extends BaseAction<CustomWanderLog, WanderServiceI>{
	
	public void insertWanderInfo(){
        try {
			service.insertWanderLog(po);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        
	}
}
