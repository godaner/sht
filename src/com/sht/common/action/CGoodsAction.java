package com.sht.common.action;

import java.io.File;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.action.BaseAction;
import com.sht.common.po.CGoods;
import com.sht.common.service.CGoodsServiceI;

/**
 * 
 * Title:GoodsAction
 * <p>
 * Description:公用GoodsAction
 * <p>
 * 
 * @author Kor_Zhang
 * @date 2017年9月26日 上午11:06:13
 * @version 1.0
 */
@Scope("prototype")
@Controller
public class CGoodsAction extends BaseAction<CGoods, CGoodsServiceI> {

	/**
	 * Title:getGoodsImg
	 * <p>
	 * Description:通過size和imgName參數獲取商品圖片;<br/>
	 * 测试:http://localhost/sht/common/goods_getGoodsImg.action?size=200&imgName=2.jpg;<br/>
	 * 注意:保证目录下有指定size和imgName的文件,测试才能通过;<br/>
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月26日 上午11:32:24
	 * @version 1.0
	 * @throws Exception
	 */
	public void getGoodsImg() throws Exception {
		String size = po.getSize();
		String imgName = po.getImgName();
		logger.info("---------"+imgName);
		
		try {

			eject(size == null || size.trim().isEmpty(), "商品图片size没有指定");

			eject(imgName == null || size.trim().isEmpty(), "商品图片的imgName没有指定");

			// 指定的图片路徑
			String path = getValue(CONFIG.FILED_SRC_GOODS_IMGS) + size
					+ "_" + imgName;

			// 如果文件不存在
			eject(!new File(path).exists(),"不存在商品图片图片: "+path);

			// 返回头像
			writeFileToOS(path, getResponse().getOutputStream());

		} catch (Exception e) {
			// 找不大图片,抛出异常
			e.printStackTrace();
		}

	}
}
