package com.sht.front.users.action;

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

	
	public String login(){
		return "index";
	}
}
