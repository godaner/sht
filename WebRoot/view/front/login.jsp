<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
	<form method="post"
		action="<c:url value='/usr.htm'></c:url>">
		名称：<input name="usercode" value="" /> 
		密码：<input name="password" value="" /> 
		<input type="submit" value="登录"/>
	</form>
</body>
</html>