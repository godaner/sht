<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
	content="no-cache">
<title></title>
<base href="${pageContext.request.contextPath }/" />
	<script src="goods/js/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="goods/plugin/jquery.uploadify.min.js"
		type="text/javascript"></script>
	<script src="goods/js/createGoods.js" type="text/javascript"></script>
	
	 <script type="text/javascript" src="users/js/login.js"></script>
	<script type="text/javascript" src="users/js/register.js"></script>
	<link rel="stylesheet" href="users/css/login_style.css">
	<link rel="stylesheet" href="users/css/register_style.css">
	
<link rel="stylesheet" href="goods/css/createGoods.css" />
</head>
<body>
	<input type="hidden" value="${baseUrl}" id="baseUrl" />
	<%-- <div id="header">
		<h1>SHT二手交易</h1>
		<ul>
			<a href="goods/view/index.jsp">
				<li>首页</li>
			</a>
			<a href="#">
				<li>发布闲置</li>
			</a>
			<a href="#">
				<li>个人中心</li>
			</a>
		</ul>

		 <c:if test="${empty sessionScope.onlineUser.username}">
       
            <a href="javascript:showlogin();" >请登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:showregister();" >注册</a>
        	<input type="hidden" value=" " id="onlineUser"/>
        
		</c:if>
		
		 <c:if test="${not empty sessionScope.onlineUser.username}">
		 	
		 		欢迎登陆:&nbsp;&nbsp;${sessionScope.onlineUser.username}
		 		&nbsp;&nbsp;|&nbsp;&nbsp;<a href="users/logout.action">注銷</a>
	
		 	
		 	<input type="hidden" value="${sessionScope.onlineUser.id} " id="onlineUser"/>
		 </c:if>
	</div> --%>

	<jsp:include page="commonTitle.jsp" flush="false" />
	
	<div class="content">
		<div class="content-left">
			<img src="goods/img/content.png">

			<p>二狗</p>
			<ul>
				<li><img src="goods/img/heart.png"></li>
				<li><img src="goods/img/heart.png"></li>
				<li><img src="goods/img/heart.png"></li>
				<li><img src="goods/img/heart.png"></li>
				<li><img src="goods/img/vip.png"></li>

			</ul>

		</div>
		<div class="content-right">
			<form action="/sht/goods/createGoods.action" method="post"
				enctype="multipart/form-data">
				<div class="add-img">
					<ul>
						<li title="最多可添加五张图片" class="preview" id="add"><img
							src="goods/img/add.png" id="img"></li>
					</ul>
					<input id="file" type="file" name="files" multiple="multiple"
						style="visibility: hiden; width: 0; height: 0;" />

					<!-- <input id="file" type="file" name="files"
					 multiple="multiple" />
					
					<input id="file" type="file" name="files"
					 multiple="multiple" />
					
					<input id="file" type="file" name="files"
					 multiple="multiple" />
					
					<input id="file" type="file" name="files"
					 multiple="multiple" /> -->

					<!-- -->
				</div>
				<div class="line"></div>
				<div class="detail-info">
					<p>宝贝介绍&nbsp;:&nbsp;</p>
					<textarea name="description" placeholder="请详细描述你的宝贝..."
						id="description"></textarea>
					<ul>
						<li><span>商品名称&nbsp;:&nbsp;</span> <input type="text"
							name="title" placeholder="商品名称" id="title" /></li>
							
						<li><span>商品转卖价&nbsp;:&nbsp;</span> <input type="text"
							name="sprice" placeholder="商品转卖价" id="sprice" /></li>
							
						<br />
						<li><span>商品原价&nbsp;:&nbsp;</span> <input type="text"
							name="price" placeholder="商品原价" id="price" /></li>
							
						<li><span>商&nbsp;品&nbsp;&nbsp;成&nbsp;色&nbsp;:&nbsp;</span> 
						<select
							name="condition" id="condition">
								<option value="0">--请选择--</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
						</select>
						</li>
						
						<br />

						<li><span>所&nbsp;&nbsp;在&nbsp;&nbsp;地&nbsp;:&nbsp;</span> 
							<select name=province id="province">
								<option value="-1">--省份--</option>
							</select>
							<select name="city" id="city">
								<option value="-1">--市--</option>
							</select>
							<select name="county" id="county">
								<option value="-1">--县--</option>
							</select>
				        </li>

				<li><span>商&nbsp;品&nbsp;&nbsp;类&nbsp;别&nbsp;:&nbsp;</span> <select
					name="clazzs" id="clazzs">
						<option value="0">--请选择--</option>
				</select></li>
				</ul>
				<input type="submit" value="立即发布" id="create">
		</div>
		</form>
	</div>
	<div class="clearFloat"></div>
	</div>
	
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
				<input type="checkbox" id="descript_book" checked/><a href="#" class="descript_book">《二手网协议》</a>
			</div>
			<div class="">
				<input type="button" onclick="register();"  class="register_button" value="注册二手交易市场"></input>
			</div>
		</div>
</body>
</html>