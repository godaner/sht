<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布商品展示</title>
</head>
<body>
<!-- 搜索框 -->
			<div class="search">
			<input type="text" placeholder="请输入商品标题" onchange="searchUGoods();" id="search_input"/> <button onclick="searchUGoods();">搜索</button>
			</div>
			<!-- 顶部标题栏 -->
			<div class="title">
			<table class="title_table">
			<tr>
			<td></td>
			<td>宝贝标题</td>
			<td>介绍</td>
			<td>价格</td>
			<td>状态</td>
			<td>操作</td>
			</tr>
			</table>
			<br/>
			<div class="turnPage"></div>
			</div>
		<!-- 已发布列表 -->
	
		<div class="list">
	<!-- 	
		<div class='issue'>
		<div class='issue_title'><p>创建时间 :&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div>
		<div class='issue_body'>
	   <table class="title_table">
	   <tr>
	    <td><img  src='../img/content_icon.png'>
	    <a href="#"></a></td>
	    <td><p>介绍<p></td>
	    <td><p>价格<p></td>
	    <td><p>状态<p></td>
	    <td><a href="#">取消</a>&nbsp;|&nbsp;<a href="#">详情</a></td>
	    </tr>
	    </table>
	    </div>
	    </div>
		
		 -->
		</div>
		
		<div class="detail"></div>
		<div class="UpdateUGoods"></div>
		<input type="hidden" value="${baseUrl}" id="baseUrl"/>
		<input type="hidden" value="${onlineUser.id}" id="userid"/>
</body>
<style type="text/css">

		
.title{
	float: left;
    position: relative;
    display: block;
    height: 40px;
    width:900px;
    border: solid 1px grey;
    background-color:rgb(241,241,241);
}
.issue{
	margin-top:2%;
    height: 120px;
    width:900px;
    border: solid 1px grey;
}


.issue_title{
	margin-top:-2%;
	background-color:rgb(241,241,241);
	width:100%;
	height:30%;
}
.title_table tr td{
	width:80px;
	padding-left:60px;
	position:relative;
	left:-30px;
}

.title_table img{
	border:solid 1px black;
	width:40px;
	height:40px;
	position:relative;
	left:-30px;
}
.list{
	margin-top:8%;
}
.turnPage button{
	float:right;
	background-color:white;
	border:solid 1px grey;
	border-radius:5px;
	margin-left:5%;
	cursor:pointer;
}
.outprice{
text-decoration:line-through;
}	
	
</style>

<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
var PageTo = 0;
var searchTo = 1;
var maxPage = 1;

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
	    	$(".list").empty();
	    	$(".turnPage").empty();
	    	var h = "";
	    	h+="标题<input type='text' value='"+data['title']+"' id='title'/>介绍<input type='text' value='"+data['description']+"' id='description'/><br/>现价<input type='text' value='"+data['sprice']+"' id='sprice'/>原价<input type='text' value='"+data['price']+"' id='price'/><br/>成色<input type='text' value='"+data['condition']+"' id='condition'/>";
	    	h+="地区<input type='text' value='"+data['region']+"' id='region' /><p>状态"+data['status']+"</p><p>创建时间"+data['createtime']+"</p><p>浏览次数"+data['browse_number']+"</p><p>最后更新时间"+data['last_update_time']+"</p>";
	    	$(".detail").html(h);
	    	h="";
	    	h+="<button type='button' onclick=UpdateUGoodsById('"+id+"')>修改</button>";
			h+="<button type='button' onclick=''>返回</button>";
			$(".UpdateUGoods").html(h);
    		h="";
	    },error:function(){
	    	alert("失败");
	    }
	})
}
//删除单件商品
function deleteGoodsByid(id){
	if(confirm("确定要清除此数据吗？")){

		$.ajax({
			type : 'post',  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/U_deleteGoodsByid.action",  //需要访问的地址
		    data :'id='+id,  //传递到后台的参数
		    success:function(data){
		    	showList();
		    },error:function(){
		    	showList();
		    }
		});
		
	}

	
}


//商品列表显示
function showList(){
	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/U_getGoodsById.action",  //需要访问的地址
	    data :'PageTo='+PageTo,  //传递到后台的参数
	    success:function(data){
	    	//console.info(data);
	    		var h = "";
	    		var id = "";
	    		for(var i =0;i<data.length;i++){
	    			var goods = data[i];
	    			id = goods['id'];
	    		h+="<div class='issue'><div class='issue_title'><p>创建时间 :"+goods['createtime']+"&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div><div class='issue_body'>";
	    		h+="<table class='title_table'><tr><td><img  src='../img/content_icon.png'></td>";
	    		h+="<td><a href=javascript:showGoodsdetail('"+id+"');>"+goods['title']+"</a></td>";
	    		h+="<td><p>介绍"+goods['description']+"<p></td>";
	    		h+="<td><p>"+goods['sprice']+"</p><p class='outprice'> "+goods['price']+"<p></td>";
	    		h+="<td><p>状态"+goods['status']+"<p></td>";
	    		h+="<td><a href=javascript:deleteGoodsByid('"+id+"');>取消</a>&nbsp;|&nbsp;<a href=javascript:showGoodsdetail('"+id+"');>详情</a></td></tr></table></div></div>";
	    		}
	    		$(".list").html(h);
	    		h="";
	    		h+="<button type='button' onclick='NextPage();'>下一页</button>";
				h+="<button type='button' onclick='redPage();'>上一页</button>";
	    		$(".turnPage").html(h);
	    		h="";
	    	
	    },error:function(data){
	    	alert("失败");
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
		    		for(var i =0;i<data.length;i++){
		    			var goods = data[i];
		    			id = goods['id'];
		    			h+="<div class='issue'><div class='issue_title'><p>创建时间 :"+goods['createtime']+"&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div><div class='issue_body'>";
			    		h+="<table class='title_table'><tr><td><img  src='../img/content_icon.png'></td>";
			    		h+="<td><a href=javascript:showGoodsdetail('"+id+"');>"+goods['title']+"</a></td>";
			    		h+="<td><p>介绍"+goods['description']+"<p></td>";
			    		h+="<td><p>"+goods['sprice']+"</p><p class='outprice'> "+goods['price']+"<p></td>";
			    		h+="<td><p>状态"+goods['status']+"<p></td>";
			    		h+="<td><a href=javascript:deleteGoodsByid('"+id+"');>取消</a>&nbsp;|&nbsp;<a href=javascript:showGoodsdetail('"+id+"');>详情</a></td></tr></table></div></div>";
		    		}
		    		$(".list").html(h);
		    		h=""; 
		    	 
		    	
		    },error:function(data){
		    	alert("失败");
		    }
		});
	}



	}


</script>
</html>