package com.sht.util;

/**
 * Title:Static
 * <p>
 * Description:存放全局静态常量;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 下午3:12:24
 * @version 1.0
 */
public interface Static {
	/**
	 * request返回信息的字段名
	 */
	public static final String FIELD_REQUEST_RETURN_MSG = "msg";
	/**
	 * request中存放在线用户的信息的字段
	 */
	public static final String FILED_ONLINE_USER = "onlineUser";

	
	
	/**
	 * Title:USERS
	 * <p>
	 * Description:users模块常量字段;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月20日 上午7:58:55
	 * @version 1.0
	 */
	public interface USERS{
		
	}
	/**
	 * Title:GOODS
	 * <p>
	 * Description:goods模块常量字段;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月20日 上午7:58:57
	 * @version 1.0
	 */
	public interface GOODS{
		
	}
	
	/**
	 * Title:CONFIG
	 * <p>
	 * Description:condig文件中的key常量字段;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月20日 上午7:57:57
	 * @version 1.0
	 */
	public interface CONFIG{
		/**
		 * 存放网站地址字段
		 */
		static final String FIELD_WEB_ADDR = "config.webaddr";
		/**
		 * 用户头像资源存放路径
		 * 
		 */
		static final String FILED_SRC_USERS_HEADIMGS = "config.src.users.heaimgs";
		/**
		 * 商品图片资源存放路径
		 * 
		 */
		static final String FILED_SRC_GOODS_IMGS = "config.src.goods.imgs";
		
		/**
		 * 用户头像尺寸版本字段
		 */
		static final String FILED_USERS_HEADINGS_SIZES = "config.users.headimgs.sizes";
		/**
		 * 商品图片尺寸版本字段
		 */
		static final String FILED_GOODS_IMGS_SIZES = "config.goods.imgs.sizes";
		/**
		 * 用户头像圖片類型字段
		 */
		static final String FILED_USERS_HEADINGS_TYPES = "config.users.headimgs.types";
		/**
		 * 商品图片類型字段
		 */
		static final String FILED_GOODS_IMGS_TYPES = "config.goods.imgs.types";
		/**
		 * 用户默认头像字段字
		 */
		static final String FILED_USERS_HEADIMGS_DEFAULT = "config.users.headimgs.default";
	}
	
	
	/**
	 * 
	 * Title:REG
	 * <p>
	 * Description:正则表达式
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月19日 下午7:27:32
	 * @version 1.0
	 */
	public interface REG{
		
		//邮箱
		static final String EMAIL = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$";
		
		//密码
		static final String PASSWORD = "^[a-zA-Z]\\w{5,12}$";
		
		//用户名
		static final String USERNAME = "^[A-Za-z][A-Za-z1-9_-]{5,20}$";
		
		//邮编
		static final String POST_CODE = "^[1-9]\\d{5}$";
	}
	
}
