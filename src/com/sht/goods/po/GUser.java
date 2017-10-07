package com.sht.goods.po;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sht.po.Users;

@Component
@Scope("prototype")
public class GUser extends Users {
	
	private Double price;
	
	private String addr;
	
	private String phone;
	
	private String torealname;
	
	private String todetail;
	
	private String goodsId;
	

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	

	public String getTorealname() {
		return torealname;
	}

	public void setTorealname(String torealname) {
		this.torealname = torealname;
	}

	public String getTodetail() {
		return todetail;
	}

	public void setTodetail(String todetail) {
		this.todetail = todetail;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	

}
