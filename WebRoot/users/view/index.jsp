<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="${baseUrl}/users/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${baseUrl}/users/js/login.js"></script>
<script type="text/javascript" src="${baseUrl}/users/js/register.js"></script>
<script type="text/javascript" src="${baseUrl}/users/js/jquerySession.js"></script>
<link rel="stylesheet" href="${baseUrl}/users/css/login_style.css">
<link rel="stylesheet" href="${baseUrl}/users/css/register_style.css">
<title>Insert title here</title>
</head>
<body>
<%@include file="../../goods/view/commonTitle.jsp" %>
	${onlineUser.username}
	<a href="./personalInfo.jsp">个人信息页面</a>
	
	<a href="${baseUrl}/users/logout.action">注銷</a>
	<a href="javascript:showlogin();">想看登陆框吗</a>
	<a href="javascript:showregister();">想看注册框吗</a>
		<!-- 登入框开始 -->
		<div class="login_box" style="display: none;">
		<a href="javascript:closelogin();" class="login_close" title="关闭">x</a>
			<div class="login_title">账户登录</div><br>
			<div class="login_input">
				<label>账号</label><input id="username" name="username" type="text" value="" placeholder="                            用户名/邮箱"/>
				<hr /><br>
				<label>密码</label><input id="password" name="password" type="password" value="" placeholder="                            请输入密码" />
				<hr />
			</div>
			<div class="login_msg"></div>
			<div class="">
				<input type="button" onclick="login();" class="login_button" value="登陆二手交易市场"></input>
			</div><br />
			<div class="">
				<a href="#" class="forgive_a">忘记密码?</a>
			</div>
			<br />
			<div class="register_a">
				<a href="javascript:closelogin();showregister();">免费注册</a>
			</div>
		</div>
		<!-- 登入框结束 -->
		
		<!--注册框开始-->
		<div class="register_box" style="display: none;">
			<a href="javascript:closeregister();" class="register_close" title="关闭">x</a>
			<div class="register_title">账户注册</div>
			<div class="register_input">
				<label>账号</label><input type="text" value="" placeholder="请输入用户名" name="username" id="rs_username"/>
				<label>邮箱</label><input type="email" value="" placeholder="可用于登陆和找回密码" name="email" id="email" onblur="Check_email();"/>
				<label>验证码	</label><input id="code" type="text" value="" placeholder="输入验证码" name="code" id="code" /><img onclick="refreshVC();" id="codeimg" src="${baseUrl}/users/getVC.action"/>
				<label>密码</label><input type="text" value="" placeholder="请输入密码" name="password" id="rs_password" />
				<label>确认密码</label><input type="text" value="" placeholder="请确认密码" name="repassword" id="sure_ps" />
			</div>
			<div class="register_msg"></div>
			<div class="descript_book">
				<input type="checkbox"/><a href="#" class="descript_book">《二手网协议》</a>
			</div>
			<div class="">
				<input type="button" onclick="register();"  class="register_button" value="注册二手交易市场"></input>
			</div>
		</div>
		<!--注册框结束-->
		<!-- 获取项目地址 -->
		<input type="hidden" value="${baseUrl}" id="baseUrl"/>
<%@include file="../../goods/view/commonFooter.jsp"%>
</body>

</html>