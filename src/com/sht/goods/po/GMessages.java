package com.sht.goods.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sht.po.Messages;

@Component
@Scope("prototype")
public class GMessages extends Messages {
	
	private String username;
	
	private String headImg;

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	

}
