package com.sht.users.po;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sht.po.Region;

/**
 * @author Administrator
 * 自定义region
 */
@Component
public class URegion extends Region {
	private String msg ;		//错误信息

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	/**
	 * 当前节点的子节点
	 */
	private List<Region> childs;

	public List<Region> getChilds() {
		return childs;
	}

	public void setChilds(List<Region> childs) {
		this.childs = childs;
	}
	
}
