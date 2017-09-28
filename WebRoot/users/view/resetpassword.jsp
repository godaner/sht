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

<body>
<%@include file="../../goods/view/commonTitle.jsp" %>
		<div class="container">
			<div class="content">
				<div class="maincenter">
					<div class="maincenter-box">
						<form class="ui-form">
							<div class="ui-form-item">
								<label class="ui-label">账户名</label>
								<p class="ui-form-text">
									<span class="ui-text-amount">249***@qq.com</span>
								</p>
							</div>

							<div class="ui-form-item">
								<label class="ui-label">新的登录密码</label>
								<span class="alieditContainer">
									<input class="ui-input" type="password" />
								</span>
								<p class="ui-form-explain">
									必须是8-20位英文字母、数字或符号，不能是纯数字
								</p>
							</div>

							<div class="ui-form-item">
								<label class="ui-label">确认新的登录密码</label>
								<span class="alieditContainer">
									<input class="ui-input" type="password" />
								</span>
							</div>

							<div class="ui-form-item">
								<div class="ui-button">
									<input class="ui-button-text" value="确定" type="submit" />
								</div>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
		<%@include file="../../goods/view/commonFooter.jsp"%>
	</body>
<%@include file="../../common/view/visit.jsp"%>
</html>