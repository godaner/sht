package com.sht.users.po;

import java.io.File;
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
	//主图path,如:a.jpg
	private String mainImgPath;

	public String getMainImgPath() {
		return mainImgPath;
	}

	public void setMainImgPath(String mainImgPath) {
		this.mainImgPath = mainImgPath;
	}
	//退货凭证 ，如a.jpg
	private File fiile;

	public File getFiile() {
		return fiile;
	}

	public void setFiile(File fiile) {
		this.fiile = fiile;
	}

	
}
