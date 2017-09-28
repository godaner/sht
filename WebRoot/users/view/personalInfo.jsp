<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人信息</title>
    <link rel="stylesheet" href="../css/personalInfo.css"/>
</head>
<body>
<div id="header">
    <h1>SHT二手交易</h1>
    <ul>
        <a href="index.jsp">
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

<div id="body">
    <div id="body_left">
    <div class="body_left_img">
    	<img  onmouseover="showedit();" onmouseout="hidenedit();" src="../img/default_img.png" title="编辑资料">
    
    	<p onmouseover="showedit();">编辑资料</p>	
    </div>

        <p>${onlineUser.username}</p>
        <ul >
            <li><img src="../img/heart.png"></li>
            <li><img src="../img/heart.png"></li>
            <li><img src="../img/heart.png"></li>
            <li><img src="../img/heart.png"></li>
            <li><img src="../img/vip.png"></li>

        </ul>
        <ul >
            <a href=""><li>我的信息</li></a>
            <a href="./personalIssue.jsp"><li>我的发布</li></a>
            <a href=""><li>我的购买</li></a>
            <a href="./addressmanage.jsp"><li>地址管理</li></a>
            <a href="./findpassword.jsp"><li>密码找回</li></a>
            <a href="./recharge.jsp"><li>充值</li></a>
        </ul>
    </div> 
    <div id="body_right">
    <iframe src="./personalInfo_right_editInfo.jsp"  height="395px" class="" width="764px" frameborder=no>
    
    </iframe>
       <%--  <div>
            <span id="email">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱&nbsp;:&nbsp;</span>&nbsp;&nbsp;<input type="email" value="${onlineUser.email}"><br>
            <span id="introduce">用户介绍&nbsp;&nbsp;:&nbsp;&nbsp;</span><textarea>${onlineUser.description}</textarea>
            <div class="clearFloat"></div>
        </div> --%>
    </div>

    <div class="clearFloat"></div>
</div>
</body>
  	<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="../js/personalInfo.js"></script>
    <%@include file="../../common/view/visit.jsp"%>
</html>