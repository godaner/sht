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
						<input type="text" placeholder="" value="${onlineUser.username }" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">充值金额：</label>
					<div class="input-append1">
						<input type="text" placeholder="请输入你要充值的金额" />
						<p class="money">元</p>
					</div>
					
				</div>
				
				<div class="control-group">
					<label class="control-label">您的余额：</label>
					<div class="input-append">
						<i style="font-size:16px;">${onlineUser.money}</i>
					</div>
				</div>
				<div class="control-group">
					<div class="input-append">
						<i style="color:grey;font-size:12px;">注意：本平台暂时只支持支付宝充值</i>
					</div>
				</div>
				
				
				<input class="recharge" type="submit" value="充值" style="position:absolute;top:160px;background-color:rgb(255,219,68);border:solid 1px rgb(255,219,68);border-radius:5px;font-size:16px;cursor: pointer;"/>

			</div>
		</div>
		<%-- <%@include file="../../goods/view/commonFooter.jsp"%> --%>
	</body>
<%@include file="../../common/view/visit.jsp"%>
</html>