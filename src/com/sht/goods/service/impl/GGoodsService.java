package com.sht.goods.service.impl;

import java.io.File;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sht.goods.mapper.GCustomGoodsMapper;

import com.sht.goods.po.GFiles;
import com.sht.goods.po.GGoods;
import com.sht.goods.po.GGoodsClazzs;
import com.sht.goods.po.GGoodsImgs;
import com.sht.goods.po.GMessages;
import com.sht.goods.po.GUser;
import com.sht.goods.service.GoodsServiceI;
import com.sht.mapper.ClazzsMapper;
import com.sht.mapper.FilesMapper;
import com.sht.mapper.GoodsClazzsMapper;
import com.sht.mapper.GoodsImgsMapper;
import com.sht.mapper.GoodsMapper;
import com.sht.mapper.UsersMapper;
import com.sht.po.Clazzs;
import com.sht.po.Goods;
import com.sht.po.Users;
import com.sht.util.Static;

/**
 * Title:UsersService
 * <p>
 * Description:用户业务接口实现
 * <p>
 * 
 * @author Kor_Zhang
 * @date 2017年9月12日 上午11:24:50
 * @version 1.0
 */
@Service
public class GGoodsService extends GBaseService implements GoodsServiceI {
	@Autowired
	private GCustomGoodsMapper customGoodsMapper;

	@Autowired
	private GoodsMapper goodsMapper;

	@Autowired
	private GoodsImgsMapper goodsImgsMapper;

	@Autowired
	private FilesMapper filesMapper;
	
	@Autowired
	private GoodsClazzsMapper goodsClazzsMapper;
	
	@Autowired
	private ClazzsMapper clazzsMapper;
	


	/**
	 * 显示商品主页面商品信息
	 */
	@Override

	public List<GGoods> dispalyGoodsInfo(GGoods goods) throws Exception {
//		info("-------minPrice----"+goods.getMinPrice());
//		info("-------maxPrice----"+goods.getMaxPrice());
		List<GGoods> dbGoods = customGoodsMapper.selectAllGoodsInfo(goods);
		info("GoodsService");
		eject(dbGoods == null || dbGoods.size() == 0, "无商品信息");

		return dbGoods;

	}

	/**
	 * 显示所有商品的数量
	 */
	@Override
	public double selectGoodsAllNum(GGoods goods) throws Exception {
		//region为0查询所有商品数量，region不为0则查询对应地区的商品总数量

//		String r = null;
//		if(!region.equals(0d)){
//			r = String.valueOf(region.intValue());
//		}
//		info("-----------sregion="+goods.getSregion());
//		info("-----------minPrice="+goods.getMinPrice());
//		info("-----------maxPrice="+goods.getMaxPrice());
		Double result = customGoodsMapper.selectGoodsTotalNum(goods);
		return result;
	}

	/**
	 * 发布商品信息
	 */
	@Override
	public String createGoodsInfo(GGoods goods) throws Exception {

		// 商品信息
		String goodsId = uuid();

		goods.setId(goodsId);

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		goods.setCreatetime(timestamp);

		goods.setLastupdatetime(timestamp);

		goods.setBrowsenumber(0.0);


		goods.setStatus(Static.GOODS_STAUS.WAIT_TO_PASS);

		goodsMapper.insert(goods);

		//向商品类型表写入数据
		GGoodsClazzs goodsClazzs = new GGoodsClazzs();
		
		goodsClazzs.setId(uuid());
		
		goodsClazzs.setGoods(goodsId);
		
		goodsClazzs.setClazz(goods.getClazz());
		
		
		goodsClazzsMapper.insert(goodsClazzs);
		
		//修改总类别数量
		
//		Clazzs  clazzs  =  clazzsMapper.selectByPrimaryKey(goods.getClazz());
//		Double clazzNum = clazzs.getNum() + 1;
//		clazzs.setNum(clazzNum);
//		clazzsMapper.updateByPrimaryKey(clazzs);
		
		// 向文件写入图片

		File[] file = goods.getFiles();
		for (int i = 0; i < file.length; i++) {
			String fileId = uuid();
			writeFileWithCompress(file[i], getValue(CONFIG.FILED_GOODS_IMGS_SIZES).toString(),
					getValue(CONFIG.FILED_SRC_GOODS_IMGS).toString(), fileId + ".png");

			// 向文件表插入图片信息
			GFiles files = new GFiles();

			files.setId(fileId);
			files.setPath(fileId + ".png");
			files.setName(file[i].getName());

			filesMapper.insert(files);
			// 向图片表中插入信息
			GGoodsImgs imgs = new GGoodsImgs();
			imgs.setId(uuid());
			imgs.setOwner(goodsId);
			imgs.setImg(fileId);
			if (i == 0)
				imgs.setMain(1.0);
			else
				imgs.setMain(0.0);
			goodsImgsMapper.insert(imgs);
		}
		return "createSuccess";
	}

	@Override
	public GGoods selectGoodsDetailInfo(String id) throws Exception {
		// TODO Auto-generated method stub
		//更细腻浏览次数
		Goods  goods = goodsMapper.selectByPrimaryKey(id);
		
		Double browseNum = goods.getBrowsenumber() + 1;

		goods.setBrowsenumber(browseNum);
		
		goodsMapper.updateByPrimaryKey(goods);
		
		//查询商品详细信息
		GGoods ggoods = customGoodsMapper.selectGoodsDetailInfo(id);
		
		return ggoods;
	}

	@Override
	public String selectGoodsImgs(String id) throws Exception {
		
		String path = customGoodsMapper.selectGoodsImgs(id);
		
		return path;
	}

	

	

}
