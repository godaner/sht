/* 全局变量 */
var msg = "";/* 错误信息 */
var id = "";
$(function(){
/* 当点击登陆框时 清空错误信息 */
	$(".register_input input").focus(function(){
		$(".register_msg").empty();
		$(".register_msg").css("background-color","white")
	});
	/*$("#email").focus(function(){solid 1px rgb(243,243,243)
		this.removeClass('border');
	})*/
	
});




/*显示注册框*/
function showregister(){
	$(".register_box").show();
}
/*关闭注册框*/
function closeregister(){
	$(".register_box").hide();
}
/* 打印错误信息 */
function RegisterErrorMsg(msg){
	$(".register_msg").css("background-color","rgb(254,242,242)");
	$(".register_msg").html("<img src='../../images/login-msg.png' style='float:left'/> "+msg+" !  ^-^");
}
/*输入框发光效果(错误提示)*/
function showStar(id){
	$("#"+id).css({
		"border":"1px solid #f95d5d",
		"box-shadow":"0px 0px 5px 0px #f95d5d",
	})
}
/*取消输入框发光效果*/
function hidenStar(id){
$("#"+id).css("border","solid 1px rgb(243,243,243)");
}


/*邮箱验证*/
function Check_email(){
	var email_re = $("#email").val().trim();
	//var reg = '^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$';
	var reg = '^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$';//纯手写 贼强 不准换——yyfjsn
	if(email_re.match(reg)){
		alert("对啦");
	}else{
		msg = "正确格式:xxx@xx.xx";
//		id= "email";
		RegisterErrorMsg(msg);
//		showStar(id);
	}
}


/*注册*/
function register(){
	
	var rs_username = $("#rs_username").val().trim();
	var rs_password = $("#rs_password").val().trim();
	var email = $("#email").val().trim();
	var code = $("#code").val().trim();
	var sure_ps = $("#sure_ps").val().trim();
	//非空验证
	if(rs_username==""||rs_username==null){
		msg = "用户名不能为空";
		//id = "rs_username";
		RegisterErrorMsg(msg);
		//showStar(id);
	}else if(email==""||email==null){
		msg = "邮箱不能为空";
		//id = "email";
		RegisterErrorMsg(msg);
		//showStar(id);
	}else if(code==""||code==null){
		msg = "验证码不能为空";
		//id = "code";
		RegisterErrorMsg(msg);
		//showStar(id);
	}else if(rs_password==""||rs_password==null){
			msg = "密码不能为空";
		//	id = "re_password";
			RegisterErrorMsg(msg);
		//	showStar(id);
	}else if(rs_password!=sure_ps){
		msg = "两次密码输入不一致";
		RegisterErrorMsg(msg);
	}else{
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : "${baseUrl}/users/regist.action",  //需要访问的地址
		    data : "username="+rs_username+"&password="+password+"email"+email+"code"+code,  //传递到后台的参数
		    success:function(data){
		    	alert("成功");
		    },error:function(data){
		    	alert("失败");
		    }
		});
	}
}