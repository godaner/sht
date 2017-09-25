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
			<table id="title_table">
			<tr>
			<td>宝贝标题</td>
			<td>介绍</td>
			<td>价格</td>
			<td>状态</td>
			<td>操作</td>
			</tr>
			</table>
			<div class="turnPage">
			<button type="button" onclick="NextPage();">下一页</button>
			<button type="button" onclick="redPage();">上一页</button>
			</div>
			</div>
		<!-- 已发布列表 -->
	
		<div class="list"></div>
		
			
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
	float: left;
    position: relative;
    display: block;
    height: 120px;
    width:900px;
    border: solid 1px grey;
}


.issue_title{
	background-color:rgb(241,241,241);
	width:100%;
	height:30%;
}
#title_table tr td{
	padding-left:80px;
}
.list{
	margin-top:6%;
}
.turnPage button{
	margin-top:2%;
	float:right;
	background-color:white;
	border:solid 1px grey;
	border-radius:5px;
	margin-left:5%;
	cursor:pointer;
</style>

<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
var PageTo = 0;
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
	
	
	
	})
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
	    		for(var i =0;i<data.length;i++){
	    			var goods = data[i];
	    		
	    		h+="<div class='issue'><div class='issue_title'><p>创建时间 :"+goods['createtime']+"&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div><div class='issue_body'>";
	    		h+="<table><tr><td><img  src='../img/content_icon.png'></td><td><p>"+goods['title']+"<p></td>";
	    		h+="<td><p>介绍"+goods['description']+"<p></td>";
	    		h+="<td><p>价格"+goods['price']+" "+goods['sprice']+"<p></td>";
	    		h+="<td><p>状态"+goods['status']+"<p></td>";
	    		h+="<td><a href='#'>删除</a>&nbsp;|&nbsp;<a href='#'>详情</a></td></tr></table></div></div>";
	    		}
	    		$(".list").html(h);
	    		h="";
	    	
	    	
	    },error:function(data){
	    	alert("失败");
	    }
	});
	
	
//搜索商品
function searchUGoods(){
	
	var title = $("#search_input").val();
	
	alert(title);

	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/U_searchUGoodsBytitle.action",  //需要访问的地址
	    data :'PageTo='+PageTo+"&title="+title,  //传递到后台的参数
	    success:function(data){
	    	console.info(data);
	    		/* var h = "";
	    		for(var i =0;i<data.length;i++){
	    			var goods = data[i];
	    		
	    		h+="<div class='issue'><div class='issue_title'><p>创建时间 :"+goods['createtime']+"&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div><div class='issue_body'>";
	    		h+="<table><tr><td><img  src='../img/content_icon.png'></td><td><p>"+goods['title']+"<p></td>";
	    		h+="<td><p>介绍"+goods['description']+"<p></td>";
	    		h+="<td><p>价格"+goods['price']+" "+goods['sprice']+"<p></td>";
	    		h+="<td><p>状态"+goods['status']+"<p></td>";
	    		h+="<td><a href='#'>删除</a>&nbsp;|&nbsp;<a href='#'>详情</a></td></tr></table></div></div>";
	    		}
	    		$(".list").html(h);
	    		h="";
	    	 */
	    	
	    },error:function(data){
	    	alert("失败");
	    }
	});
	}
}

</script>
</html>