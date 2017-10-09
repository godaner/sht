<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${baseUrl}/users/css/showGoods_common.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/users/css/showGoods_style.css" rel="stylesheet" type="text/css" />
<title>购买商品展示</title>
</head>
<body style="background-color:white;">

			<!-- 导航选择栏 -->
	<div class="Order_form_style">
      <div class="Order_form_filter" style="height:60px;">
       		<a href="javascript:void(0)" class="on" onclick="showList()" style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:10px;">所有订单</i></a>
			<a href="javascript:void(0)" onclick="showList('1')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:110px;">待发货</i></a>
			<a href="javascript:void(0)" onclick="showList('2')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:200px;">已发货</i></a>
			<a href="javascript:void(0)" onclick="showList('-8')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:280px;">申请退款</i></a>
			<a href="javascript:void(0)" onclick="showList('-9')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:370px;">退款成功</i></a>
			<a href="javascript:void(0)" onclick="showList('-1')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:455px;">已完成订单</i></a>
      </div></div>
			<hr/>
			<!-- 搜索框 -->
			<div class="search">
			<input type="text" placeholder="请输入商品标题" onchange="searchUGoods();" id="search_input"/> <button onclick="searchUGoods();">搜索</button>
			</div>


		<div class="turnPage"></div>
		<div class="list"></div>
		
		<div class="detail"></div>
		<div class="UpdateUGoods"></div>
		<input type="hidden" value="${baseUrl}" id="baseUrl"/>
		<input type="hidden" value="${onlineUser.id}" id="userid"/>
		<input type="hidden" value="${onlineUser.password}" id="userpassword"/>
</body>

<script type="text/javascript" src="${baseUrl}/users/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
var PageTo = 0;
var searchTo = 1;
var maxPage = 1;
var status = "";

var userid = $("#userid").val();
var baseUrl =$("#baseUrl").val();
var userpassword =$("#userpassword").val();
$(function(){
	getGoodscount();
	NextPage();
});

function NextPage(){
	if(PageTo>=maxPage){
		return;
	}
	PageTo++;
	showList();
}

function redPage(){
	if(PageTo<=1){
		return;
	}
	PageTo--;
	showList();
}
//获取商品总数
function getGoodscount(){
	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/U_getBuyGoodsCountById.action",  //需要访问的地址
	    data :'',  //传递到后台的参数
	    success:function(data){
	    	maxPage = data;
	    },error:function(){
	    	
	    }
	});
}

//根据操作改变相应的状态
 function udateBuyGoodsByidAndStatus(id,statu){
	if(confirm("确定要进行此操作吗？")){
		$.ajax({
			type : 'post',  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/U_udateBuyGoodsByidAndStatus.action",  //需要访问的地址
		    data :'id='+id+'&status='+statu,  //传递到后台的参数
		    success:function(data){
		    	showList();
		    },error:function(){
		    	showList();
		    }
		});
		
	}
} 


//收货密码确认
function prom(id,statu)
{
    var pas=prompt("请输入支付密码","");
    
    if(pas){
    	$.ajax({
    		type : 'post',  //请求方式,get,post等
    	    dataType:'json',//response返回数据的格式
    	    async : true,  //同步请求  
    	    url : baseUrl+"/users/checkPassword.action",//需要访问的地址
    	    data :'password='+pas,  //传递到后台的参数
    	    success:function(data){
    	    	//console.info(data);
    	    	if(data['msg']){
    	    		alert(data['msg']);
    	    	}else{
    	    		udateBuyGoodsByidAndStatus(id,statu);
    	    	}
    	    	}
        });    
    }
}



function showStatus(status){
	if(status==0){
		status="出售中";
	}else if(status==1){
		status="待发货";
	}else if(status==2){
		status="已发货";
	}else if(status==-8){
		status="申请退款";
	}else if(status==-1){
		status="已完成订单";
	}else if(status==-9){
		status="退款成功";
	}
	return status;
}

