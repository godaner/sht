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
</head>

<body>
<%@include file="../../goods/view/commonTitle.jsp" %>
	<div>
		<h2 class="head"><span class="enticy">收货地址</span></h2>

		<div class="form-box">
			<!--概要提示-->
			<div class="item item-title ">
				<span id="left1">新增收货地址</span>
				<span id="right1">电话号码、手机号选填一项，其余均为必填项</span>
			</div>

			<!--所在地区-->
			<div class="item item-devision">
				<span class="left2">所在地区<i>*</i></span>

				<div class="right2">
					<div class="right21">
						<div class="right211">
							<select class="area" style="border: 0;">
								<option value="0">请选择</option>
								<option value="1">中国大陆</option>
								<option value="2">台湾</option>
								<option value="3">港澳</option>
								<option value="4">海外其他</option>
							</select>
						</div>
					</div>

					<div class="docs-methods">
						<form class="form-inline">
							<div id="distpicker">
								<div class="form-group">
									<div style="position: relative;">
										<input id="city-picker3" class="form-control" readonly type="text" value="江苏省/南通市/如皋市" data-toggle="city-picker">
									</div>
								</div>
								<div class="form-group">
									<button class="btn btn-warning" id="reset" type="button">Reset</button>
									<!--<button class="btn btn-danger" id="destroy" type="button">Destroy</button>-->
								</div>
							</div>
						</form>
					</div>

				</div>

			</div>

			<!--详细地址-->
			<div class="street">
				<span class="left3">详细地址<i>*</i></span>
				<!--<div class="boxstreet" aria-pressed="false">
					<div class="comboboxinput">-->
				<textarea class="inputbox" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea>
				<!--</div>

				</div>-->
			</div>

			<!--邮政编码-->
			<div class="postcode">
				<span class="left4">邮政编码</span>
				<div class="iteam-warp">
					<input type="text" class="i-text" placeholder="如您不清楚邮递区号，请填写000000" data-pattern="^.{0,16}$" />
				</div>
			</div>

			<!--收货人姓名-->
			<div class="itemname">
				<span class="left4">
					收货人姓名
					<i>*</i>
				</span>
				<div class="iteam-warp">
					<input type="text" class="i-text" placeholder="长度不超过25个字符" data-pattern="^.{2,25}$" />
				</div>
			</div>

			<!--手机号码-->
			<div class="iteamMobile">
				<span class="left4">手机号码</span>
				<select id="mobile">
					<option value="1">中国大陆+86</option>
					<option value="2">香港+852</option>
					<option value="3">澳门+853</option>
					<option value="4">台湾+886</option>
					<option value="5">海外+1</option>
				</select>
				<div class="iteam-warp">
					<input type="text" class="i-text" data-pattern="^\d{6,20}$" />
				</div>
			</div>

			<!--默认地址勾选项-->
			<div class="iteamdefault">
				<input id="setdefalut" type="checkbox" />
				<label class="tsl">设置为默认收货地址</label>
			</div>

		</div>

		<div class="tbl-address">
			<div class="caption">已保存value条地址，还能保存10-value条地址</div>
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
		</div>

	</div>

	<script src="${baseUrl}/users/js/jquery.js"></script>
	<script src="${baseUrl}/users/js/bootstrap.js"></script>
	<script src="${baseUrl}/users/js/city-picker.data.js"></script>
	<script src="${baseUrl}/users/js/city-picker.js"></script>
	<script src="${baseUrl}/users/js/main.js"></script>
	<%@include file="../../goods/view/commonFooter.jsp"%>
</body>
<%@include file="../../common/view/visit.jsp"%>
</html>