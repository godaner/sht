package com.sht.users.action;

import java.util.UUID;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.users.po.CustomAddrs;
import com.sht.users.po.CustomUsers;
import com.sht.users.service.AddrsServiceI;
import com.sht.users.service.UsersServiceI;

@Scope("prototype")
@Controller
public class AddressAction  extends UBaseAction<CustomAddrs,AddrsServiceI>{
	
	
	/**
	  * 新增收货地址
	  */
	 public void addAddress() throws Exception{
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 eject(cs==null,"未登入");
		 po.setId(cs.getId());
		 try{
			 String uuid = UUID.randomUUID().toString();
			 service.addAddress(po);
		 }catch(Exception e){
			 e.printStackTrace();
//			 po.setMsg(e.getMessage());
		 }
		 writeJSON(po);
//		 po.setMsg(null);
	 }

}
