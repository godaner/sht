package com.sht.users.action;

import java.util.List;
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
		 po.setMaster(cs.getId());
		 try{
			 String uuid = UUID.randomUUID().toString();
			 service.addAddress(po);
		 }catch(Exception e){
			 e.printStackTrace();
//			 po.setMsg(e.getMessage());
		 }
		 writeJSON(po);
		 po.setMsg(null);
	 }
	 
	 /**
	  * 修改收货地址
	  * 
	  **/
	 public void updateAddress() throws Exception{
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 po.setMaster(cs.getId());
		 CustomAddrs ca = getSessionAttr(FILED_USER_ADDRESS);
		 try {
			 service.updateAddress(po);
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 
	 }
	 
	 /**
	  * 删除收货地址
	  *
	  */
	 public void deleteAddress() throws Exception{
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 po.setMaster(cs.getId());
		 CustomAddrs ca = getSessionAttr(FILED_USER_ADDRESS);
		 try {
			 service.deleteAddress(po);
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
	 }
	 
	 /**
	  * 显示所有收货地址
	  *
	  */
	 public void showAddrs() throws Exception{
		 List<CustomAddrs> addrsList=null;
		 try {
			 addrsList=service.displayAddrs(po);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		 writeJSON(addrsList);
	 }
	 
	 
	 
	 /**
	  *
	  *根据ID查询收货地址
	  */
	 public void selectAddrsByID() throws Exception{
		 CustomAddrs addrs=null;
		 try {
			addrs=service.selectAddrsByID(po);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		 writeJSON(addrs);
	 }
	 

}
