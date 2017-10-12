package com.sht.goods.po;

import java.io.File;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.sht.po.Goods;

/**
 * Title:CustomUsers
 * <p>
 * Description:自定义po;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午4:45:49
 * @version 1.0
 */
@Component
@Scope("prototype")
public class GGoods extends Goods {
	private String userid;
	
	private String username;
	
	private File[] files;
	
	private String path;
	
	private String headImg;
	
	private String addr;
	
	private String userId;
	
	
	private String msgNum;
	
	private int minLine;
	
	private int maxLine;
	
	private int rownum;
	
	private String orderByTime;
	
	private String orderByPrice;
	
	
	private String minPrice;
	
	private String maxPrice;
	
	private String sregion;
	
	private String clazz;
	

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public File[] getFiles() {
		return files;
	}

	public void setFiles(File[] files) {
		this.files = files;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}

	public String getAddr() {
		return addr;
	}
	
	

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	

	public String getMsgNum() {
		return msgNum;
	}

	public void setMsgNum(String msgNum) {
		this.msgNum = msgNum;
	}

	public int getMinLine() {
		return minLine;
	}

	public void setMinLine(int minLine) {
		this.minLine = minLine;
	}

	public int getMaxLine() {
		return maxLine;
	}

	public void setMaxLine(int maxLine) {
		this.maxLine = maxLine;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public String getOrderByTime() {
		return orderByTime;
	}

	public void setOrderByTime(String orderByTime) {
		this.orderByTime = orderByTime;
	}

	public String getOrderByPrice() {
		return orderByPrice;
	}

	public void setOrderByPrice(String orderByPrice) {
		this.orderByPrice = orderByPrice;
	}

	public String getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(String minPrice) {
		this.minPrice = minPrice;
	}

	public String getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(String maxPrice) {
		this.maxPrice = maxPrice;
	}

	public String getSregion() {
		return sregion;
	}

	public void setSregion(String sregion) {
		this.sregion = sregion;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

}
