package com.sht.common.action;

import java.io.File;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.action.BaseAction;
import com.sht.common.po.CUsers;
import com.sht.common.service.CUsersServiceI;

/**
 * 
 * Title:UsersAction
 * <p>
 * Description:公用UsersAction
 * <p>
 * 
 * @author Kor_Zhang
 * @date 2017年9月26日 上午11:06:13
 * @version 1.0
 */
@Controller
@Scope("prototype")
public class CUsersAction extends BaseAction<CUsers, CUsersServiceI> {

	/**
	 * Title:getUsersHeadImg
	 * <p>
	 * Description:通過size和headimg參數獲取用戶頭像;
	 * 测试:http://localhost/sht/common/users_getUsersHeadImg.action?size=200&headimg=2.jpg;<br/>
	 * 注意:保证目录下有指定size和headimg的文件,测试才能通过;<br/>
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月26日 上午11:16:34
	 * @version 1.0
	 * @throws Exception 
	 */
	public void getUsersHeadImg() throws Exception {
		String size = po.getSize();
		String headimg = po.getHeadimg();
		info("========="+headimg);
		
		try {

			eject(size == null || size.trim().isEmpty(), "用户头像的size没有指定");

			eject(headimg == null || size.trim().isEmpty(), "用户头像的headimg没有指定");

			// 指定的图片路徑
			String path = getValue(CONFIG.FILED_SRC_USERS_HEADIMGS) + size
					+ "_" + headimg;

			// 如果文件不存在
			eject(!new File(path).exists());

			// 返回头像
			writeFileToOS(path, getResponse().getOutputStream());

		} catch (Exception e) {
			// 返回默认图片
			String defaultImgName = getValue(CONFIG.FILED_USERS_HEADIMGS_DEFAULT).toString();
			String path = getValue(CONFIG.FILED_SRC_USERS_HEADIMGS) + defaultImgName;
			writeFileToOS(path, getResponse().getOutputStream());
		}

	}
}
