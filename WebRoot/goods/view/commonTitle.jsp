<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <base href="${pageContext.request.contextPath }/">
    <link  href="goods/css/commonTitle.css" rel="stylesheet"/>
    <script src="goods/js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="goods/js/commonTitle.js" type="text/javascript"></script>
</head>
<body>

<nav>
    <ul>
        <li>SHT</li>
        <li>首页</li>
        
        &nbsp;&nbsp;&nbsp;&nbsp;|
        <li><a href="goods/view/createGoods.jsp" target="_blank">发布闲置</a></li>
        <li class="idle">
            个人中心
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
            </div>
        </li>
        <li >
            <a href="" >请登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="" >注册</a>
        </li>

    </ul>
</nav>
</body>
</html>