<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <base href="${pageContext.request.contextPath }/">
    <link  href="goods/css/commonTitle.css" rel="stylesheet"/>
   <script type="text/javascript" src="goods/js/jquery-1.11.3.js"></script>
    <script src="goods/js/commonTitle.js" type="text/javascript"></script>
    <script src="users/js/myCover.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="users/js/login.js"></script>
	<script type="text/javascript" src="users/js/register.js"></script>
	<link rel="stylesheet" href="users/css/login_style.css">
	<link rel="stylesheet" href="users/css/register_style.css">
	<link rel="stylesheet" href="users/css/myCover.css">
</head>
<body>
<input type="hidden" value="${baseUrl}" id="baseUrl"/>
<nav>
    <ul>
        <li>SHT</li>
        <a href="goods/view/index.jsp"><li>首页</li></a>
        
        &nbsp;&nbsp;&nbsp;&nbsp;|
        <li><a href="javascript:judgmentLogin('${baseUrl}/goods/view/createGoods.jsp');" >发布闲置</a></li>
        <li class="idle">
		
         <a href="javascript:judgmentLogin('${baseUrl}/users/view/personalInfo.jsp');">   个人中心</a>
           <!--  <img src="goods/img/down_black.png"/>

            <a href="${baseUrl}/users/view/personalInfo.jsp">个人中心</a>
            <img src="goods/img/down_black.png"/>


            <div class="idle_down">
                <ul>
                    <li>
                        我的信息:&nbsp;&nbsp;<span>0</span>
                    </li>
                    <li>
                        我的发布:&nbsp;&nbsp;<span>0</span>
                    </li>
                    <li>
                        我的购买:&nbsp;&nbsp;<span>0</span>
                    </li>
                    <li>
                        地址管理:&nbsp;&nbsp;<span>0</span>
                    </li>
                </ul>
            </div> -->
        </li>
        <c:if test="${empty sessionScope.onlineUser.username}">
        <li >
            <a href="javascript:closeregister();showlogin();" >请登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:closelogin();showregister();" >注册</a>
        	<input type="hidden" value=" " id="onlineUser"/>
        </li>
		</c:if>
		
		 <c:if test="${not empty sessionScope.onlineUser.username}">
		 	<li>
		 		欢迎登陆:&nbsp;&nbsp;${sessionScope.onlineUser.username}
		 		&nbsp;&nbsp;|&nbsp;&nbsp;<a href="users/logout.action">注銷</a>
	
		 	</li>
		 	<input type="hidden" value="${sessionScope.onlineUser.id} " id="onlineUser"/>
		 </c:if>
    </ul>
</nav>

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
				<a href="${baseUrl}/users/view/setpassword.jsp" class="forgive_a">忘记密码?</a>
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
				<input type="checkbox" id="descript_book" checked/><a href="#" class="descript_book">《二手网协议》</a>
			</div>
			<div class="">
				<input type="button" onclick="register();"  class="register_button" value="注册二手交易市场"></input>
			</div>
		</div>
		<div id="mask" class="mask"></div> 
</body>
</html>