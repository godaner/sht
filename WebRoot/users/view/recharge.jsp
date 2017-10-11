<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>充值</title>
	<link href="${baseUrl}/users/css/recharge.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%-- <%@include file="../../goods/view/commonTitle.jsp" %> --%>
		<div class="container" style="position:absolute;left:-280px;top:60px;">
			<div class="content">
				<div class="control-group">
					<label class="control-label">充值账号：</label>
					<div class="input-append">
						<i>${onlineUser.username }</i>
					</div>
				</div>
				
				
				<form name="alipayment" action="alipay.trade.page.pay.jsp" method="post" target="_blank" onsubmit="return checkMoney();">
				<input id="WIDout_trade_no" name="WIDout_trade_no" type="hidden" value="${onlineUser.id}" />
				<input id="yyyid" type="hidden" value="${onlineUser.id}" />
				<input id="WIDsubject" name="WIDsubject" type="hidden" value="SHT"/>
				<input id="WIDbody" name="WIDbody" type="hidden"/>
				<div class="control-group">
					<label class="control-label">充值金额：</label>
					<div class="input-append1">
						<input type="text" id="WIDtotal_amount" placeholder="请输入你要充值的金额" name="WIDtotal_amount"/>
						<p class="money">元</p>
					</div>
					
				</div>
				
				<div class="control-group">
					<label class="control-label">您的余额：</label>
					<div class="input-append">
						<i id="showMoney" style="font-size:16px;"></i>&nbsp;元
					</div>
				</div>
				<div class="control-group">
					<div class="input-append">
						<i style="color:grey;font-size:12px;">支付宝充值存在延迟到账情况，可以刷新页面或重新登入以便查看余额</i>
					</div>
				</div>
				<input class="recharge" type="submit" value="充值" style="position:absolute;top:160px;background-color:rgb(255,219,68);border:solid 1px rgb(255,219,68);border-radius:5px;font-size:16px;cursor: pointer;"/>
</form>
			</div>
		</div>
		<%-- <%@include file="../../goods/view/commonFooter.jsp"%> --%>
		<input type="hidden" value="${baseUrl}" id="baseUrl">
	</body>
	<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	var id = $("#yyyid").val();
	var baseUrl = $("#baseUrl").val();
	
		
		
	
	
	//用于动态获取用户余额
	function getMoney(){
		$.ajax({
			type : 'post',  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/getMoneyById.action",  //需要访问的地址
		    data :'id='+id,  //传递到后台的参数
		    success:function(data){
		    	$("#showMoney").html(data['money']);
		    }
		});
	}
	getMoney();
	//用于充值金额非空验证
	function checkMoney(){
	
	var money = $("#WIDtotal_amount").val();
	if(money==""||money==null){
		alert("	请输入充值金额");
		return false;
	}	
	}
	
	
	
	//创建订单号
	function GetDateNow() {
		var vNow = new Date();
		var sNow = "";
		sNow += String(vNow.getFullYear());
		sNow += String(vNow.getMonth() + 1);
		sNow += String(vNow.getDate());
		sNow += String(vNow.getHours());
		sNow += String(vNow.getMinutes());
		sNow += String(vNow.getSeconds());
		sNow += String(vNow.getMilliseconds());
		document.getElementById("WIDout_trade_no").value = id+"_"+sNow;
	}
	GetDateNow();  
	</script> 
<%@include file="../../common/view/visit.jsp"%>
</html>