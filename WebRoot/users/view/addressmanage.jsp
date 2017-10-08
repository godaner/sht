<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>收货地址</title>
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${baseUrl}/users/css/addressmanage.css" rel="stylesheet">
<link href="${baseUrl}/users/css/bootstrap.css" rel="stylesheet">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <link rel="stylesheet" href="${baseUrl}/users/css/personalInfo.css" /> --%>

<script src="${baseUrl}/users/js/jquery.js"></script>
<%-- <script src="${baseUrl}/users/js/bootstrap.js"></script>
<script src="${baseUrl}/users/js/city-picker.data.js"></script>
<script src="${baseUrl}/users/js/city-picker.js"></script>
<script src="${baseUrl}/users/js/main.js"></script> --%>
</head>

<body>

	<div id="bodyright">
		<h2 class="head">
			<span class="enticy">收货地址</span>
		</h2>

		<input type="hidden" id="id" name="id" value="id" /> <input
			type="hidden" id="master" name="master" value="用户id" />

		<div class="form-box">
			<!--概要提示-->
			<div class="addAddress_input">

				<div class="item item-title ">
					<span id="left1">新增收货地址</span> <span id="right1"><i>*</i>标记为必填项，其余为选填项</span>
				</div>

				<!--所在地区-->
				<div class="item item-devision">
					<span class="left2">所在地区<i>*</i></span>

					<div class="right2">
						<select class="sc" id="country">
							<option class="ot">中国</option>
						</select> <select class="sc" id="province"></select> <select class="sc"
							id="city"></select> <select class="sc" id="county"></select>
					</div>
				</div>

				<!--详细地址-->
				<div class="street">
					<span class="left3">详细地址<i>*</i></span>
					<textarea class="inputbox" name="detail" id="detail"
						placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"
						style="margin-top: 0px; width: 400px; height: 70px"></textarea>
				</div>

				<!--邮政编码-->
				<div class="postcode">
					<span class="left4">邮政编码</span>
					<div class="iteam-warp">
						<input type="text" name="postcode" id="postcode" class="i-text"
							placeholder="长度不超过10个字符" data-pattern="^.{0,10}$" />
					</div>
				</div>

				<!--收货人姓名-->
				<div class="itemname">
					<span class="left4"> 收货人姓名 <i>*</i>
					</span>
					<div class="iteam-warp">
						<input type="text" name="realname" id="realname" class="i-text"
							placeholder="长度不超过20个字符" data-pattern="^.{2,20}$" />
					</div>
				</div>

				<!--手机号码-->
				<div class="iteamMobile">
					<span class="left4">手机号码<i>*</i></span> <select id="mobile">
						<option value="1">中国大陆+86</option>
						<option value="2">香港+852</option>
						<option value="3">澳门+853</option>
						<option value="4">台湾+886</option>
						<option value="5">海外+1</option>
					</select>
					<div class="iteam-warp">
						<input type="text" name="phone" id="phone" class="i-text"
							data-pattern="^\d{6,20}$" />
					</div>
				</div>

				<!--默认地址勾选项-->
				<div class="iteamdefault">
					<label class="tsl">设置为默认收货地址 <input id="setdefalut"
						name="isdefault" type="checkbox" />
					</label>
				</div>

			</div>

			<div class="register_msg"></div>

			<div class="iteamsubmit" style>
				<!-- 新增按钮 -->
				<input type="button" onclick="addAddrs();" class="save" value="新增" />
				<!-- 保存按钮  -->
				<input type="button" onclick="editAddrs();" class="save"
					value="修改保存" />
			</div>



		</div>

		<div class="tbl-address">
			<!-- <div class="caption">已保存value条地址，还能保存10-value条地址</div> -->
			<table border="0" cellpadding="0" cellspacing="0" class="tbl-main">
				<tbody>
					<tr class="thead">
						<th>收货人</th>
						<th>所在地区</th>
						<th>详细地址</th>
						<th>邮编</th>
						<th>电话</th>
						<th>操作</th>
						<th></th>
					</tr>
				</tbody>
			</table>
			<table id="listshow" border="0" cellpadding="0" cellspacing="0"
				class="tbl-main1" method="post">

			</table>
		</div>
	</div>

	<!-- 获取项目地址 -->
	<input type="hidden" value="${baseUrl}" id="baseUrl" />

	<%-- <%@include file="../../goods/view/commonFooter.jsp"%> --%>

</body>


<%-- <%@include file="../../common/view/visit.jsp"%> --%>


<script src="${baseUrl}/users/js/addressmanage.js"></script>
</html>