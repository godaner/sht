package com.sht.users.action;

import java.util.List;

import org.springframework.stereotype.Controller;

import com.sht.users.po.CustomUsers;
import com.sht.users.po.UGoods;
import com.sht.users.service.UGoodsServiceI;
/**
 * 
 * 用户对商品的操作
 * @author yyfjsn
 *
 */

@Controller
public class UGoodsAction extends UBaseAction<UGoods,UGoodsServiceI>{
	 
	 int PageNum = 6; //分页显示，每一页的数据数量
	 
	 int Page = 0;//分页显示，总页数 
	
	 /**
	  * 通过id 获取发布的商品信息
	  * 
	  * @throws Exception
	  */
	 public void getGoodsById() throws Exception{
		 
		 String PageToStr = getRequestParam("PageTo");
		 
		 eject(PageToStr==null, "指定的跳转页不存在");
		 
		 int PageTo = Integer.parseInt(PageToStr);
		 
		 CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 List<UGoods> Goodlist = null;
		 
		 String pageStar = (PageTo-1)*PageNum + "";
		 
		 String pageEnd = (PageTo-1)*PageNum+PageNum + "";
		 
		 logger.info("getGoods");
		 try {
			 Goodlist  = service.getGoodsById(customUsers.getId(),pageStar,pageEnd);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//po.setMsg(e.getMessage());
			
		}finally{
			
			writeJSON(Goodlist);
		}
		 
	 }
	 
	 /**
	  * 
	  * 根据id获取购买信息
	  * 
	  */
	 public void getBuyGoodsById() throws Exception{
		 
		 String PageToStr = getRequestParam("PageTo");
		 
		 eject(PageToStr==null, "指定的跳转页不存在");
		 
		 int PageTo = Integer.parseInt(PageToStr);
		 
		 CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 List<UGoods> Goodlist = null;
		 
		 String pageStar = (PageTo-1)*PageNum + "";
		 
		 String pageEnd = (PageTo-1)*PageNum+PageNum + "";
		 
		 try {
			 Goodlist  = service.getBuyGoodsById(customUsers.getId(),pageStar,pageEnd);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//po.setMsg(e.getMessage());
			
		}finally{
			
			writeJSON(Goodlist);
		}
		 
	 }
	 
	 
	 
	 /**
	  * 通过id 获取商品总数
	  * 
	  * @throws Exception
	  */
	 
	 public void getGoodsCountById() throws Exception{
		 CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 int Goodscount = 0;//获取商品数据条数
		
		 try {
			 
			 Goodscount  = service.getGoodsCountById(customUsers.getId());
			 
			 Page = (Goodscount+PageNum-1)/PageNum;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			
		}finally{
			
			writeJSON(Page);
		}
	 }
	 
	 /**
	  * 通过id获取已购买的商品数量
	  * 
	  */
	 
	 public void getBuyGoodsCountById() throws Exception{
		 CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 int Goodscount = 0;//获取商品数据条数
		
		 try {
			 
			 Goodscount  = service.getBuyGoodsCountById(customUsers.getId());
			 
			 Page = (Goodscount+PageNum-1)/PageNum;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			
		}finally{
			
			writeJSON(Page);
		}
	 }
	 
	 /**
	  * 根据title查找商品
	 * @throws Exception 
	  * 
	  */
	 public void searchUGoodsBytitle() throws Exception{
		 
		 PageNum = 6; //分页显示，每一页的数据数量
		 
		 String PageToStr = getRequestParam("searchTo");
		 
		 eject(PageToStr==null, "指定的跳转页不存在");
		 
		 String title = getRequestParam("title");
		 
		 logger.info("title:"+title);
		 
		 int PageTo = Integer.parseInt(PageToStr);
		 
		// CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 List<UGoods> Goodlist = null;
		 
		 String pageStar = (PageTo-1)*PageNum + "";
		 
		 String pageEnd = (PageTo-1)*PageNum+PageNum + "";
		 
		 logger.info("getGoods");
		 try {
			 Goodlist  = service.searchUGoodsBytitle(title,pageStar,pageEnd);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//po.setMsg(e.getMessage());
			
		}finally{
			
			writeJSON(Goodlist);
		}
	 }
	 /**
	  * 
	  * 根据id获取商品的详细信息
	  * @throws Exception
	  */
	 public void getGoodsDetailById() throws Exception{
		 
		 eject(po==null, "商品不存在");
		 
		 try {
			 po = service.getGoodsDetailById(po.getId());
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			po.setMsg(e.getMessage());
			
		}finally{ 
			
			writeJSON(po);
		}
	 }
	 /**
	  * 
	  * 根据id 删除商品信息
	  * @throws Exception
	  */
	 public void updateGoodsByidAndStatus() throws Exception{
		 
		 eject(po==null, "商品不存在");
		 
		 try {
			 service.updateGoodsByidAndStatus(po);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}
	 }
	 /**
	  * 
	  * 根据id更新商品信息
	  * @throws Exception
	  */
	 public void UpdateUGoodsById() throws Exception{
		 
		 eject(po==null, "商品不存在");
		 
		 try {
			 service.UpdateUGoodsById(po);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			po.setMsg(e.getMessage());
			
		}
		 writeJSON(po);
	 }
	 
