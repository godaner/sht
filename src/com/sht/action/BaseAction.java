package com.sht.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import com.opensymphony.xwork2.ModelDriven;
import com.sht.util.GUtil;

/**
 * Title:BaseAction
 * <p>
 * Description:基础action,预先实现一些公用功能;<br/>
 * 	类参数T表示从前台接收的参数,在子类可以直接调用;可以通过po.xx()获取信息<br/>
 * 	类参数S代表Action的service实例,可以通过service.xx()执行业务;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午2:43:48
 * @version 3.0
 * @see GUtil
 */
public class BaseAction<P,S> extends GUtil implements ModelDriven<P>{

	protected P po;
	
	@Autowired
	public void setP(P po){
		this.po = po;
	}

	protected S service;
	
	
	@Autowired
	public void setS(S service){
		this.service = service;
	}
	
	
	
	@Override
	public P getModel() {
		return po;
	}
	
	
}
