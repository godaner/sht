package com.sht.goods.po;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Component;

import com.sht.po.GoodsImgs;

@Component
public class CustomGoodsImgs extends GoodsImgs {
	private List<File> files;
	private List<String> fileNames;
	public List<File> getFiles() {
		return files;
	}
	public void setFiles(List<File> files) {
		this.files = files;
	}
	public List<String> getFileNames() {
		return fileNames;
	}
	public void setFileNames(List<String> fileNames) {
		this.fileNames = fileNames;
	}
	
	
}
