package com.sht.users.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import antlr.StringUtils;

import com.alipay.api.internal.util.AlipaySignature;
import com.sht.alipay.config.AlipayConfig;
import com.sht.users.po.CustomUsers;
import com.sht.users.service.UsersServiceI;


/**	
 * Title:UsersAction
 * <p>
 * Description:用户的action
 * <p>
 * @author Kor_Zhang
 * @date 2017年9月11日 上午10:29:03
 * @version 1.0
 */
@Scope("prototype")
@Controller
public class UsersAction extends UBaseAction<CustomUsers,UsersServiceI> {

	
	/**
	 * 
	 * Title:login
	 * <p>
	 * Description:用戶登录
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:24:20
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public void login() throws Exception{
		logger.info("UserAction");
		try{
			
			po = service.login(po);
			
			setSessionAttr(FILED_ONLINE_USER, po);
			
		}catch(Exception e){
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
		}
		
		//返回一个json的数据
		writeJSON(po);
		po.setMsg(null);
	}
	/**
	 * 获取验证码
	 */
	public void getVC() throws Exception{
		try{
			vc.createCode();
			
			vc.write(getResponse().getOutputStream());

			setSessionAttr("vc", vc.getCode());
			
			logger.info(vc.getCode());
		}catch(Exception e){
			
			e.printStackTrace();
			
			
		}
		
		
	}
	/**
	 * Title:regist
	 * <p>
	 * Description:用户注册
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:46:36
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public void regist() throws Exception{
		try{
			
			String code1 = getSessionAttr("vc");
			
			String code2 = po.getCode();
			
			eject(!code2.toLowerCase().equals(code1.toLowerCase()), "验证码错误");
			
			service.regist(po);
			
			String uuid = UUID.randomUUID().toString();
			
			//http://localhost:80/sht
			String webaddr = getWebAddr();
			
			//String conetnt = "<a href='"+webaddr+"/users/verifyEmail.action?email="+po.getEmail()+"&code="+uuid+"'>请点击这里激活</a>";
			String conetnt = "<a href='"+webaddr+"/users/view/backtoindex.jsp?email="+po.getEmail()+"&code="+uuid+"'>请点击这里激活</a>";
			
			email.sendMessage(po.getEmail(), "二手交易市场邮箱验证", conetnt);
			
		}catch(Exception e){
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
		}
		
			//返回一个json的数据
			writeJSON(po);
			po.setMsg(null);
	}
	/**
	 * Title:logout
	 * <p>
	 * Description:用户注销
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月12日 下午6:46:21
	 * @version 1.0
	 * @return
	 * @throws Exception
	 */
	public String logout() throws Exception{
		
		removeSessionAttr(FILED_ONLINE_USER);
		
		getSession().invalidate();
		
		setRequestAttr(FIELD_REQUEST_RETURN_MSG, "注销成功");
		
		return "fLogin";
	}
	
