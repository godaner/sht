package com.sht.goods.po;

import java.io.File;

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
public class GGoods extends Goods {
	private File[] files;
	
	private String path;
	
	private String headImg;
	

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
	
	
	

}
