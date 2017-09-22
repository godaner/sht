<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人信息</title>
    <link rel="stylesheet" href="../css/personalInfo.css"/>
    <link rel="stylesheet" href="../css/personalIssue.css"/>
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
            <a href=""><li>我的发布</li></a>
            <a href=""><li>我的购买</li></a>
            <a href=""><li>地址管理</li></a>
            <a href=""><li>密码找回</li></a>
            <a href=""><li>充值</li></a>
        </ul>
    </div> 
    <div id="show_issueGoods">
			
		<!-- 搜索框 -->
			<div class="search">
			<input type="text" placeholder="请输入商品标题"/> <button >搜索</button>
			</div>
			<!-- 顶部标题栏 -->
			<div class="title">
			<table id="title_table">
			<tr>
			<td>宝贝标题</td>
			<td>介绍</td>
			<td>价格</td>
			<td>状态</td>
			<td>操作</td>
			</tr>
			</table>
			</div>
		<!-- 已发布列表 -->
		<div class="issue">
		<div class="issue_title">
		<p>创建时间 :&nbsp;&nbsp;&nbsp;&nbsp;商品号：</p>
		</div>
		<div class="issue_body">
		<table>
		<tr>
		<td><img alt="" src=""><p>标题<p></td>
		<td><p>介绍<p></td>
		<td><p>价格<p></td>
		<td><p>状态<p></td>
		<td><p>操作<p></td>
		
		</tr>
		
		
		</table>
		
		</div>
		
		</div>
			
			
			
    </div>

    <div class="clearFloat"></div>
</div>
</body>
  	<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="../js/personalInfo.js"></script>
    <script type="text/javascript">
    
    
    
    
    </script>
</html>