	 /**
	  * 根据id和status 获取商品信息
	  * 
	  */
	 public void getGoodsByIdAndStatus() throws Exception{
	
		 String status = getRequestParam("status");
		 
		 String PageToStr = getRequestParam("PageTo");
		 
		 eject(PageToStr==null, "指定的跳转页不存在");
		 
		 int PageTo = Integer.parseInt(PageToStr);
		 
		 CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 List<UGoods> Goodlist = null;
		 
		 String pageStar = (PageTo-1)*PageNum + "";
		 
		 String pageEnd = (PageTo-1)*PageNum+PageNum + "";
		 
		 logger.info("getGoods");
		 try {
			 Goodlist  = service.getGoodsByIdAndStatus(customUsers.getId(),status,pageStar,pageEnd);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//po.setMsg(e.getMessage());
			
		}finally{
			
			writeJSON(Goodlist);
		}
		 
	 }
	 /**
	  * 根据id和status获取购买信息
	  * 
	  */
	 
	 public void getBuyGoodsByIdAndStatus() throws Exception{
			
		 String status = getRequestParam("status");
		 
		 String PageToStr = getRequestParam("PageTo");
		 
		 eject(PageToStr==null, "指定的跳转页不存在");
		 
		 int PageTo = Integer.parseInt(PageToStr);
		 
		 CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 List<UGoods> Goodlist = null;
		 
		 String pageStar = (PageTo-1)*PageNum + "";
		 
		 String pageEnd = (PageTo-1)*PageNum+PageNum + "";
		 
		 try {
			 Goodlist  = service.getBuyGoodsByIdAndStatus(customUsers.getId(),status,pageStar,pageEnd);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//po.setMsg(e.getMessage());
			
		}finally{
			
			writeJSON(Goodlist);
		}
		 
	 }
	 
	 /**
	  * 根据title 获取已购买商品
	  * 
	  */
	 
 public void searchBuyUGoodsBuyBytitle() throws Exception{
		 
		 PageNum = 6; //分页显示，每一页的数据数量
		 
		 String PageToStr = getRequestParam("searchTo");
		 
		 eject(PageToStr==null, "指定的跳转页不存在");
		 
		 String title = getRequestParam("title");
		 
		 logger.info("title:"+title);
		 
		 int PageTo = Integer.parseInt(PageToStr);
		 
		// CustomUsers customUsers  = getSessionAttr(FILED_ONLINE_USER);
		 
		 List<UGoods> Goodlist = null;
		 
		 String pageStar = (PageTo-1)*PageNum + "";
		 
		 String pageEnd = (PageTo-1)*PageNum+PageNum + "";
		 
		 try {
			 Goodlist  = service.searchBuyUGoodsBuyBytitle(title,pageStar,pageEnd);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//po.setMsg(e.getMessage());
			
		}finally{
			
			writeJSON(Goodlist);
		}
	 }
 
 	/**
 	 * 根据id和status对购买商品进行相应操作
 	 * 
 	 */
 
 public void udateBuyGoodsByidAndStatus() throws Exception{
	 
	 eject(po==null, "商品不存在");
	 
	 try {
		 service.udateBuyGoodsByidAndStatus(po);
		
	} catch (Exception e) {
		
		e.printStackTrace();
		
	}
 }
 
	 /**
	  * 退货申请凭证上传
	  * 
	  */
 
 public void goodsCheckImgUpload(){
	 
	 service.goodsCheckImgUpload(po);
 }
}
