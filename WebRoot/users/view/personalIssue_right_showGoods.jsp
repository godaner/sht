<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${baseUrl}/users/css/showGoods_common.css" rel="stylesheet" type="text/css" />
<link href="${baseUrl}/users/css/showGoods_style.css" rel="stylesheet" type="text/css" />
<title>发布商品展示</title>
</head>
<body style="background-color:white;">
<!-- 导航选择栏 -->
<div class="allList_show">
   <div class="Order_form_style">
      <div class="Order_form_filter" style="height:60px;">
       		<a href="javascript:void(0)" class="on" onclick="showList()" style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:10px;">所有订单</i></a>
			<a href="javascript:void(0)" onclick="showList('0')" style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:110px;">出售中</i></a>
			<a href="javascript:void(0)" onclick="showList('1')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:200px;">待发货</i></a>
			<a href="javascript:void(0)" onclick="showList('2')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:290px;">已发货</i></a>
			<a href="javascript:void(0)" onclick="showList('-3')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:380px;">待上架</i></a>
			<a href="javascript:void(0)" onclick="showList('-8')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:460px;">申请退款</i></a>
			<a href="javascript:void(0)" onclick="showList('-9')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:540px;">退款成功</i></a>
			<a href="javascript:void(0)" onclick="showList('-1')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:635px;">已完成订单</i></a>
			<a href="javascript:void(0)" onclick="showList('-6')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:740px;">待审核</i></a>
			<a href="javascript:void(0)" onclick="showList('-7')"style="width:80px;height:35px;margin-top:35px;"><i style="position:absolute;top:20px;left:815px;">未通过审核</i></a> 
      </div></div>
			<hr/>
			
			<!-- 搜索框 -->
		<div class="search iteam-warp">
			<input type="text" placeholder="请输入商品标题" onchange="searchUGoods();" id="search_input"/> <button onclick="searchUGoods();">搜索</button>
			</div> 
			
		<div class="cont" style="margin-left:15px;">
		
		<!-- 上下翻页按钮 -->
		<div class="turnPage"></div>
		<!-- 已发布列表 -->
		<div class="list">
		</div>
		
		
		</div>
		<!-- 详情修改 -->
		<div>
		<center>
		<div class="detail" style="margin-top:15px">
		
		</div>
		<div class="UpdateUGoods"></div>
		</center>
		</div>
		</div>	
		<input type="hidden" value="${baseUrl}" id="baseUrl"/>
		<input type="hidden" value="${onlineUser.id}" id="userid"/>
</body>
<style type="text/css">
	button{width:80px;height:38px}
	.cont{font-size:15px;border:1px dotted #a1a1a1;border-radius:10px;}

	table td{padding:8px};
	
	.iteam-warp{width:220px;height:26px;}
	
	input{width:200px;height:32px;}

</style>

<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
var PageTo = 0;
var searchTo = 1;
var maxPage = 1;
var status = "";

var userid = $("#userid").val();
var baseUrl =$("#baseUrl").val();
$(function(){
	NextPage();
	getGoodscount();
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
	    url : baseUrl+"/users/U_getGoodsCountById.action",  //需要访问的地址
	    data :'',  //传递到后台的参数
	    success:function(data){
	    	maxPage = data;
	    },error:function(){
	    	
	    }
	});
}


//修改商品
 function UpdateUGoodsById(id){
	var  title = $("#title").val();
	var  description = $("#description").val();
	var  sprice = $("#sprice").val();
	var  price = $("#price").val();
	var  condition = $("#condition").val();
	var  region = $("#region").val();
	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/U_UpdateUGoodsById.action",  //需要访问的地址
	    data :'id='+id+'&title='+title+'&description='+description+'&sprice='+sprice+'&price='+price+'&condition='+condition+'&region='+region,  //传递到后台的参数
	    success:function(data){
	    	$(".detail").empty;
	    	showList();
	    },error:function(){
	    	$(".detail").empty;
	    	showList();
	    }
	})
} 




