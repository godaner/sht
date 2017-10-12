<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<script src="${baseUrl}/goods/js/jquery-1.11.3.js"
	type="text/javascript"></script>
<script src="${baseUrl}/goods/js/index.js"></script>
<link rel="stylesheet" href="${baseUrl}/goods/css/index.css" />

</head>
<body>

	<jsp:include page="commonTitle.jsp" flush="false" />
	
	<input type="hidden" value="${baseUrl}" id="baseUrl" />

	<article> <span>个人闲置:</span>

	<div id="option">
		<table>
			
		</table>
		<span id="show">展开</span>
	</div>
	<!--<br>--> 
	<section>
	<div class="title">
		<div>
			<ul class="select">

				<li>最新发布</li>
				<li>价格
					<div id="price">
						<img src="goods/img/price_top_grey.png" /> <img
							src="goods/img/price_down_grey.png" />
					</div>
				</li>
			</ul>
			&nbsp;&nbsp; <span class="line"></span> &nbsp;&nbsp;
			
			<ul class="select_1">
				<li>
					<input type="text" id="minPrice"/>&nbsp;&nbsp;-&nbsp;&nbsp;
					 <input type="text" id="maxPrice"/> 
					 <input type="button" value="确定" id="sure" />
				</li>
				&nbsp;&nbsp;
				
				<span class="line"></span> &nbsp;&nbsp;

			</ul>
			
		</div>
	</div>


	<div class="content">

		<div class="city">
			<div class="city_top">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<span>地区选择</span>

			<div>
				<ul>
					<li>全国</li>
					<li><img src="goods/img/city_choose.png"></li>
				</ul>
				&nbsp;&nbsp;<span></span>
			</div>
		</div>

		<div class="release_resale">
			<a href="goods/view/createGoods.jsp">
				<div class="release">
					<span>发布闲置</span> <img src="goods/img/release_right.png"> <span>闲置换钱&nbsp;快速出手</span>
				</div>
			</a>

		</div>

		<div class="city_info">
			<div>
				<span>选择期望交易的城市</span> <img src="goods/img/close_grey.png">
			</div>

			<table>
				
			</table>

		</div>

		<div class="trading_item_info">
			<ul>


			</ul>
		</div>
	</div>
	<br>
	<br>
	
	<footer>
	<div>
		<div class="pre">
			<img src="goods/img/pre_page.png" /> <span>上一页</span>
		</div>

		<ul class="page">

		</ul>
		<div class="next">
			<span>下一页</span> <img src="goods/img/next_page.png" />
		</div>
		<span class="allPage"></span>
	</div>
	</footer> 
	
	
	</section> </article>

	<%@ include file="commonFooter.jsp"%>
</body>

<%@include file="../../common/view/visit.jsp"%>


</html>