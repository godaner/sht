package com.sht.users.po;

import java.io.File;
import java.io.Serializable;

import org.springframework.stereotype.Component;

import com.sht.po.Users;

/**
 * Title:CustomUsers
 * <p>
 * Description:自定义Users;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午4:45:49
 * @version 1.0
 */
@Component
public class CustomUsers extends Users implements Serializable{

	private static final long serialVersionUID = 8094072730241347748L;
	
	
	private File fiile;//用户头像
	
	
	public File getFiile() {
		return fiile;
	}

	public void setFiile(File fiile) {
		this.fiile = fiile;
	}

	private String msg ;		//错误信息
	private String code;		//验证码

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	

}
