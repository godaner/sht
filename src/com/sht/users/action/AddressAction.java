package com.sht.users.action;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;

import com.sht.po.Users;
import com.sht.users.po.CustomAddrs;
import com.sht.users.po.CustomUsers;
import com.sht.users.service.AddrsServiceI;

@Controller
public class AddressAction extends UBaseAction<CustomAddrs, AddrsServiceI> {

	/**
	 * 新增收货地址
	 */
	public void addAddress() throws Exception {
		Users cs = getOnlineUser();
//		CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		// 测试数据
//		cs = new CustomUsers();
//		cs.setId("1");
		eject(cs == null, "未登入");
		po.setMaster(cs.getId());
//		System.out.println(po);
		try {
//			String uuid = uuid();
			service.addAddress(po);
		} catch (Exception e) {
			e.printStackTrace();
			// po.setMsg(e.getMessage());
		}
		writeJSON(po);
		po.setMsg(null);
	}

	/**
	 * 修改收货地址
	 * 
	 **/
	public void updateAddress() throws Exception {
		Users u = getOnlineUser();
		eject( u== null, "您已离线");
		po.setMaster(u.getId());
//		CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
//		po.setMaster(cs.getId());
		
		try {
			service.updateAddress(po);
		} catch (Exception e) {
			e.printStackTrace();
			po.setMsg(e.getMessage());
		}finally{
		writeJSON(po);
		}
	}
	
	/**
	 * 设置默认收货地址
	 * 
	 **/
	public void updateDefault() throws Exception {
		Users u = getOnlineUser();
		eject( u== null, "您已离线");
		po.setMaster(u.getId());
		try {
			service.updateDefault(po);
		} catch (Exception e) {
			e.printStackTrace();
		}
		writeJSON(new Object());

	}

	/**
	 * 删除收货地址
	 *
	 */
	public String deleteAddress() throws Exception {
		Users u = getOnlineUser();
		eject( u== null, "您已离线");
		po.setMaster(u.getId());
		
		try {
			service.deleteAddress(po);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fAddrs";
	}

	/**
	 * 显示所有收货地址
	 *
	 */
	public void showAddrs() throws Exception {
		Users cs = getOnlineUser();
//		CustomUsers cs = getOnlineUser();
		eject(cs == null, "未登入");
		po.setMaster(cs.getId());
		List<CustomAddrs> addrsList = null;
		CustomAddrs c = new CustomAddrs();
		try {
			addrsList = service.displayAddrs(po);
			
			c.setAddrs(addrsList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		writeJSON(c);
	}

	/**
	 *
	 * 根据ID查询收货地址
	 */
	public void selectAddrsByID() throws Exception {

		Users u = getOnlineUser();
		eject( u== null, "您已离线");
		po.setMaster(u.getId());
		CustomAddrs addrs = null;
		try {
			addrs = service.selectAddrsByID(po);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		writeJSON(addrs);
	}

}
