<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>密码找回</title>
	<link href="${baseUrl}/users/css/findpassword.css" rel="stylesheet" type="text/css">
</head>

<body>
<%@include file="../../goods/view/commonTitle.jsp" %>
		<div id="content">
			<div class="content-layout">
				<div class="maincenter">

					<div class="maincenter-tip">
						<p class="">
							<i class=""></i> 请输入你需要找回登录密码的用户名及绑定邮箱
						</p>
					</div>

					<form class="ui-form" method="post">
						<div class="ui-form-item">
							<label class="ui-label">用户名：</label>
							<input type="text" class="ui-input" placeholder="请输入用户名" />
							<!--<span class="ui-form-other">忘记会员名？可使用邮箱</span>-->
							<!--<div class="ui-form-explain">
								请输入邮箱
							</div>-->
						</div>
						<div class="ui-form-item">
							<label class="ui-label">邮箱地址：</label>
							<input type="text" class="ui-input" placeholder="请输入邮箱" />
							<!--<span class="ui-form-other">忘记会员名？可使用邮箱</span>-->
							<!--<div class="ui-form-explain">
								请输入邮箱
							</div>-->
						</div>

						<div class="ui-form-item">
							<input id="submitBtn" class="ui-button" value="确定" type="submit" />
						</div>
					</form>

				</div>
			</div>

		</div>
		<%@include file="../../goods/view/commonFooter.jsp"%>
	</body>
<%@include file="../../common/view/visit.jsp"%>
</html>