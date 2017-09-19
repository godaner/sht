package com.sht.users.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.users.po.CustomUsers;
import com.sht.users.service.UsersServiceI;


/**	
 * Title:UsersAction
 * <p>
 * Description:用户的action
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 上午10:29:03
 * @version 1.0
 */
@Scope("prototype")
@Controller
public class UsersAction extends UBaseAction<CustomUsers,UsersServiceI> {

	/**
	 * 
	 * Title:login
	 * <p>
	 * Description:用戶登录
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:24:20
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public void login() throws Exception{
		logger.info("UserAction");
		try{
			po = service.login(po);
			
			setSessionAttr(FILED_ONLINE_USER, po);
			
		}catch(Exception e){
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
		}
		
		//返回一个json的数据
		writeJSON(po);
		
	}

	/**
	 * Title:regist
	 * <p>
	 * Description:用户注册
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:46:36
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public String regist() throws Exception{
		try{

			service.regist(po);
			
		}catch(Exception e){
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
			return "fRegist";
		}
		
		return "fLogin";
	}
	
	/**
	 * Title:logout
	 * <p>
	 * Description:用户注销
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:46:21
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public String logout() throws Exception{
		
		removeSessionAttr(FILED_ONLINE_USER);
		
		getSession().invalidate();
		
		setRequestAttr(FIELD_REQUEST_RETURN_MSG, "注销成功");
		
		return "fLogin";
	}
	
}
