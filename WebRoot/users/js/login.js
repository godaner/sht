/* 全局变量 */
var msg = "";/* 错误信息 */
var baseUrl = "";/*项目地址*/

$(function(){
baseUrl = $("#baseUrl").val();
/* 当点击登陆框时 清空错误信息 */
	$(".login_input input").focus(function(){
		$(".login_msg").empty();
		$(".login_msg").css("background-color","white")
	});
});

/* 显示登陆窗口 */
function showlogin(){
	
	$(".login_box").fadeIn("slow");
	showCover();//遮罩层
	
}
/* 关闭登陆窗口 */
function closelogin(){
	$(".login_box").hide();
	hideCover();//遮罩层
}
/* 打印错误信息 */
function showErrorMsg(msg){
	$(".login_msg").css("background-color","rgb(254,242,242)");
	$(".login_msg").html(msg+" !  ^-^");
}
function login(){
	var username = $("#username").val().trim();
	var password = $("#password").val().trim();
	
	/* 登陆非空验证 */
	if(username==""||username==null){
		msg = "用户名不能为空";
		showErrorMsg(msg);
	}else if(password==""||password==null){
		msg = "密码不能为空";
		showErrorMsg(msg);
	}else{$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/users/login.action",  //需要访问的地址
		    data : "username="+username+"&password="+password,  //传递到后台的参数
		    success:function(data){
		    	console.info(data);
		    	/* 打印错误信息 */
		    	if(data['msg']){
		    		msg = data['msg'];
		    		showErrorMsg(msg);
		    	}else{
		    	/* 成功登陆 */
		    		
		    		closelogin();
		    		window.location.reload(true);
		    		
		    		
		    	}
		    },error:function(data){
		    	msg = "登陆失败";
	    		showErrorMsg(msg);
		    }
		});
	}
	
	
}
