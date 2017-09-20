package com.sht.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.opensymphony.xwork2.ActionContext;
import com.sht.users.po.CustomUsers;

/**
 * 封装Struts关于原生http的对象的操作；<br/>
 * 原生对象：response，request，application，session的获取，赋值，移除值操作；<br/>
 * 注意：请不要与项目其他工具包发生关系，保持工具包的纯洁性；<br/>
 * @author Kor_Zhang
 */
public class ActionUtil extends Util{

	
	/**
	 * Title:getWebAddr
	 * <p>
	 * Description:获取本项目网络地址;<br/>
	 * 需要在本项目的类路径的根下保存一个key为webaddr的字段;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月14日 上午10:18:56
	 * @version 1.0
	 * @return
	 */
	public String getWebAddr(){
		String addr = (String) getValue(Static.FIELD_WEB_ADDR);
		
		String projectName = getRequest().getContextPath();

		return addr + projectName;
	}
	
	
	/**
	 * Title:validateCode2response
	 * <p>
	 * Description:写入验证码到response并且返回验证文本
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月14日 上午8:05:10
	 * @version 1.0
	 * @return	返回验证文本
	 */
	public String validateCode2response(){
		
		
		vc.createCode();
		
		try {
			vc.write(getResponse().getOutputStream());
			
			return vc.getCode();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "";
	}  
	
	
	/**
	 * Title:getOnlineUser
	 * <p>
	 * Description:获取当前在线user;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月13日 下午8:23:00
	 * @version 1.0
	 * @return
	 */
	public CustomUsers getOnlineUser(){
		
		CustomUsers onlineUser = new CustomUsers();
		
		onlineUser.setId("1");
		
		return onlineUser;
	};
	
	
	/**
	 * Title:setOnlineUser
	 * <p>
	 * Description:设置当前在线用户;
	 * <p>
	 * @author Kor_Zhang
	 * @date 2017年9月13日 下午8:29:27
	 * @version 1.0
	 * @param user
	 */
	public void setOnlineUser(CustomUsers user){
		
		setSessionAttr(Static.FILED_ONLINE_USER, user);
		
	}
	
	
	/**
	 * 返回一个json对象
	 * 
	 * @param o
	 */
	public static void writeJSON(Object o) {
		if(null == o){
			return;
		}
		PrintWriter pt = null;
		try {
			// 获取输出流
			/*pt = getResponse().getWriter();
			getResponse().setCharacterEncoding("UTF-8");  
			getResponse().setContentType("application/json;charset=utf-8");*/
			HttpServletResponse response= ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=utf-8");
			pt= response.getWriter();
			// 序列化对象
			String json = JSON.toJSONStringWithDateFormat(o,
					"yyyy-MM-dd HH:mm:ss",
					SerializerFeature.DisableCircularReferenceDetect);
			// 写入对象
			pt.write(json);
			pt.flush();
			pt.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// 关闭
			pt.close();
		}
	}

	/**
	 * 返回二进制图片
	 * 
	 * @param imgFile
	 *            ：需要写到response的图片文件
	 */
	public static void writeImg(File imgFile) {

		// 获取response对象
		HttpServletResponse response = null;
		// 声明输出流
		OutputStream os = null;
		// 声明输入流
		FileInputStream fis = null;
		try {
			// 获取response
			response = getResponse();
			// 获取响应输出流
			os = response.getOutputStream();
			// 文件流获取
			fis = new FileInputStream(imgFile);
			response.setHeader("Content-Type", "image/jped");// 设置响应的媒体类型，这样浏览器会识别出响应的是图片
			// 写入数据
			os.write(IOUtils.toByteArray(fis));

			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// 关闭流
			try {
				fis.close();
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	}

	/**
	 * 将指定路劲和文件名的文件写入json返回，出现异常自动获取默认图片
	 * 
	 * @param imgName
	 *            ：图片名字
	 * @param imgPath
	 *            ：图片的路径
	 */
	public static void writeImgByPath(String imgPath, String imgName,
			String defaultImgName) {
		File imgFile = null;
		try {
			imgFile = new File(imgPath, imgName);
			// 如果没有img，那么抛出异常
			if (imgName == null || imgName.trim().equals("")
					|| !imgFile.exists()) {
				throw new Exception("没有该图片！");
			}

		} catch (Exception e) {
			imgFile = new File(imgPath, defaultImgName);
			e.printStackTrace();
		} finally {
			writeImg(imgFile);
		}
	}

	
	/**
	 * 设置session的参数
	 * 
	 * @param name
	 * @param value
	 * @return
	 */
	public static Boolean setSessionAttr(String name, Object value) {
		try {
			getSession().setAttribute(name, value);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;

	}

	/**
	 * 获取session的参数
	 * 
	 * @param name
	 * @return
	 */
	public static <T> T getSessionAttr(String name) {

		try {
			return (T) getSession().getAttribute(name);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	/**
	 * 去除session的参数
	 * 
	 * @param name
	 * @return
	 */
	public static Boolean removeSessionAttr(String name) {

		try {
			getSession().removeAttribute(name);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}
	/**
	 * 设置request的参数
	 * 
	 * @param name
	 * @param o
	 * @return
	 */
	public static Boolean setRequestAttr(String name, Object o) {
		try {
			getRequest().setAttribute(name, o);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;

	}

	/**
	 * 获取request的参数
	 * 
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getRequestAttr(String name) {

		try {
			return (T) getRequest().getAttribute(name);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	/**
	 * 获取request的请求参数
	 * 
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getRequestParam(String name) {

		try {
			return (T) getRequest().getParameter(name);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	/**
	 * 去除request的参数
	 * 
	 * @param name
	 * @return
	 */
	public static Boolean removeRequestAttr(String name) {

		try {
			getRequest().removeAttribute(name);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	/**
	 * 设置Application的参数
	 * 
	 * @param name
	 * @param o
	 * @return
	 */
	public static Boolean setApplicationAttr(String name, Object o) {
		try {
			getApplication().setAttribute(name, o);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;

	}

	/**
	 * 获取Application的参数
	 * 
	 * @param name
	 * @return
	 */
	public static <T> T getApplicationAttr(String name) {

		try {
			return (T) getApplication().getAttribute(name);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	/**
	 * 去除Application的参数
	 * @param name
	 * @return
	 */
	public static Boolean removeApplicationAttr(String name) {

		try {
			getApplication().removeAttribute(name);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}
	
	/**
	 * 获取session
	 * 
	 * @return
	 */
	public static HttpSession getSession() {
		try {
			return ServletActionContext.getRequest().getSession();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 获取request
	 * 
	 * @return
	 */
	public static HttpServletRequest getRequest() {
		try {
			return ServletActionContext.getRequest();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 获取response
	 * 
	 * @return
	 */
	public static HttpServletResponse getResponse() {
		try {
			return ServletActionContext.getResponse();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 获取application
	 * 
	 * @return
	 */
	public static ServletContext getApplication() {
		try {
			return ServletActionContext.getServletContext();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
}
