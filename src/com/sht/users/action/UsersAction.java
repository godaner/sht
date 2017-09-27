package com.sht.users.action;

import java.awt.image.RenderedImage;
import java.io.File;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.sht.po.Goods;
import com.sht.users.po.CustomUsers;
import com.sht.users.service.UsersServiceI;
import com.sht.util.Static.CONFIG;


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
			eject(!po.getCode().equals(getSessionAttr("vc")), "验证码错误");
			
			service.regist(po);
			
			String uuid = UUID.randomUUID().toString();
			
			//http://localhost:80/sht
			String webaddr = getWebAddr();
			
			String conetnt = "<a href='"+webaddr+"/users/verifyEmail.action?email="+po.getEmail()+"&code="+uuid+"'>请点击这里激活</a>";
			
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
		}
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
	  * 获取用户头像
	 * @throws Exception 
	  * 
	  * 
	  */
	 public void getHeadimg() throws Exception{
		 
		 CustomUsers cs = getSessionAttr(FILED_ONLINE_USER);
		 
		 eject(cs == null, "用户未登录");
		 
		 try{
			 List<RenderedImage> childs = service.getHeadimg(cs);
				
			 for(RenderedImage img: childs){
				 ImageIO.write(img, "png", getResponse().getOutputStream());
			 }
			 
			 
			}catch(Exception e){
				
				e.printStackTrace();
			}
	 }
}
