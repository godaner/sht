/**
 * 默认地址获值
 */
//$(document).ready(function(){
//$('#setdefalut').click(function(){
//	var op;
//	if($(this).prop("checked")){
//		op = 1;
//	}else{
//		op = 0;
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
	
	selectcity();
	selectcounty();
	
	loadProvince(function(){
		loadcity(function(){
			loadcounty();
		});
	});
	
//	点击a标签后跳转
//	$("del").click(function(){
//        location.href='/sht/users/view/addressmanage.jsp';
//    })
	
});

function selectcity(){
	$("#province").change(function(){
		//清空县，区，点击市后才显示
		$("#county").val("");
		$("#county").html("");
		loadcity();
		
	});
}

function selectcounty(){
	$("#city").change(function(){
		loadcounty();
	});
}

//加载省份
function loadProvince(){
	$.ajax({
	    url : baseUrl+"/users/R_getRegionByPid.action?pid="+countryId,  //需要访问的地址
	    success:function(data){
	    	var str = "";
//	    	console.info(data);
	    	$.each(data.childs, function(index,item){
	    		str += "<option id='s"+index+"' class='"+item.id+"'>"+item.name+"</option>";
	    	});
	    	$("#province").html(str);
//	    	callfun();
	    },error:function(data){
	    	
	    }
	});
}

//加载城市
function loadcity(){
	var cityid = $("#province :selected").attr("class");
//	console.info(111);
//	console.info(cityid);
	$.ajax({
		url : baseUrl+"/users/R_getRegionByPid.action?pid="+cityid,
		success:function(data){
			var str = "";
//			console.info(data);
			$.each(data.childs,function(index,item){
				str += "<option id='s"+index+"' class='"+item.id+"'>"+item.name+"</option>"
			});
			$("#city").html(str);
//			callfun();
		},error:function(data){
			
		}
	});
}

//加载县，区
function loadcounty(){
	var countyid = $("#city :selected").attr("class");
	$.ajax({
		url : baseUrl+"/users/R_getRegionByPid.action?pid="+countyid,
		success:function(data){
			var str = "";
//			console.info(data);
			$.each(data.childs,function(index,item){
				str += "<option id='s"+index+"' class='"+item.id+"'>"+item.name+"</option>"
			});
			$("#county").html(str);
		},error:function(data){
			
		}
	})
}