//显示商品的详细信息
function showGoodsdetail(id){
	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/U_getGoodsDetailById.action",  //需要访问的地址
	    data :'id='+id,  //传递到后台的参数
	    success:function(data){
	    	console.info(data);
	    	$(".allList_show").empty();
	    	//$(".turnPage").empty();
	    	var h = "";
	    	status = showStatus(data['status']);
	    	h += "<table name='t1'><tr><td><div class='iteam-warp' style='dispaly:inline-block;'>标题:&nbsp;&nbsp;<input type='text' value='"+data['title']+"' id='title'/></div></td><td><div class='iteam-warp' style='float:right' >介绍:&nbsp;&nbsp;<input type='text' value='"+data['description']+"' id='description'/></div></td></tr><tr><td><div class='iteam-warp' style='dispaly:inline-block;'>现价:&nbsp;&nbsp;<input type='text' value='"+data['sprice']+"' id='sprice'/></div></td><td><div class='iteam-warp' style='float:right'>原价:&nbsp;&nbsp;<input type='text' value='"+data['price']+"' id='price'/></div></td></tr><tr><td><div class='iteam-warp' style='dispaly:inline-block;'>成色:&nbsp;&nbsp;<input type='text' value='"+data['condition']+"' id='condition'/></div></td><td><div class='iteam-warp' style='float:right'>地区:&nbsp;&nbsp;<input type='text' value='"+data['region']+"' id='region' /></div></td></tr></table>";
	    	
	    	h+="<table name='t2'><tr><td><p>状态:&nbsp;&nbsp;"+status+"</p></td><td><p>浏览次数:&nbsp;&nbsp;"+data['browsenumber']+"</p></td></tr><tr><td><p>创建时间:&nbsp;&nbsp;"+data['createtime']+"</p></td><td><p>最后更新时间:&nbsp;&nbsp;"+data['lastupdatetime']+"</p></td></tr></table>";
	    	$(".detail").html(h);
	    	h="";
	    	h+="<div style='display:inline-block;margin-left:180px;'><button type='button' onclick=UpdateUGoodsById('"+id+"')>修改</button></div>";
			h+="<div style='float:right;margin-right:300px'><button type='button' onclick='window.history.go(0)'>返回</button></div>";
			$(".UpdateUGoods").html(h);
    		h="";
	    },error:function(){
	    	alert("失败");
	    }
	})
}
//删除单件商品
function updateGoodsByidAndStatus(id,statu){
	if(confirm("确定要进行此操作吗？")){

		$.ajax({
			type : 'post',  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/U_updateGoodsByidAndStatus.action",  //需要访问的地址
		    data :'id='+id+'&status='+statu,  //传递到后台的参数
		    success:function(data){
		    	showList();
		    },error:function(){
		    	showList();
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
	}else if(status==-6){
		status="待审核";
	}else if(status==-7){
		status="未通过审核";
	}else if(status==-3){
		status="待上架";
	}else if(status==-9){
		status="退款成功";
	}
	return status;
}

//商品列表显示
function showList(status){
	var url="";
	if(status==""||status==null){
	url=baseUrl+"/users/U_getGoodsById.action";
	}else{
	url=baseUrl+"/users/U_getGoodsByIdAndStatus.action";
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
	    		h+="<a href=javascript:showGoodsdetail('"+id+"'); class='p_name'>"+goods['title']+"</a><p class='specification'>"+goods['description']+"</p></div></td><td style='text-decoration:line-through;'>"+goods['price']+"</td><td>"+goods['sprice']+"</td></tr></tbody></table></td>  ";	
	    		h+="<td class='split_line'><p style='color:#F30'>"+status+"</p></td>";	
	    		if(status=="已完成订单"){
	    			h+="<td class='operating'><a href=>查看评价</a></td></tr></tbody></table></div>";
	    		}else if(status=="出售中"){
	    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','-2');>取消出售</a></td></tr></tbody></table></div>";
	    		}else if(status=="待上架"){
	    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','0');>上架</a></td></tr></tbody></table></div>";
	    		}else if(status=="待发货"){
	    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','2');>发货</a></td></tr></tbody></table></div>";
	    		}else if(status=="申请退款"){
	    			if(goods['refusereturnmoneybill']){
	    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','-9');>同意退款</a>(已上传凭证)</td></tr></tbody></table></div>";
	    			}else{
	    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','-9');>同意退款</a></td></tr></tbody></table></div>";	
	    			}
	    		}else if(status=="退款成功"){
	    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','0');>重新上架</a></td></tr></tbody></table></div>";
	    		}else if(status=="已发货"){
	    			h+="<td class='operating'><a href='#'>等待买家确认收货</a></td></tr></tbody></table></div>";
	    		}else{
	    			h+="<td class='operating'><a href='#'>商品审核中无法操作</a></td></tr></tbody></table></div>";
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
	    	alert("请先登入");
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
		    url : baseUrl+"/users/U_searchUGoodsBytitle.action",  //需要访问的地址
		    data :'searchTo='+searchTo+"&title="+title,  //传递到后台的参数
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
		    		h+="<a href=javascript:showGoodsdetail('"+id+"'); class='p_name'>"+goods['title']+"</a><p class='specification'>"+goods['description']+"</p></div></td><td style='text-decoration:line-through;>"+goods['price']+"</td><td>"+goods['sprice']+"</td></tr></tbody></table></td>  ";	
		    		h+="<td class='split_line'><p style='color:#F30'>"+status+"</p></td>";	
		    		if(status=="已完成订单"){
		    			h+="<td class='operating'><a href=>查看评价</a></td></tr></tbody></table></div>";
		    		}else if(status=="出售中"){
		    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','-2');>取消出售</a></td></tr></tbody></table></div>";
		    		}else if(status=="待上架"){
		    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','0');>上架</a></td></tr></tbody></table></div>";
		    		}else if(status=="待发货"){
		    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','2');>发货</a></td></tr></tbody></table></div>";
		    		}else if(status=="申请退款"){
		    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','-9');>同意退款</a></td></tr></tbody></table></div>";
		    		}else if(status=="退款成功"){
		    			h+="<td class='operating'><a href=javascript:updateGoodsByidAndStatus('"+id+"','0');>重新上架</a></td></tr></tbody></table></div>";
		    		}else if(status=="已发货"){
		    			h+="<td class='operating'><a href='#'>等待买家确认收货</a></td></tr></tbody></table></div>";
		    		}else{
		    			h+="<td class='operating'><a href='#'>商品审核中无法操作</a></td></tr></tbody></table></div>";
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


</script>
</html>