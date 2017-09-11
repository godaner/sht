package com.sht.util;

import org.apache.log4j.Logger;

/**
 * Title:工具类
 * <p>
 * Description:
 * <p>
 * 
 * @author Kor_Zhang
 * @date 2017年8月31日 下午3:14:15
 * @version 1.0
 */
public class GUtil extends GActionUtil{
	public static final Logger l = Logger.getLogger(GUtil.class);
	
	
	/**
	 * Title:如果表达式成立,抛出异常
	 * <p>
	 * Description:
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月2日 上午9:43:52
	 * @version 1.0
	 * @param expr
	 */
	public static void eject(Boolean expr,String msg) throws Exception{
		if(expr){
			throw new Exception(msg);
		}
	}
	/**
	 * Title:抛出一个空字符串的异常;
	 * <p>
	 * Description:
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月11日 下午2:42:52
	 * @version 1.0
	 * @throws Exception
	 */
	public static void eject() throws Exception{
		throw new Exception("");
	}
}
