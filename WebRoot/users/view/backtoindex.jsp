<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>返回首页</title>
</head>
<body style="font-size:20px;text-align: center;">
<br/><br/><br/><br/><br/><br/>
  <i>验证成功：</i><a href="${baseUrl}/users/view/index.jsp">点我返回首页</a>

<input type="hidden" value="${param.email}" id="email">
<input type="hidden" value="${param.code}" id="code">
<input type="hidden" value="${baseUrl}" id="baseUrl">
</body>
<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>

<script type="text/javascript">
 $(function(){
	 
	 var email = $("#email").val();
	 var code = $("#code").val();
	 var baseUrl = $("#baseUrl").val();
	 $.ajax({
			type : 'post',  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/verifyEmail.action",  //需要访问的地址
		    data :'email='+email+'&code='+code,  //传递到后台的参数
	 });
	
})

</script>
</html>