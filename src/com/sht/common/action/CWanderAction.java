package com.sht.common.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.action.BaseAction;
import com.sht.common.po.CWanderLog;
import com.sht.common.service.CWanderServiceI;


/**
 * @author tom
 * 全局action
 */
@Controller
@Scope("prototype")
public class CWanderAction extends BaseAction<CWanderLog, CWanderServiceI>{
	
	public void insertWanderInfo(){
        try {
			service.insertWanderLog(po);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        
	}
}
