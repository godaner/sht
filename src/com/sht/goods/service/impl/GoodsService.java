package com.sht.goods.service.impl;




import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.omg.PortableServer.POA;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.opensymphony.xwork2.ModelDriven;
import com.sht.goods.mapper.CustomGoodsMapper;
import com.sht.goods.po.GFiles;
import com.sht.goods.po.GGoods;
import com.sht.goods.po.GGoodsImgs;
import com.sht.goods.service.GoodsServiceI;
import com.sht.mapper.FilesMapper;
import com.sht.mapper.GoodsImgsMapper;
import com.sht.mapper.GoodsMapper;


/**
 * Title:UsersService
 * <p>
 * Description:用户业务接口实现
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:24:50
 * @version 1.0
 */
@Service
public class GoodsService extends GBaseService implements GoodsServiceI{
	@Autowired
	private CustomGoodsMapper customGoodsMapper;

	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private GoodsImgsMapper goodsImgsMapper;
	
	@Autowired
	private FilesMapper filesMapper;
	
	
	/**
	 * 	显示商品主页面商品信息
	 */
	@Override

	public List<GGoods> dispalyGoodsInfo() throws Exception {
		List<GGoods> dbGoods = customGoodsMapper.selectAllGoodsInfo();
		info("GoodsService");
		eject(dbGoods == null || dbGoods.size() == 0, "无商品信息");
		
		
		return dbGoods;

	}

	/**
	 * 发布商品信息
	 */
	@Override
	public String createGoodsInfo(GGoods goods) throws Exception {
		
		
		//商品信息
		String goodsId = uuid();
		
		goods.setId(goodsId);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		goods.setCreatetime(timestamp);
		
		goods.setLastupdatetime(timestamp);
		
		goods.setBrowsenumber(0.0);
		
		goods.setOwner("1");
		
		short a = 0;
		goods.setStatus(a);
		
		goodsMapper.insert(goods);
		
		//向文件写入图片
		
		File[] file = goods.getFiles();
		for(int i = 0 ;i < file.length ;i++){
			String fileId =uuid();
			writeFileWithCompress(file[i], getValue(CONFIG.FILED_GOODS_IMGS_SIZES).toString(), 
					getValue(CONFIG.FILED_SRC_GOODS_IMGS).toString(), fileId+".png");
			
			//向文件表插入图片信息
			GFiles files =new GFiles();
			
			files.setId(fileId);
			files.setPath(fileId+".png");
			files.setName(file[i].getName());
			
			createGoodsFileInfo(files);
			//向图片表中插入信息
			GGoodsImgs imgs = new GGoodsImgs();
			imgs.setId(uuid());
			imgs.setOwner(goodsId);
			imgs.setImg(fileId);
			if(i == 0)
			   imgs.setMain(1.0);
			else 
				imgs.setMain(0.0);
			createGoodsImagsInfo(imgs);
		}
		return "fCreateGoods";
	}

	/**
	 * 发布商品图片信息
	 */
	@Override
	public String createGoodsImagsInfo(GGoodsImgs goodsImgs) throws Exception {
		// TODO Auto-generated method stub
		
		goodsImgsMapper.insert(goodsImgs);
		
		return "";
		
	}

	@Override
	public String createGoodsFileInfo(GFiles files) throws Exception {
		// TODO Auto-generated method stub
	
		filesMapper.insert(files);	
		
		return "";
		
	}
	
	
	
	
	
	
	
}
