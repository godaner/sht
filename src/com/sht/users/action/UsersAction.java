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
@Controller
@Scope("prototype")

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
	public String login() throws Exception{
		try{
			
			service.login(po);
			
		}catch(Exception e){
			
			e.printStackTrace();
			
			setRequestAttr(FIELD_REQUEST_RETURN_MSG, e.getMessage());
			
			return "fLogin";
		}

		setRequestAttr(FILED_ONLINE_USER, po);

		return "fIndex";
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
			
			setRequestAttr(FIELD_REQUEST_RETURN_MSG, e.getMessage());
			
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
