/* 全局变量 */
var type = "post";
var dataType = "json";
var async =true;
var msg = "";/* 错误信息 */
var id = "";
var CanSub = false;/*标记是否能提交注册信息*/
var baseUrl="";/*获取项目地址*/
var name = "^[A-Za-z][A-Za-z1-9_-]+$";/*用户名（字母开头 + 数字/字母/下划线）*/
var reg = '^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+\\.[a-zA-Z0-9_-]+$';//纯手写 贼强 不准换——yyfjsn



$(function(){
	baseUrl = $("#baseUrl").val();
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
	showCover();//遮罩层

}
/*关闭注册框*/
function closeregister(){
	$(".register_box").hide();
	hideCover();//遮罩层
	refreshVC();
}
/* 打印错误信息 */
function RegisterErrorMsg(msg){
	$(".register_msg").css("background-color","rgb(254,242,242)");
	$(".register_msg").html(msg+" !  ^-^");
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
	if(email_re.match(reg)){
		CanSub = true;
	}else{
		msg = "邮箱格式:xxx@xx.xx";
//		id= "email";
		RegisterErrorMsg(msg);
//		showStar(id);
	}
}
/*刷新验证码*/
function refreshVC(){
	 var timestamp = new Date().getTime(); 
	 $("#codeimg").attr("src", baseUrl+"/users/getVC.action?t="+ timestamp);
}






/*注册*/
function register(){
	var rs_username = $("#rs_username").val().trim();
	var rs_password = $("#rs_password").val().trim();
	var email = $("#email").val().trim();
	var code = $("#code").val().trim();
	var sure_ps = $("#sure_ps").val().trim();
	//非空验证
	if($("#descript_book").is(":checked")){
		
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
	}else if(CanSub){
		$.ajax({
			type : type,  //请求方式,get,post等
		    dataType:dataType,//response返回数据的格式
		    async : async,  //同步请求  
		    url : baseUrl+"/users/regist.action",  //需要访问的地址
		    data : "username="+rs_username+"&password="+rs_password+"&email="+email+"&code="+code,  //传递到后台的参数
		    success:function(data){
		    	if(data['msg']){
		    		msg = data['msg'];
		    		RegisterErrorMsg(msg);
		    	}else{
		    		alert("注册成功");
		    		closeregister();
		    	}
		    	
		    },error:function(data){
		    	alert("失败");
		    }
		});
	}else{
		Check_email();
	}
	msg="";
}
}