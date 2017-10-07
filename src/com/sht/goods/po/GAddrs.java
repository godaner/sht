package com.sht.goods.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sht.po.Addrs;

@Component
@Scope("prototype")
public class GAddrs extends Addrs {
	
	private String addr;

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	

}
