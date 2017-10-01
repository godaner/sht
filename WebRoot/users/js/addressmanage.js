/**
 * 默认地址获值
 */
//$(document).ready(function(){
//$('#setdefalut').click(function(){
//	if($(this).prop("checked")){
//		$(this).val(1);
//	}else{
//		$(this).val(0);
//	}
//});
//})

/**
 * 全局变量
 */
var type = "post";
var dataType = "json";
var async =true;
var msg = "";/* 错误信息 */
var id = "";
var CanSub = false;/*标记是否能提交注册信息*/
var baseUrl="";/*获取项目地址*/

/* 打印错误信息 */
function RegisterErrorMsg(msg){
	$(".register_msg").css("background-color","rgb(254,242,242)");
	$(".register_msg").html(msg+" !  ^-^");
} 
var countryId = 1;

$(function(){
	baseUrl = $("#baseUrl").val();
/* 当点击按钮 清空错误信息 */
	$(".addAddress_input input").focus(function(){
		$(".register_msg").empty();
		$(".register_msg").css("background-color","white")
	});
	//加载省份
	loadProvince();
	
	
});

//加载省份
function loadProvince(){
	$.ajax({
	    url : baseUrl+"/users/R_getRegionByPid.action?pid="+countryId,  //需要访问的地址
	    success:function(data){
	    	console.info(data)
	    },error:function(data){
	    	
	    }
	});
}

/*新增地址*/
function addAddrs(){
	$('#setdefalut').click(function(){
		if($(this).prop("checked")){
			$(this).val(1);
		}else{
			$(this).val(0);
		}
	});
	
	var region=$("#city-picker3").val();
	var detail=$("#detail").val().trim();
	var postcode=$("#postcode").val().trim();
	var realname=$("#realname").val().trim();
	var pohne=$("#pohne").val().trim();
	var setdefalut=$("#setdefalut").val().trim();
	
	
	if(region!=""&&region!=null&&detail!=""&&detail!=null&&realname!=""&&realname!=null&&pohne!=""&&pohne!=null){
		CanSub=true;
	}
	
	if(region==""||region==null){
		msg="所在地区不能为空";
		RegisterErrorMsg(msg);
	}else if(detail==""||detail==null){
		msg="详细地址不能为空";
		RegisterErrorMsg(msg);
	}else if(realname==""||realname==null){
		msg="收货人不能为空";
		RegisterErrorMsg(msg);
	}else if(pohne==""||pohne==null){
		msg="手机号码不能为空";
		RegisterErrorMsg(msg);
	}else if(CanSub){
		$.ajax({
			type : type,  //请求方式,get,post等
		    dataType:dataType,//response返回数据的格式
		    async : async,  //同步请求  
		    url : baseUrl+"/users/D_addAddress.action",  //需要访问的地址
		    data : "region="+region+"&detail="+detail+"&postcode="+postcode+"&realname="+realname+"&pohne="+pohne+"&isdefault="+setdefalut,  //传递到后台的参数
		    success:function(data){
		    	alert(data)
		    	if(data['msg']){
		    		msg = data['msg'];
		    		RegisterErrorMsg(msg);
		    	}else{
		    		alert("添加成功");
		    		window.location.href='/sht/users/view/addressmanage.jsp';
		    	}
		    },error:function(data){
		    	alert("添加失败");
		    }
		});
		msg="";
	}
}
