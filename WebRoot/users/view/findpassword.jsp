<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>密码找回</title>
	<link href="${baseUrl}/users/css/findpassword.css" rel="stylesheet" type="text/css">
</head>

<body style="background-color:white;">
<%@include file="../../goods/view/commonTitle.jsp" %> 
		<div id="content">
			<div class="content-layout">
				<div class="maincenter">

					<div class="maincenter-tip">
						<p class="" style="margin-left:200px;">
							找回密码
						</p>
					</div>
					<br/>
<!-- 					<div class="check_username">
						<div class="ui-form-item">
							<label class="ui-label">用户名：</label>
							<input type="text" class="ui-input" placeholder="请输入用户名" />
							<a href="javascript:void(0)" onclick="show_check_email();" style="color:grey;font-size:12px;text-decoration: none;">忘记用户名？邮箱寻回</a>
						</div>
					</div> -->
					<div class="check_email">
						<div class="ui-form-item">
							<label class="ui-label">邮箱地址：</label>
							<input type="text" class="ui-input" placeholder="请输入邮箱" id="email" />
						</div>
					</div>
					
						<div class="ui-form-item">
							<input id="submitBtn" class="ui-button" value="确定" type="button" onclick="changePassword();" />
						</div>
					

				</div>
			</div>

		</div>
		<%@include file="../../goods/view/commonFooter.jsp"%> 
	</body>
		<%@include file="../../common/view/visit.jsp"%>
		
		
<script type="text/javascript" src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
var baseUrl = $("#baseUrl").val();
function changePassword(){
var email = $("#email").val();

	$.ajax({
		type : 'post',  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/users/changePasswordByObj.action",  //需要访问的地址
	    data :'email='+email,  //传递到后台的参数
	    success:function(data){
	    	if(data['msg']){
	    	alert(data['msg']);
	    	}else{
	    		alert("修改成功，请重新登陆");
	    	}
	    },error:function(){
	    	alert("修改失败");
	    }
	}); 
}
	 
	

</script>
</html>