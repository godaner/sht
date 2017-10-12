package com.sht.goods.action;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.goods.po.GMessages;
import com.sht.goods.service.MessagesServiceI;
@Controller
@Scope("prototype")
public class GMessagesAction extends GBaseAction<GMessages, MessagesServiceI> {
	
	public void selectAllMessages() throws Exception{
		info("GMessagesAction--selectAllMessages");
		List<GMessages> list = getList();
		
		try {
			String id = getRequest().getParameter("id");
			list = service.selectAllMssages(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		writeJSON(list);
	}
	
	public void insertMessages() throws Exception{
		info("GMessagesAction--insertMessags");
		int result = -1;
		try {
			String msgId = po.getMessage();
			if (msgId == null || msgId.trim().isEmpty()) {
				po.setMessage(null);
			}
			
			po.setId(uuid());
			
			short a = 0;
			po.setStatus(a);
			
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			po.setCreatetime(timestamp);
			
			result = service.insertMessages(po);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		writeJSON(result);
	}
}
