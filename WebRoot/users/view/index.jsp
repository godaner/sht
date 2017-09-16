<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../../css/login_style.css">
<script type="text/javascript" src="../../js/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	${onlineUser.username}
	<a href="${baseUrl}/users/logout.action">注銷</a>
	<a href="javascript:showlogin();">想看登陆框吗</a>
		<!-- 登入框开始 -->
		<div class="login_box" style="display: none;">
		<form action="${baseUrl}/users/login.action" method="post">
		<a href="javascript:closelogin();" class="login_close" title="关闭">x</a>
			<div class="login_title">账户登录</div>
			<div class="login_input">
				<label>账号</label><input  name="username" type="text" value="" placeholder="                            用户名/邮箱" name="" />
				<hr />
				<label>密码</label><input type="password" value="" placeholder="                            请输入密码" name="" />
				<hr />
			</div><br />
			<div class="">
				<input type="submit" class="login_button" value="登陆二手交易市场"></input>
			</div><br />
			<div class="">
				<a href="#" class="forgive_a">忘记密码?</a>
			</div>
			<br />
			<div class="register_a">
				<a href="#">免费注册</a>
			</div>
		</form>
			
		</div>
		<!-- 登入框结束 -->
		
</body>
</html>

<script>
function showlogin(){
	$(".login_box").fadeIn("slow");
}
function closelogin(){
	$(".login_box").hide();
}

</script>