//商品列表显示
function showList(status){
	var url="";
	if(status==""||status==null){
	url=baseUrl+"/users/U_getBuyGoodsById.action";
	}else{
	url=baseUrl+"/users/U_getBuyGoodsByIdAndStatus.action";
	}
	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : url,//需要访问的地址
	    data :'PageTo='+PageTo+'&status='+status,  //传递到后台的参数
	    success:function(data){
	    	console.info(data);
	    		 var h = "";
	    		var id = "";
	    		for(var i =0;i<data.length;i++){
	    			var goods = data[i];
	    			id = goods['id'];
	    			status = showStatus(goods['status']);
	    			
	    			h+="<div class='Order_form_list'><table><thead><tr><td class='list_name_title0'>商品</td><td class='list_name_title1'>原 价(元 )</td><td class='list_name_title2'>现价(元)</td><td class='list_name_title5'>订单状态</td><td class='list_name_title6'>操作</td></tr></thead>";
		    		h+="<tbody><tr class='Order_info'><td colspan='6' class='Order_form_time'><input name='' type='checkbox' class='checkbox'/>下单时间："+goods['createtime']+" | 订单号：暂无 <em></em></td></tr>";	
		    		h+="<tr class='Order_Details'><td colspan='3'><table class='Order_product_style'><tbody><tr><td><div class='product_name clearfix'><a href='#' class='product_img'><img src='http://localhost/sht/common/goods_getGoodsImg.action?size=200&imgName="+goods['mainImgPath']+"' width='80px' height='80px'></a>";	
		    		h+="<a href=javascript:showGoodsdetail('"+id+"'); class='p_name'>"+goods['title']+"</a><p class='specification'>"+goods['description']+"</p></div></td><td>"+goods['price']+"</td><td>"+goods['sprice']+"</td></tr></tbody></table></td>  ";	
		    		h+="<td class='split_line'><p style='color:#F30'>"+status+"</p></td>";	
		    		if(status=="待发货"){
		    			h+="<td class='operating'><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-3');>取消购买</a></td></tr></tbody></table></div>";
		    		}else if(status=="已发货"){
		    			h+="<td class='operating'><a href=javascript:prom('"+id+"','-1');>确认收货</a></td></tr></tbody></table></div>";
		    		}else if(status=="已完成订单"){
		    			h+="<td class='operating'><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-8');>申请退款</a></td></tr></tbody></table></div>";
		    		}else if(status=="申请退款"){
		    			h+="<td class='operating'><form action='"+baseUrl+"/users/U_goodsCheckImgUpload.action?id="+id+"' method='post' enctype='multipart/form-data' onsubmit='return file_is_null();'><i style='position:absolute;left:35%;'>选择凭证</i><input class='check_file_is_null' type='file' name='fiile' style='opacity:0;width:130px;'><input id='save_btn' type='submit' value='上传凭证'></form></a></td></tr></tbody></table></div>";
		    		}else{
		    			h+="<td class='operating'><a href='#'>前往评价</a></td></tr></tbody></table></div>";
		    		}
		    		h+="<br/><br/>";
	    		}
	    		$(".list").html(h);
	    		h="";
	    		h+="<button type='button' onclick='NextPage();'>下一页</button>";
				h+="<button type='button' onclick='redPage();'>上一页</button>";
	    		$(".turnPage").html(h);
	    		h="";
	    		status=""; 
	    },error:function(data){
	    	alert("获取购买信息失败，请先登录");
	    }
	});
}
	
//搜索商品
function searchUGoods(){
	
	var title = $("#search_input").val();
	
	if(title!=null&&title!=""){
		$(".turnPage").empty();
		$.ajax({
			type : 'post',  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/U_searchBuyUGoodsBuyBytitle.action",  //需要访问的地址
		    data :'searchTo='+searchTo+"&title="+title,  //传递到后台的参数
		    success:function(data){
		    	 var h = "";
		    		var id = "";
		    		for(var i =0;i<data.length;i++){
		    			var goods = data[i];
		    			id = goods['id'];
		    			status = showStatus(goods['status']);
		    			h+="<div class='Order_form_list'><table><thead><tr><td class='list_name_title0'>商品</td><td class='list_name_title1'>原 价(元 )</td><td class='list_name_title2'>现价(元)</td><td class='list_name_title5'>订单状态</td><td class='list_name_title6'>操作</td></tr></thead>";
			    		h+="<tbody><tr class='Order_info'><td colspan='6' class='Order_form_time'><input name='' type='checkbox' class='checkbox'/>下单时间："+goods['createtime']+" | 订单号：暂无 <em></em></td></tr>";	
			    		h+="<tr class='Order_Details'><td colspan='3'><table class='Order_product_style'><tbody><tr><td><div class='product_name clearfix'><a href='#' class='product_img'><img src='http://localhost/sht/common/goods_getGoodsImg.action?size=200&imgName="+goods['mainImgPath']+"' width='80px' height='80px'></a>";	
			    		h+="<a href=javascript:showGoodsdetail('"+id+"'); class='p_name'>"+goods['title']+"</a><p class='specification'>"+goods['description']+"</p></div></td><td>"+goods['price']+"</td><td>"+goods['sprice']+"</td></tr></tbody></table></td>  ";	
			    		h+="<td class='split_line'><p style='color:#F30'>"+status+"</p></td>";	
			    		if(status=="待发货"){
			    			h+="<td class='operating'><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-3');>取消购买</a></td></tr></tbody></table></div>";
			    		}else if(status=="已发货"){
			    			h+="<td class='operating'><a href=javascript:prom('"+id+"','-1');>确认收货</a></td></tr></tbody></table></div>";
			    		}else if(status=="已完成订单"){
			    			h+="<td class='operating'><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-8');>申请退款</a></td></tr></tbody></table></div>";
			    		}else if(status=="申请退款"){
			    			h+="<td class='operating'><form action='"+baseUrl+"/users/personalImgUpload.action' method='post' enctype='multipart/form-data'><input type='file' name='fiile'><button id='save_btn' type='submit'>上传凭证</button></form></a></td></tr></tbody></table></div>";
			    		}else{
			    			h+="<td class='operating'><a href='#'>前往评价</a></td></tr></tbody></table></div>";
			    		}
			    		h+="<br/><br/>";
		    		}
		    		$(".list").html(h);
		    		h="";
		    		h+="<button type='button' onclick='NextPage();'>下一页</button>";
					h+="<button type='button' onclick='redPage();'>上一页</button>";
		    		$(".turnPage").html(h);
		    		h="";
		    		status=""; 
		    },error:function(data){
		    	alert("失败");
		    }
		});
	}
 

	}



//凭证上传非空验证
function file_is_null(){
	if(!$(".check_file_is_null").val()){
		alert("请选择文件");
		return false;
	}
}



</script>
</html>