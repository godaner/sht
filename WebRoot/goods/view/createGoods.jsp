<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" content="no-cache">
<title></title>
<base href="${pageContext.request.contextPath }/" />
<link rel="stylesheet" href="goods/css/createGoods.css" />
</head>
<body>
<input type="hidden" value="${baseUrl}" id="baseUrl"/>
	<div id="header">
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
		<a id="a_header_left" href="#">登录</a>&nbsp;|&nbsp; <a href="#">注册</a>
		<!--<div class="clearFloat"></div>-->
	</div>

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
			<form action="/sht/goods/createGoods.action" method="post" enctype="multipart/form-data">
			<div class="add-img">
				<ul>
					<li title="最多可添加五张图片" class="preview" id="add"><img src="goods/img/add.png" id="img"></li>
				</ul>
					<input id="file" type="file" name="files"
					 multiple="multiple" />
					
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
				<textarea name="description" placeholder="请详细描述你的宝贝..." id="description"></textarea>
				<ul>
					<li><span>商品名称&nbsp;:&nbsp;</span> <input type="text"
						name="title" placeholder="商品名称" id="title" /></li>
					<li><span>商品转卖价&nbsp;:&nbsp;</span> <input type="text"
						name="sprice" placeholder="商品转卖价" id="sprice" /></li>
					<br />
					<li><span>商品原价&nbsp;:&nbsp;</span> <input type="text"
						name="price" placeholder="商品原价" id="price" /></li>
					<li><span>商&nbsp;品&nbsp;&nbsp;成&nbsp;色&nbsp;:&nbsp;</span> <input
						name="condition" type="text" placeholder="商品成色" id="condition" /></li>
					<br />
					<li><span>所&nbsp;&nbsp;在&nbsp;&nbsp;地&nbsp;:&nbsp;</span> <input
						name="region" type="text" placeholder="所在地" id="region" /></li>
				</ul>
				<input type="submit" value="立即发布" id="create">
			</div>
			</form>
		</div>
		<div class="clearFloat"></div>
	</div>
	<script src="goods/js/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="goods/plugin/jquery.uploadify.min.js" type="text/javascript"></script>
	<script src="goods/js/createGoods.js" type="text/javascript"></script>
</body>
</html>