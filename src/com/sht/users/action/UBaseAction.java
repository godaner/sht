package com.sht.users.action;

import com.sht.action.BaseAction;
import com.sht.users.util.UUtil;
import com.sht.users.util.Ustatic;

/**
 * Title:UBaseAction
 * <p>
 * Description:用户模块的UBaseAction;<br/>
 * 	用户模块的Action都应继承他;<br/>
 * 	继承BaseAction,附加自定义的Util,static;
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月13日 上午8:42:32
 * @version 1.0
 * @param <P>
 * @param <S>
 * @see BaseAction
 * @see UUtil
 * @see Util
 * @see Ustatic
 */
public class UBaseAction<P, S> extends BaseAction<P, S> implements Ustatic{
	
	
	/**
	 * Title:Util
	 * <p>
	 * Description:附加自定义的工具;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月13日 上午8:42:25
	 * @version 1.0
	 */
	protected class Util extends UUtil {
		
	}  
	
}
