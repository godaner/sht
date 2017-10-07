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

			<!-- 导航选择栏 -->
			<div class="choose_status">
			
			<a href="javascript:void(0)" onclick="showList()">所有订单 &nbsp;&nbsp;|</a>
			<a href="javascript:void(0)" onclick="showList('1')">待发货&nbsp;&nbsp;|</a>
			<a href="javascript:void(0)" onclick="showList('2')">已发货&nbsp;&nbsp;|</a>
			<a href="javascript:void(0)" onclick="showList('-8')">申请退款&nbsp;&nbsp;|</a>
			<a href="javascript:void(0)" onclick="showList('-9')">退款成功&nbsp;&nbsp;|</a>
			<a href="javascript:void(0)" onclick="showList('-1')">已完成订单&nbsp;&nbsp;|</a>
			</div>
			<hr/>
			<!-- 搜索框 -->
			<div class="search">
			<input type="text" placeholder="请输入商品标题" onchange="searchUGoods();" id="search_input"/> <button onclick="searchUGoods();">搜索</button>
			</div>
			<!-- 顶部标题栏 -->
			<div class="title">
			<table class="title_table">
			<tr id="title_table_tr">
			<td></td>
			<td>宝贝</td>
			<td>介绍</td>
			<td>价格</td>
			<td>状态</td>
			<td>操作</td>
			</tr>
			</table>
			<br/>
			<div class="turnPage"></div>
			</div>

		<div class="list"></div>
		
		<div class="detail"></div>
		<div class="UpdateUGoods"></div>
		<input type="hidden" value="${baseUrl}" id="baseUrl"/>
		<input type="hidden" value="${onlineUser.id}" id="userid"/>
		<input type="hidden" value="${onlineUser.password}" id="userpassword"/>
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
    height: 100px;
    width:900px;
    border: solid 1px #EDEDED;
    
}

 .title table tr td{
	position:relative;
	left:-35px;
	border:none;
} 
.issue_title{
	margin-top:-2%;
	background-color:rgb(241,241,241);
	width:100%;
	height:30%;
}
.title_table tr td{
	width:80px;
	padding-left:65px;
	position:relative;
	text-align:center;
	border-left:solid 1px #F2F2F2;
	top:-20px;
	left:-2px;
}
#title_table_tr td{
	width:80px;
	padding-left:65px;
	position:relative;
	text-align:center;
	border-left:solid 1px #F2F2F2;
	top:5px;
}

.title_table tr td p,a{
	position:relative;
	left:-35px;
}
.issue_body table{
	height:100px;
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
	font-size:13px;
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
.detail input{
	 border-style:none;
	 border:solid 1px black;
	 border-radius:5px;
	 /* margin-left:40px; */
	 margin:10px 20px;
}
.UpdateUGoods button{
	border-style:none; 
	border-radius:5px;
	background-color: #EEEED1;
	margin-left:100px;
	height:30px;
	width:70px;
	cursor:pointer;
}	

.choose_status{
	position:relative;
	left:80px;
}
a{
	font-size:14px;
	color:grey;
	text-decoration: none; 
}
a:HOVER {
	color:red;
}



</style>

<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
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




//显示商品的详细信息
/* function showGoodsdetail(id){
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
	    	status = showStatus(data['status']);
	    	h+="标题<input type='text' value='"+data['title']+"' id='title'/>介绍<input type='text' value='"+data['description']+"' id='description'/><br/>现价<input type='text' value='"+data['sprice']+"' id='sprice'/>原价<input type='text' value='"+data['price']+"' id='price'/><br/>成色<input type='text' value='"+data['condition']+"' id='condition'/>";
	    	h+="地区<input type='text' value='"+data['region']+"' id='region' /><p>状态:"+status+"</p><p>创建时间:"+data['createtime']+"</p><p>浏览次数:"+data['browsenumber']+"</p><p>最后更新时间:"+data['lastupdatetime']+"</p>";
	    	$(".detail").html(h);
	    	h="";
	    	h+="<button type='button' onclick=UpdateUGoodsById('"+id+"')>修改</button>";
			h+="<button type='button' onclick='window.history.go(0)'>返回</button>";
			$(".UpdateUGoods").html(h);
    		h="";
	    },error:function(){
	    	alert("失败");
	    }
	})
} */
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
    	    	console.info(data);
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
	    	//console.info(data);
	    		 var h = "";
	    		var id = "";
	    		for(var i =0;i<data.length;i++){
	    			var goods = data[i];
	    			id = goods['id'];
	    			status = showStatus(goods['status']);
	    		h+="<div class='issue'><div class='issue_title'><p>创建时间 :"+goods['createtime']+"&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div><div class='issue_body'>";
	    		h+="<table class='title_table'><tr><td><img  src='../img/content_icon.png'></td>";
	    		h+="<td><a href=javascript:showGoodsdetail('"+id+"');>"+goods['title']+"</a></td>";
	    		h+="<td><p>"+goods['description']+"<p></td>";
	    		h+="<td><p>现价："+goods['sprice']+"</p><p class='outprice'>原价： "+goods['price']+"<p></td>";
	    		h+="<td><p>"+status+"<p></td>";
	    		if(status=="待发货"){
	    			h+="<td><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-3');>取消购买</a></td></tr></table></div></div>";
	    		}else if(status=="已发货"){
	    			h+="<td><a href=javascript:prom('"+id+"','-1');>确认收货</a></td></tr></table></div></div>";	
	    		}else if(status=="已完成订单"){
	    			h+="<td><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-8');>申请退款</a></td></tr></table></div></div>";
	    		}else if(status=="申请退款"){
	    			h+="<td><a hreef='#'>上传凭证</a></td></tr></table></div></div>";
	    		}else{
	    			h+="<td><a hreef='#'>操作已完成</a></td></tr></table></div></div>";
	    		}
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
		    		h+="<div class='issue'><div class='issue_title'><p>创建时间 :"+goods['createtime']+"&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p></div><div class='issue_body'>";
		    		h+="<table class='title_table'><tr><td><img  src='../img/content_icon.png'></td>";
		    		h+="<td><a href=javascript:showGoodsdetail('"+id+"');>"+goods['title']+"</a></td>";
		    		h+="<td><p>"+goods['description']+"<p></td>";
		    		h+="<td><p>现价："+goods['sprice']+"</p><p class='outprice'>原价： "+goods['price']+"<p></td>";
		    		h+="<td><p>"+status+"<p></td>";
		    		if(status=="待发货"){
		    			h+="<td><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-3');>取消购买</a></td></tr></table></div></div>";
		    		}else if(status=="已发货"){
		    			h+="<td><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-1');>确认收货</a></td></tr></table></div></div>";	
		    		}else if(status=="已完成订单"){
		    			h+="<td><a href=javascript:udateBuyGoodsByidAndStatus('"+id+"','-8');>申请退款</a></td></tr></table></div></div>";
		    		}else if(status=="申请退款"){
		    			h+="<td><a hreef='#'>上传凭证</a></td></tr></table></div></div>";
		    		}
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