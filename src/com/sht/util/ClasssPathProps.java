package com.sht.util;

import java.util.Properties;

/**
 * Title:Config
 * <p>
 * Description:加载类路径的根路径下的*.properties属性文件
 * <p>
 * 
 * @author Kor_Zhang
 * @date 2017年9月14日 上午9:09:21
 * @version 1.0
 */
public class ClasssPathProps {
	private static Properties props = null;

	/**
	 * 
	 * Title:loadProps
	 * <p>
	 * Description:加载类路径的根的属性文件(*.properties)
	 * <p>
	 * 
	 * @author Kor_Zhang
	 * @date 2017年9月14日 上午8:29:29
	 * @version 1.0
	 * @param to
	 *            被新增的属性对象
	 * @param fromPath
	 *            新增的属性文件的地址
	 * @return
	 */
	public static void loadProps() {
		props = Util.loadClassPathProps("", "[\\w]*.properties");
	}

	/**
	 * 
	 * Title:getValue
	 * <p>
	 * Description:通过key获取类路径下属性文件的value;
	 * <p>
	 * 
	 * @author Kor_Zhang
	 * @date 2017年9月14日 上午10:15:22
	 * @version 1.0
	 * @param key
	 *            类路径下属性文件中的一个key
	 * @return
	 */
	public static Object getValue(String key) {
		return props.getProperty(key);
	}

	public static void main(String[] args) {
		ClasssPathProps.loadProps();

		System.out.println(ClasssPathProps.getValue(Static.FIELD_WEB_ADDR));
		;

		System.out.println(ClasssPathProps.getValue("db.url"));
		;
	}
}
