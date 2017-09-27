package com.sht.common.po;

import org.springframework.stereotype.Component;

import com.sht.po.Goods;

/**
 * Title:CustomGoods
 * <p>
 * Description:自定義Goods
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月26日 上午11:33:21
 * @version 1.0
 */
@Component
public class CGoods extends Goods {
	//請求的圖片規格(大小)
	private String size;
	//请求的图片的名称
	private String imgName;
	
	public String getImgName() {
		return imgName;
	}

	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}
}
