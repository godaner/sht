<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>重置登录密码</title>
	<link href="${baseUrl}/users/css/resetpassword.css" rel="stylesheet" type="text/css">
</head>

<body style="background-color:write;">
<%-- <%@include file="../../goods/view/commonTitle.jsp" %> --%>
		<div class="container">
			<div class="content">
				<div class="maincenter">
					<div class="maincenter-box">
						<form class="ui-form">
							<div class="ui-form-item">
								<label class="ui-label">账户名</label>
								<p class="ui-form-text">
									<span class="ui-text-amount">${onlineUser.username}</span>
								</p>
							</div>

							<div class="ui-form-item">
								<label class="ui-label">新的登录密码</label>
								<span class="alieditContainer">
									<input class="ui-input" type="password" id="password"/>
								</span>
								<p class="ui-form-explain">
									必须是8-20位英文字母、数字或符号，不能是纯数字
								</p>
							</div>
						
							<div class="ui-form-item">
								<label class="ui-label">确认新的登录密码</label>
								<span class="alieditContainer">
									<input class="ui-input" type="password" id="repassword" />
								</span>
							</div>

							<div class="ui-form-item">
								<div class="ui-button">
									<input class="ui-button-text" value="确定" type="button" onclick="changePassword();" />
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
		
		<input type="hidden" value="${onlineUser.username}" id="username">
		<input type="hidden" value="${baseUrl}" id="baseUrl">
		<%-- <%@include file="../../goods/view/commonFooter.jsp"%> --%>
	</body>
<%@include file="../../common/view/visit.jsp"%>


<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
var baseUrl = $("#baseUrl").val();
function changePassword(){
var username = $("#username").val();
var password = $("#password").val();
var repassword = $("#repassword").val();

if(password!=repassword){
	alert("两次密码不一致");
	$("#password").html();
	$("#repassword").html();
}else{
	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/changePasswordByObj.action",  //需要访问的地址
	    data :'username='+username+'&password='+password,  //传递到后台的参数
	    success:function(data){
	    	if(data['msg']){
	    	alert(data['msg']);
	    	}else{
	    		alert("修改成功，请重新登陆");
	    		window.parent.location.href=baseUrl+"/goods/view/index.jsp";
	    	}
	    },error:function(){
	    	alert("修改失败");
	    }
	}); 
}
	 
	
}

</script>
</html>