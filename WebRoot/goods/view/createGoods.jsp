<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
	<base href="${pageContext.request.contextPath }/"/>
    <link rel="stylesheet" href="goods/css/createGoods.css"/>
</head>
<body>
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
    <a id="a_header_left" href="#">登录</a>&nbsp;|&nbsp;
    <a href="#">注册</a>
    <!--<div class="clearFloat"></div>-->
</div>

<div class="content">
    <div class="content-left">
        <img  src="goods/img/content.png">

        <p>二狗</p>
        <ul >
            <li><img src="goods/img/heart.png"></li>
            <li><img src="goods/img/heart.png"></li>
            <li><img src="goods/img/heart.png"></li>
            <li><img src="goods/img/heart.png"></li>
            <li><img src="goods/img/vip.png"></li>

        </ul>

    </div>
    <div class="content-right">
        <div class="add-img">
            <ul>
                <li title="最多可添加五张图片" id="preview" ><img src="goods/img/add.png"></li>
            </ul>
        </div>
        <div class="line"></div>
        <div class="detail-info">
            <p>宝贝介绍&nbsp;:&nbsp;</p>
            <textarea placeholder="请详细描述你的宝贝..."></textarea>
            <ul>
                <li>
                    <span>商品名称&nbsp;:&nbsp;</span>
                    <input type="text" placeholder="商品名称"/>
                </li>
                <li>
                    <span>商品转卖价&nbsp;:&nbsp;</span>
                    <input type="text" placeholder="商品转卖价"/>
                </li>
                <br/>
                <li>
                    <span>商品原价&nbsp;:&nbsp;</span>
                    <input type="text" placeholder="商品原价"/>
                </li>
                <li>
                    <span>商&nbsp;品&nbsp;&nbsp;成&nbsp;色&nbsp;:&nbsp;</span>
                    <input type="text" placeholder="商品成色"/>
                </li>
                <br/>
                <li>
                    <span>所&nbsp;&nbsp;在&nbsp;&nbsp;地&nbsp;:&nbsp;</span>
                    <input type="text" placeholder="所在地"/>
                </li>
            </ul>
            <input type="button" value="立即发布">
        </div>
    </div>
    <div class="clearFloat"></div>
</div>
<script src="goods/js/jquery-1.11.3.js" type="text/javascript"></script>
<script src="goods/js/createGoods.js" type="text/javascript"></script>
</body>
</html>