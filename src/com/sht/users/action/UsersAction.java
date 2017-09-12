package com.sht.users.action;

import org.apache.shiro.authc.AuthenticationException;
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
	 * Description:shiro认证失败时被指定调用,用于判断显示信息和跳转页面;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月11日 下午5:24:36
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public String login() throws Exception{
		String exceptionClassName = getRequestAttr("shiroLoginFailure");
	    logger.debug("异常信息：" + exceptionClassName);
	    String msg = "";
		if(exceptionClassName != null){
			
			if(UnknownAccountException.class.getName().equals(exceptionClassName)){
				msg = "账户不存在";
			}else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)){
				msg = "用户名/密码错误";
			}else if(AuthenticationException.class.getName().equals(exceptionClassName)){
				msg = "用户名/密码错误";
			}else{
				msg = "登录错误";
			}
			
		}
		
		setRequestAttr("msg", msg);
		
		return "fLogin";
	}
	public void doo(){
		logger.info("doo");
	}
}
