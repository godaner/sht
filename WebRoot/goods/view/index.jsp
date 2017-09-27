<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%--   <base href="${pageContext.request.contextPath }/"/> --%>
<script src="${baseUrl}/goods/js/jquery-1.11.3.js"
	type="text/javascript"></script>
<script src="${baseUrl}/goods/js/index.js"></script>
<link rel="stylesheet" href="${baseUrl}/goods/css/index.css" />

</head>
<body>
	<%@ include file="commonTitle.jsp"%>

	<input type="hidden" value="${baseUrl}" id="baseUrl" />

	<article> <span>个人闲置:</span>

	<div id="option">
		<table>
			<tr>
				<td><a href="#" title="女装">女装</a> <span>(5169.3万)</span></td>
				<td><a href="#" title="箱包">箱包</a> <span>(758.2万)</span></td>
				<td><a href="#" title="女士鞋靴">女士鞋靴</a> <span>(588.3万)</span></td>
				<td><a href="#" title="房屋租赁">房屋租赁</a> <span>(505.5万)</span></td>
				<td><a href="#" title="动漫/周边">动漫/周边</a> <span>(391.2万)</span></td>
			</tr>
			<tr>
				<td><a href="#" title="其它闲置">其它闲置</a> <span>(337.0万)</span></td>
				<td><a href="#" title="五金工具">五金工具</a> <span>(172.7万)</span></td>
				<td><a href="#">童鞋</a> <span>(121.3万)</span></td>
				<td><a href="#" title="电子零件">电子零件</a> <span>(101.3万)</span></td>
				<td><a href="#" title="奢侈名品">奢侈名品</a> <span>(99.9万)</span></td>
			</tr>
			<tr>
				<td><a href="#" title="生鲜水果">生鲜水果</a> <span>(82.8万)</span></td>
				<td><a href="#" title="鞋包配饰">鞋包配饰</a> <span>(82.8万)</span></td>
				<td><a href="#" title="鞋包配饰">鞋包配饰</a> <span>(82.8万)</span></td>
				<td><a href="#" title="园艺植物">园艺植物</a> <span>(81.3万)</span></td>
				<td><a href="#" title="话题/帖子">话题/帖子</a> <span>(71.3万)</span></td>
			</tr>
			<tr>
				<td><a href="#" title="服饰配件">服饰配件</a> <span>(48.5万)</span></td>
				<td><a href="#" title="工艺礼品">工艺礼品</a> <span>(28.5万)</span></td>
				<td><a href="#" title="农用物资">农用物资</a> <span>(15.7万)</span></td>
				<td><a href="#" title="母婴/儿童用品/玩具">母婴/儿童用品/玩具</a> <span>(2.8万)</span>
				</td>
				<td><a href="#" title="美容/美颜/香水">美容/美颜/香水</a> <span>(2.8万)</span>
				</td>
			</tr>
			<tr>
				<td><a href="#" title="古董收藏">古董收藏</a> <span>(2.8万)</span></td>
				<td><a href="#" title="二手整车">二手整车</a> <span>(1.4万)</span></td>
			</tr>
		</table>
		<span id="show">展开</span>
	</div>
	<!--<br>--> <section>
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
				<li><input type="text" />&nbsp;&nbsp;-&nbsp;&nbsp; <input
					type="text" /> <input type="button" value="确定" id="sure" /></li>
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
				&nbsp;&nbsp;<span>(47505243)</span>
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
				<tr>
					<td>全国</td>
					<td>直辖市</td>
					<td>河北</td>
					<td>山西</td>
					<td>内蒙古</td>
				</tr>
				<tr>
					<td>辽宁</td>
					<td>吉林</td>
					<td>黑龙江</td>
					<td>江苏</td>
					<td>浙江</td>
				</tr>
				<tr>
					<td>安徽</td>
					<td>福建</td>
					<td>江西</td>
					<td>山东</td>
					<td>河南</td>
				</tr>
				<tr>
					<td>湖北</td>
					<td>湖南</td>
					<td>广东</td>
					<td>广西</td>
					<td>海南</td>
				</tr>
				<tr>
					<td>四川</td>
					<td>贵州</td>
					<td>云南</td>
					<td>西藏</td>
					<td>陕西</td>
				</tr>
				<tr>
					<td>甘肃</td>
					<td>青海</td>
					<td>宁夏</td>
					<td>新疆</td>
					<td>台湾</td>
				</tr>
				<tr>
					<td>香港</td>
					<td>澳门</td>
					<td>海外</td>
				</tr>
			</table>

		</div>

		<div class="trading_item_info">
			<ul>
				

			</ul>
		</div>
	</div>
	<br>
	<br>
	<footer> <a href="">
		<div class="pre">
			<img src="goods/img/pre_page.png" /> <span>上一页</span>
		</div>
	</a>
	<ul class="page">
		<li>1</li>
		<li>2</li>
		<li>...</li>
		<li>100</li>
	</ul>
	<a href="">
		<div class="next">
			<span>下一页</span> <img src="goods/img/next_page.png" />
		</div>
	</a> <span class="allPage">共100页</span> </footer> </section> </article>

	<%@ include file="commonFooter.jsp"%>
</body>

<%@include file="../../common/view/visit.jsp"%>


</html>