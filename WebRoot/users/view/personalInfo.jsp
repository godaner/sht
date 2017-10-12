<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人信息</title>
    <link rel="stylesheet" href="${baseUrl}/users/css/personalInfo.css"/>
</head>
<body style="background-color:white;">
<jsp:include page="../../goods/view/commonTitle.jsp" flush="false" />
<!-- <div id="header">
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
    <div class="clearFloat"></div>
</div> -->

<div id="body">
    <div class="body_left">
    <div class="body_left_img">
    	<img   onmouseout="hidenedit();" src="" title="" id="personalImg" onclick="to_editImg();">
    
    	<p  onclick="to_editImg();">编辑头像</p>	
    </div>

        <p>${onlineUser.username}</p>
        <ul >
            <li><img src="${baseUrl}/users/img/heart.png"></li>
            <li><img src="${baseUrl}/users/img/heart.png"></li>
            <li><img src="${baseUrl}/users/img/heart.png"></li>
            <li><img src="${baseUrl}/users/img/heart.png"></li>
            <li><img src="${baseUrl}/users/img/vip.png"></li>

        </ul>
        <ul >
            <a href="javascript:void(0);" onclick="show_body_right();"><li>我的信息</li></a>
            <a href="javascript:void(0);" onclick="show_sonPage(0);"><li>我的发布</li></a>
            <a href="javascript:void(0);" onclick="show_sonPage(1);"><li>我的购买</li></a>
            <a href="javascript:void(0);" onclick="show_sonPage(3);"><li>地址管理</li></a>
            <!-- <a href="./addressmanage.jsp"><li>地址管理</li></a> -->
            <a href="javascript:void(0);" onclick="show_sonPage(2);"><li>密码找回</li></a>
            <a href="javascript:void(0);" onclick="show_sonPage(4);"><li>充值</li></a>
        </ul>
    </div> 
    <div id="body_right" >
    <iframe name="iframe0"  src="${baseUrl}/users/view/personalInfo_right_editInfo.jsp"  height="395px" class="" width="764px" frameborder=no>
    
    </iframe>
    </div> 
    
    <div id="show_issueGoods" style="display:none;">
    <iframe name="userinfoiframe"  src="" width="980px" height="1560px" scrolling="no" frameborder=no></iframe>
				
    </div>

    <div class="clearFloat"></div>
</div>


<input type="hidden" value="${onlineUser.headimg}" id="headimg"/>
<input type="hidden" value="${baseUrl}" id="baseUrl"/>

</body>
  	<script type="text/javascript" src="${baseUrl}/users/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="${baseUrl}/users/js/personalInfo.js"></script>
    <%@include file="../../common/view/visit.jsp"%>
    
    <script type="text/javascript">
    var baseUrl = $("#baseUrl").val();
    //获取头像
    $(function(){
	  	 var headimg = $("#headimg").val();
	  	
	  		 $("#personalImg").attr({
	  			 "src":"http://localhost/sht/common/users_getUsersHeadImg.action?size=160&headimg="+headimg,
	  			 "title":""
	  		 });

	   });
    
    
    //点击头像跳转
    function to_editImg(){
     	$("#body_right").show();	
 	   $("#show_issueGoods").hide();
 	  $("#body_right iframe").attr({
		   "src":baseUrl+'/users/view/personalInfo_right_editImg.jsp',
			//"target":"userinfoiframe"
	   }); 
	  
    }
    
   //显示子页面 
   function show_sonPage(a){
	   var src="";
	   if(a==0){
		   src=baseUrl+"/users/view/personalIssue_right_showGoods.jsp";
	   }else if(a==1){
		   src=baseUrl+"/users/view/personalIssue_right_showBuyed.jsp";
	   }else if(a==2){

		   src=baseUrl+"/users/view/resetpassword.jsp";


	   }else if(a==3){
		   src=baseUrl+"/users/view/addressmanage.jsp"
	   }else if(a==4){
		   src=baseUrl+"/users/view/recharge.jsp";
	   }
	   $("#body_right").hide();	
	   $("#show_issueGoods").show();
	   $("#show_issueGoods iframe").attr({
		   "src":src,
			"target":"userinfoiframe"
	   });
	   
   }
   
   //显示我的信息子页面 
   function show_body_right(){
	   $("#body_right").show();	
	   $("#show_issueGoods").hide();
   }
    </script>
</html>