/*新增地址*/
function addAddrs(){
	
	var setdefalut;
	if($('#setdefalut').prop('checked')){
		setdefalut = 1;
	}else{
		setdefalut = 0;
	}
	
	var region=$("#county :selected").attr("class");
	var detail=$("#detail").val().trim();
	var postcode=$("#postcode").val().trim();
	var realname=$("#realname").val().trim();
	var phone=$("#phone").val().trim();
	
	
	if(detail!=""&&detail!=null&&realname!=""&&realname!=null&&phone!=""&&phone!=null){
		CanSub=true;
	}
	
	if(detail==""||detail==null){
		msg="详细地址不能为空";
		RegisterErrorMsg(msg);
	}else if(realname==""||realname==null){
		msg="收货人不能为空";
		RegisterErrorMsg(msg);
	}else if(phone==""||phone==null){
		msg="手机号码不能为空";
		RegisterErrorMsg(msg);
	}else if(CanSub){
		$.ajax({
			type : type,  //请求方式,get,post等
		    dataType:dataType,//response返回数据的格式
		    async : async,  //同步请求  
		    url : baseUrl+"/users/D_addAddress.action",  //需要访问的地址
		    data : "region="+region+"&detail="+detail+"&postcode="+postcode+"&realname="+realname+"&phone="+phone+"&isdefault="+setdefalut,  //传递到后台的参数
		    success:function(data){
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


//显示已添加的收货地址列表
var cAddrs;
$(function(){
//	var baseUrl="";
	$.ajax({
		type:type,
		async:async,
		url:baseUrl+"/users/D_showAddrs.action",
		dataType:dataType,
		data:{},
		success:function(data){
//			console.info(data);
			var h="";
			cAddrs = data['addrs'];
			for(var i=1;i<=data['addrs'].length;i++){
				var addrs= data['addrs'][i-1];
				if(addrs["isdefault"]==1){
					h+="<tbody><tr><th>"+addrs["realname"]+"</th><th>"+addrs["addr"]+"</th><th>"+addrs["detail"]+"</th><th>"+addrs["postcode"]+"</th><th>"+addrs["phone"]+"</th><th><a style='text-decoration: none;' href=javascript:oneditAddr('"+(i-1)+"')>修改</a>|<a style='text-decoration:none;' href='"+baseUrl+"/users/D_deleteAddress.action?id="+addrs['id']+"'>删除</a></th><th><span style='width:55px;height:18px;background-color:#f7f7f7;'>默认地址</span></th></tr></tbody>";
					$("#listshow").append(h);
					h="";
				}else{
					h+="<tbody><tr><th>"+addrs["realname"]+"</th><th>"+addrs["addr"]+"</th><th>"+addrs["detail"]+"</th><th>"+addrs["postcode"]+"</th><th>"+addrs["phone"]+"</th><th><a style='text-decoration:none;' href=javascript:oneditAddr('"+(i-1)+"')>修改</a>|<a style='text-decoration:none;' href='"+baseUrl+"/users/D_deleteAddress.action?id="+addrs['id']+"'>删除</a></th><th><a style='text-decoration:none;' href=javascript:editDefault('"+addrs['id']+"')>设为默认</a></th></tr></tbody>";

					$("#listshow").append(h);
					h="";
				}
			}
			h="";
		}
	})
}) 


function oneditAddr(index){
	var addr = cAddrs[index];
	console.info(addr);
//	console.info(addr.region);
	var countyid=addr.region;
//	loadcounty1(function(countyid){
//		loadcity1(function(){
//			loadProvince1();
//		});
//	});
	$("#id").val(addr.id);
	$("#master").val(addr.master);
	$("#detail").val(addr.detail);
	$("#postcode").val(addr.postcode);
	$("#realname").val(addr.realname);
	$("#phone").val(addr.phone);
	
	var checkvalue=addr.isdefault;
	if(checkvalue==1){
//		$('#setdefalut').prop('checked');
		$("#setdefalut").attr("checked","checked");
		$("#setdefalut").attr("checked","true");
		$("#setdefalut").prop("checked","checked");
		$("#setdefalut").prop("checked","true");
		
//		$('#setdefalut:eq(0)').attr("checked");
//		$('#setdefalut:eq(0)').attr("checked",false);
	}else{

		$("#setdefalut").removeAttr("checked");
//		$('#setdefalut:eq(0)').attr("checked",false);
//		$('#setdefalut:eq(0)').attr("checked",true);
	}
	
	
}


function editAddrs(){
	var setdefalut;
	if($('#setdefalut').prop('checked')||$('#setdefalut').attr('checked')){
		setdefalut = 1;
	}else{
		setdefalut = 0;
	}
	var id=$("#id").val().trim();
	
	var master=$("#master").val().trim();
//	alert(id);
//	alert(master);
	var region=$("#county :selected").attr("class");
	var detail=$("#detail").val().trim();
	var postcode=$("#postcode").val().trim();
	var realname=$("#realname").val().trim();
	var phone=$("#phone").val().trim();
	
	if(detail!=""&&detail!=null&&realname!=""&&realname!=null&&phone!=""&&phone!=null){
		CanSub=true;
	}
	
	if(detail==""||detail==null){
		msg="详细地址不能为空";
		RegisterErrorMsg(msg);
	}else if(realname==""||realname==null){
		msg="收货人不能为空";
		RegisterErrorMsg(msg);
	}else if(phone==""||phone==null){
		msg="手机号码不能为空";
		RegisterErrorMsg(msg);
	}else if(CanSub){
		$.ajax({
			type : type,  //请求方式,get,post等
		    dataType:dataType,//response返回数据的格式
		    async : async,  //同步请求  
		    url : baseUrl+"/users/D_updateAddress.action",  //需要访问的地址
		    data : "id="+id+"&master="+master+"&detail="+detail+"&postcode="+postcode+"&realname="+realname+"&phone="+phone+"&isdefault="+setdefalut+"&region="+region,  //传递到后台的参数
		    success:function(data){
		    	if(data['msg']){
		    		msg = data['msg'];
		    		RegisterErrorMsg(msg);
		    	}else{
		    		alert("修改成功");
		    		window.location.href='/sht/users/view/addressmanage.jsp';
		    	}
		    },error:function(data){
		    	alert("修改失败");
		    }
		});
		msg="";
	}
}

//设置默认收货地址
function editDefault(addrId){
	$.ajax({
		type:type,
		dataType:dataType,
		async:async,
	    url : baseUrl+"/users/D_updateDefault.action",
	    data:"id="+addrId,
	    success:function(data){
	    	
	    	var userInfoIframe = parent.document.getElementsByName("iframe0")[0];
	    	userInfoIframe.src = baseUrl+"/users/view/addressmanage.jsp";
//	    	userInfoIframe.attr("src",);  
	    	
//    		alert("设置成功");
//    		window.location.href='/sht/users/view/addressmanage.jsp';
	    }
	})
}