	/**
	 * 
	 * 邮箱验证
	 */
	 public void verifyEmail() throws Exception{
		 
		 logger.info("verifyEmail");
		 
		 try {
			 String email = po.getEmail();
			service.verifyEmail(email);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	 }
	 /**
	  * 修改个人信息
	 * @throws Exception 
	  * 
	  * 
	  */
	 public void updatePersonalInfo() throws Exception{
		 
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 
		 eject(cs==null, "未登入");
		 
		cs.setDescription(po.getDescription());
		
		cs.setUsername(po.getUsername());
		
		cs.setSex(po.getSex());
		 
		 try {
		
			 service.updateByPrimaryKeySelective(cs);
			 
			 setSessionAttr(FILED_ONLINE_USER, cs);
			 
		} catch (Exception e) {
			
			e.printStackTrace();
			po.setMsg(e.getMessage());
		}
		 writeJSON(po);
	 }
	 
	 /**
	  * 上传用户头像
	 * @throws Exception 
	  * 
	  */
	 public void personalImgUpload() throws Exception{
		 
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 
		 eject(cs == null, "上传头像需要先登录");
		 
		 cs.setFiile(po.getFiile());
		 
		 service.personalImgUpload(cs);
	 }
	 
	 /**
	  * 密码确认
	 * @throws Exception 
	  * 
	  */
	 public void checkPassword() throws Exception{
		 
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 
		 try{
		 
			 eject(!cs.getPassword().equals(md5(po.getPassword() + cs.getSalt())), "密码错误");
		 
		 }catch(Exception e){
			
			 e.printStackTrace();
			 
			 po.setMsg(e.getMessage());
		 }finally{
			 
			 writeJSON(po);
			 po.setMsg(null);
		 }
		 
	 }
	 
	 /**
	  * 支付宝充值成功后的回调
	 * @throws Exception 
	  * 
	  */
	 
	 public void addMoney() throws Exception{
		 
		 /* *
		  * 功能：支付宝服务器异步通知页面
		  * 日期：2017-03-30
		  * 说明：
		  * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
		  * 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。


		  *************************页面功能说明*************************
		  * 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
		  * 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
		  * 如果没有收到该页面返回的 success 
		  * 建议该页面只做支付成功的业务逻辑处理，退款的处理请以调用退款查询接口的结果为准。
		  */
		  
		 	//获取支付宝POST过来反馈信息
		 	Map<String,String> params = new HashMap<String,String>();
		 	Map<String,String[]> requestParams = getRequest().getParameterMap();
		 	for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
		 		String name = (String) iter.next();
		 		String[] values = (String[]) requestParams.get(name);
		 		String valueStr = "";
		 		for (int i = 0; i < values.length; i++) {
		 			valueStr = (i == values.length - 1) ? valueStr + values[i]
		 					: valueStr + values[i] + ",";
		 		}
		 		//乱码解决，这段代码在出现乱码时使用
		 		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		 		params.put(name, valueStr);
		 	}
		 	
		 	boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

		 	//——请在这里编写您的程序（以下代码仅作参考）——
		 	
		 	/* 实际验证过程建议商户务必添加以下校验：
		 	1、需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
		 	2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
		 	3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email）
		 	4、验证app_id是否为该商户本身。
		 	*/
		 	if(signVerified) {//验证成功
		 		//商户订单号
		 		String out_trade_no = new String(((String) getRequestParam("out_trade_no")).getBytes("ISO-8859-1"),"UTF-8");
		 	
		 		//支付宝交易号
		 		String trade_no = new String(((String) getRequestParam("trade_no")).getBytes("ISO-8859-1"),"UTF-8");
		 	
		 		//交易状态
		 		String trade_status = new String(((String) getRequestParam("trade_status")).getBytes("ISO-8859-1"),"UTF-8");
		 		String total_amount = new String(((String) getRequestParam("total_amount")).getBytes("ISO-8859-1"),"UTF-8");

		 		if(trade_status.equals("TRADE_FINISHED")){
		 			//判断该笔订单是否在商户网站中已经做过处理
		 			//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		 			//如果有做过处理，不执行商户的业务程序
		 				
		 			//注意：
		 			//退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
		 			
		 			
		 		}else if (trade_status.equals("TRADE_SUCCESS")){
		 			//判断该笔订单是否在商户网站中已经做过处理
		 			//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		 			//如果有做过处理，不执行商户的业务程序
		 			
		 			//注意：
		 			//付款完成后，支付宝系统发送该交易状态通知
		 			// CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 			 //double money = cs.getMoney()+Double.parseDouble(total_amount);
		 			po.setMoney(Double.parseDouble(total_amount));
		 			String[] strs = out_trade_no.split("_");
		 			po.setId(strs[0]);
		 			service.addMoney(po);
		 			
		 		}
		 		
//		 		out.println("success");
		 		
		 	}else {//验证失败
//		 		out.println("fail");
		 	
		 		//调试用，写文本函数记录程序运行情况是否正常
		 		//String sWord = AlipaySignature.getSignCheckContentV1(params);
		 		//AlipayConfig.logResult(sWord);
		 	}
		 	
		 	//——请在这里编写您的程序（以上代码仅作参考）——
	 }
	 
	 /**
	  * 获取用户余额
	 * @throws Exception 
	  * 
	  */
	public void getMoneyById() throws Exception {

		CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);

		eject(cs == null, "未登入");

			try {
				
				po = service.getMoneyById(po);
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}

		writeJSON(po);
	}
	/**
	 * 根据email或者用户名修改密码
	 * 
	 */
	public void changePasswordByObj(){
		
		try {
			
			service.changePasswordByObj(po);
			
			removeSessionAttr(FILED_ONLINE_USER);
			
			getSession().invalidate();
			
		} catch (Exception e) {

			e.printStackTrace();
			
			po.setMsg(e.getMessage());
		}
		
		writeJSON(po);
		po.setMsg(null);
	}
	
}
