package com.sht.users.action;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.stereotype.Controller;

import com.sht.action.BaseAction;

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
public class UsersAction extends BaseAction{

	
	/**
	 * Title:login
	 * <p>
	 * Description:认证
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月11日 下午5:24:36
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public String login() throws Exception{
		
		String exceptionClassName = getRequestParam("shiroLoginFailure");
		
		if(exceptionClassName != null){
			
			if(UnknownAccountException.class.equals(exceptionClassName)){
				eject("账户不存在");
			}
			if(IncorrectCredentialsException.class.equals(exceptionClassName)){
				eject("用户名/密码不存在");
			}
			
		}

		return "fLogin";
	}
}
