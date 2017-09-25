package com.sht.users.po;

import java.io.Serializable;

import org.springframework.stereotype.Component;

import com.sht.po.Goods;

/**
 * 
 * 用户模块自定义 商品
 * @author yyfjsn
 *
 */


@SuppressWarnings("serial")
@Component
public class UGoods extends Goods implements Serializable{
	private String msg ;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}
