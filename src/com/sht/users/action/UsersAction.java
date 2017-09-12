package com.sht.users.action;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ModelDriven;
import com.sht.action.BaseAction;
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
public class UsersAction extends BaseAction implements ModelDriven<CustomUsers>{
	
	public static final String FILED_ONLINE_USER = "onlineUser";


	@Autowired
	private UsersServiceI us;
	
	
	@Autowired
	private CustomUsers customUsers;
	
	
	

	@Override
	public CustomUsers getModel() {
		return customUsers;
	}
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

			us.login(customUsers);
		}catch(Exception e){
			
			e.printStackTrace();
			
			setRequestAttr(FIELD_REQUEST_RETURN_MSG, e.getMessage());
			
			return "fLogin";
		}

		setRequestAttr(FILED_ONLINE_USER, customUsers);

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

			us.regist(customUsers);
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
