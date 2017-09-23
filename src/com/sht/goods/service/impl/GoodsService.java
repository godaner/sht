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

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.CustomGoodsMapper;
import com.sht.goods.po.CustomGoods;
import com.sht.goods.po.CustomGoodsImgs;
import com.sht.goods.service.GoodsServiceI;
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
public class GoodsService extends GBaseService implements GoodsServiceI {
	@Autowired
	private CustomGoodsMapper customGoodsMapper;

	@Autowired
	private GoodsMapper goodsMapper;
	
	@Autowired
	private GoodsImgsMapper goodsImgsMapper;
	
	
	
	/**
	 * 	显示商品主页面商品信息
	 */
	@Override

	public List<CustomGoods> dispalyGoodsInfo() throws Exception {
		List<CustomGoods> dbGoods = customGoodsMapper.selectAllGoodsInfo();
		logger.info("GoodsService");
		eject(dbGoods == null || dbGoods.size() == 0, "无商品信息");
		
		return dbGoods;

	}

	/**
	 * 发布商品信息
	 */
	@Override
	public String createGoodsInfo(CustomGoods goods) throws Exception {
		// TODO Auto-generated method stub
		String createGoodsId = uuid();
		goods.setId(createGoodsId);
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		goods.setCreatetime(timestamp);
		goods.setLastUpdateTime(timestamp);
		goodsMapper.insert(goods);
		
		return createGoodsId;
	}

	/**
	 * 发布商品图片信息
	 */
	@Override
	public int createGoodsImagsInfo(CustomGoodsImgs goodsImgs) throws Exception {
		// TODO Auto-generated method stub
		
		goodsImgs.setId(uuid());
		
		String path = CONFIG.FILED_SRC_GOODS_IMGS;
		
		for(int i = 0;i < goodsImgs.getFiles().size() ; i++){
			OutputStream os = new FileOutputStream(new File(path,goodsImgs.getFileNames().get(i)));  
            
            InputStream is = new FileInputStream(goodsImgs.getFiles().get(i));  
              
            byte[] buf = new byte[1024];  
            
            int length = 0 ;  
              
            while(-1 != (length = is.read(buf) ) )  {  
                os.write(buf, 0, length) ;  
            }  
              
            closeStream(is, os);
		}
	   
		goodsImgs.setOwner("");
		int result = goodsImgsMapper.insert(goodsImgs);
		
		return result;
		
	}
	
	
	
	
}
