package com.sht.common.po;

import org.springframework.stereotype.Component;

import com.sht.po.Users;

/**
 * Title:CustomUsers
 * <p>
 * Description:自定義users
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月26日 上午11:15:14
 * @version 1.0
 */
@Component
public class CUsers extends Users{
	//請求的圖片規格(大小)
	private String size;

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	
	
}
