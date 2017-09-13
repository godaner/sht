package com.sht.users.service.impl;

import com.sht.service.impl.BaseService;
import com.sht.users.util.UUtil;
import com.sht.users.util.Ustatic;
import com.sht.util.GUtil;

/**
 * Title:UBaseService
 * <p>
 * Description:用户模块自定义的基础service;<br/>
 * 	继承了BaseService,并且附加UUtil和Ustatic;
 * @see	BaseService
 * @see	Ustatic
 * @see	Util
 * @see	UUtil
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月13日 上午9:19:43
 * @version 1.0
 */
public class UBaseService extends BaseService implements Ustatic{
	/**
	 * Title:Util
	 * <p>
	 * Description:工具类,使用内部类继承利于拓展;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月13日 上午8:32:45
	 * @version 1.0
	 */
	protected class Util extends UUtil {
		
	} 
}
