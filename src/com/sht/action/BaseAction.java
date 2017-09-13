package com.sht.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.sht.util.GStatic;
import com.sht.util.GUtil;

/**
 * Title:BaseAction
 * <p>
 * Description:基础action,预先实现一些公用功能;<br/>
 * 	类参数T表示从前台接收的参数,在子类可以直接调用;可以通过po.xx()获取信息;<br/>
 * 	类参数S代表Action的service实例,可以通过service.xx()执行业务;<br/>
 * 	可以通过Util.xx()使用工具;<br/>
 * 	一般action中保持一個action和一個po;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午2:43:48
 * @version 4.0
 * @see GUtil
 */
public class BaseAction<P,S> implements ModelDriven<P> , GStatic{
	/**
	 * 前台参数封装类
	 */
	protected P po;
	
	@Autowired
	public void setP(P po){
		this.po = po;
	}
	/**
	 * 业务类
	 */
	protected S service;
	
	
	@Autowired
	public void setS(S service){
		this.service = service;
	}
	
	
	
	@Override
	public P getModel() {
		return po;
	}
	
	
	/**
	 * Title:Util
	 * <p>
	 * Description:工具类,使用内部类继承利于拓展;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月13日 上午8:32:45
	 * @version 1.0
	 */
	protected class Util extends GUtil {
		
	} 
	
}
