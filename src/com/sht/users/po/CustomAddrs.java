package com.sht.users.po;

import java.util.List;

import org.springframework.stereotype.Component;

import com.sht.po.Addrs;

@Component
public class CustomAddrs extends Addrs {
	private String msg ;		//错误信息

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	private List<CustomAddrs> addrs;

	public List<CustomAddrs> getAddrs() {
		return addrs;
	}

	public void setAddrs(List<CustomAddrs> addrs) {
		this.addrs = addrs;
	}
	
	
}
