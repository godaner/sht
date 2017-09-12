<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
</head>
<body>
	${msg}
	<a href="${baseUrl}/users/view/login.jsp">去登录</a>
	<!-- 注意,此处的url需与shiro的loginUrl相同 -->
	<form method="post"
		action="${baseUrl}/users/regist.action">
		名称：<input name="username" value="" /> 
		密码：<input name="password" value="" /> 
		<input type="submit" value="注册"/>
	</form>
</body>
</html>