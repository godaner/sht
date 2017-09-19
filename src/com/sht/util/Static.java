package com.sht.util;

/**
 * Title:Static
 * <p>
 * Description:存放全局静态常量;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午3:12:24
 * @version 1.0
 */
public interface Static {
	/**
	 * request返回信息的字段名
	 */
	public static final String FIELD_REQUEST_RETURN_MSG = "msg";
	/**
	 * request中存放在线用户的信息的字段
	 */
	public static final String FILED_ONLINE_USER = "onlineUser";
	/**
	 * 存放网站地址
	 */
	public final static String FIELD_WEB_ADDR = "webaddr";
	
	
	/**
	 * 
	 * Title:REG
	 * <p>
	 * Description:正则表达式
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月19日 下午7:27:32
	 * @version 1.0
	 */
	public interface REG{
		
		//邮箱
		String EMAIL = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$";
		
		//密码
		String PASSWORD = "^[a-zA-Z]\\w{5,12}$";
		
		//用户名
		String USERNAME = "^[A-Za-z][A-Za-z1-9_-]{5,20}$";
		
		//邮编
		String POST_CODE = "^[1-9]\\d{5}$";
	}
	
}
