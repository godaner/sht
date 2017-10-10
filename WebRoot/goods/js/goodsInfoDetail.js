/**
 * Created by tom on 2017/9/16.
 */

$(function() {

	// 展开或收起闲置列表
	var flag = false;
	$('#show').click(function() {

		if (!flag) {
			$('#option').animate({
				height : '200px'
			}, 'slow');
			$('#show').html('收起');
			flag = true;
		} else {
			$('#option').animate({
				height : '100px'
			}, 'slow');
			$('#show').html('展开');
			flag = false;
		}

	});

	// 闲置
	$('.idle').hover(function() {
		$('.idle>img').attr('src', 'goods/img/up_black.png');
		$('.idle_down').show();
	}, function() {
		$('.idle>img').attr('src', 'goods/img/down_black.png');
		$('.idle_down').hide();
	});

	// 显示我的店铺下拉列表信息
	$('#myShop').hover(function() {
		$('#myShop').css('background-color', 'white');
		$('#myShop>ul').show();
	}, function() {
		$('#myShop').css('background-color', 'transparent');
		$('#myShop>ul').hide();
	});

	// 显示收藏夹下拉列表信息
	$('.collection').hover(function() {
		$('.collection').css('background-color', 'white');
		// 切换图片
		$('.collection>img:eq(0)').attr('src', 'goods/img/star_yellow.png');
		$('.collection>img:eq(1)').attr('src', 'goods/img/down_yellow.png');

		$('.collection>ul').show();
	}, function() {
		$('.collection').css('background-color', 'transparent');
		// 切换图片
		$('.collection>img:eq(0)').attr('src', 'goods/img/star_grey.png');
		$('.collection>img:eq(1)').attr('src', 'goods/img/down_grey.png');

		$('.collection>ul').hide();
	});

	// 图片轮播

	var id = $('#goodsId').val(),baseUrl = $('#baseUrl').val();
	
	var imgSrc;
	var url_200 = baseUrl + "/common/goods_getGoodsImg.action?size=200&imgName=";
	var url_30 = baseUrl + "/common/goods_getGoodsImg.action?size=30&imgName=";
	$.ajax({
		type : "post", // 请求方式,get,post等
		dataType : 'json',// response返回数据的格式
		async : false, // 同步请求
		url : baseUrl + "/goods/selectGoodsImgs.action?id=" + id, // 需要访问的地址
		success : function(data) {
			// 显示商品类别
			imgSrc = data.split('/');
			splitData(imgSrc);
		},
		error : function(data) {
			console.log("访问失败!");
			console.log(data);
		}
	});

	
	function splitData(imgSrc){
		for(var i = 0 ; i < imgSrc.length ; i ++){
			
			var li = $("<li><img src=''/></li>");
			
			
			li.find('img').attr('src', url_30 + imgSrc[i]);
			
			if(imgSrc.length > 1){
				
				li.hover(function(){
					mouseEntered($(this));
				},function(){
					mouseLeaved($(this));
				});
			}
			
			$('#rotation-item').append(li);
		}
		
	}
	var rotationEvent;
	var rotationIndex = 0;
	
	
	
	function mouseEntered(target){
		clearTimeout(rotationEvent);
		var index = target.index();
		restoreBorder();
		target.css('border-color', 'orangered');
		
		var targetParent = $('.content-left>img');
		targetParent.attr('src', url_200+imgSrc[index]);
	}
	function mouseLeaved(target) {
		restoreBorder();
		rotationIndex = target.index();
		rotation();
	}

	$('.content-left>img').hover(function() {
		clearTimeout(rotationEvent);
	}, function() {
		rotation();
	});

	function rotation() {
		rotationIndex++;
		if (rotationIndex >= imgSrc.length) {
			rotationIndex = 0;
		}
		restoreBorder();

		$('.content-left>ul>li:eq(' + rotationIndex + ')').css('border-color',
				'orangered');
		$('.content-left>img').attr('src',url_200 + imgSrc[rotationIndex]);

		rotationEvent = setTimeout(rotation, 2000);
	}
	rotationEvent = setTimeout(rotation, 2000);
	function restoreBorder() {
		$('#rotation-item li').css({
			'border' : '1px solid gold'
		});
	}

	
//
//	// 显示城市列表
//	$('#location').click(function() {
//
//		var height = $(this).offset().top - 50;
//		$('.city_info').css({
//			'top' : height + 'px',
//			
//		});
//		//获取省份信息
//		getRegionData(1, $('.city_info table'));
//		$('.city_info').slideDown();
//	});
//
//	function getRegionData(pid, target) {
//		$.ajax({
//			type : "post", // 请求方式,get,post等
//			dataType : 'json',// response返回数据的格式
//			async : false, // 同步请求
//			url : baseUrl + "/regions/selectAllRegions.action?pid=" + pid, // 需要访问的地址
//			success : function(data) {
//				console.log("访问地区成功!");
//				// 显示商品类别
////				console.log(data);
//
//				if (target.attr('class') == 'secondary_menu')
//					setSecondMenuData(data, target);
//				else
//					setRegionData(data, target);
//			},
//			error : function(data) {
//				console.log("访问地区失败!");
//				console.log(data);
//			}
//		});
//	}
//
//	function setRegionData(data, target) {
//		var table = target.empty();
//
//		var tr = $("<tr></tr>");
//		$.each(data, function(index, item) {
//			var name = item['name'];
//			if (index == 0)
//				return true;
//			if (name.indexOf('省') != -1 || name.indexOf('市') != -1)
//				name = name.substring(0, 3);
//			else
//				name = name.substring(0, 2);
//
//			var td = $('<td name=' + item['id'] + '> ' + name + '</td>');
//			tr.append(td);
//
//			td.hover(function() {
//				showSecondMenu(td);
//
//			}, function() {
//				hideSecondMenu();
//			})
//
//			if ((index % 5) == 0) {
//				table.append(tr);
//				tr = $('<tr></tr>');
//			}
//
//		});
//	}
//
//	function setSecondMenuData(data, target) {
//
//		var table = target.empty();
//
//		var tr = $("<tr></tr>");
//
//		$.each(data, function(index, item) {
//			var name = item['name'];
//			
//			name = name.substring(0, 3);
//			
//			var td = $('<td name=' + item['id'] + '> ' + name + '</td>');
//			
//			tr.append(td);
//			
//			td.on('click', setCityInfo);
//	
//			if (((1+index) % 5) == 0 && index != 0) {
//				
//				table.append(tr);
//				tr = $('<tr></tr>');
//			}
//			
//			if(data.length <= 5)
//				table.append(tr);
//
//		});
//		
//		if(data.length >= 5){
//			table.css('width','400px');
//
//		}
//	}
//
//	// 显示城市信息二级菜单
//
//	var table = $("<table class='secondary_menu'></table>");
//	var province;
//	function showSecondMenu(target) {
//		province = target.text();
//		target.append(table);
//
//		var pid = target.attr('name');
//
//		getRegionData(pid, table);
//
//		table.show();
//		
//	}
//
//	function hideSecondMenu() {
//		table.empty().hide();
//		
//	}
//	
//	//显示三级城市列表
//	function setCountyInfo(data){
//		var table = $('#county').empty();
//		var tr = $("<tr></tr>");
//		$.each(data,function(index,item){
//			
//			var name = item['name'];
//			name = name.substring(0, 3);
//			
//			var td = $('<td name=' + item['id'] + '> ' + name + '</td>');
//			
//			td.on('click',showCountyInfo);
//			
//			tr.append(td);
//			
//			if((index % 5) == 0 && index != 0){
//				
//				table.append(tr);
//				tr = $('<tr></tr>');
//			}
//		})
//		if(data.length > 0)
//			table.show();
//
//	}
//
//	function getBasedRegionData(pid,target) {
//		$.ajax({
//			type : "post", // 请求方式,get,post等
//			dataType : 'json',// response返回数据的格式
//			async : false, // 同步请求
//			url : baseUrl + "/regions/selectAllRegions.action?pid=" + pid, // 需要访问的地址
//			success : function(data) {
//				console.log("访问地区成功!");
//				// 显示商品类别
////				console.log(data);
//
//				setCountyInfo(data);
//			
//			},
//			error : function(data) {
//				console.log("访问地区失败!");
//				console.log(data);
//			}
//		});
//	}
//	
//	function setCityInfo() {
//		var city = province + "-" + $(this).text();
//		
//		table.find('tr').remove();
//		table.empty().hide();
//		$('.city_info table').find('tr').remove();
//		
//		$('.city_info').toggle('slow');
//		
//		$('#location>span').text(city);
//		var pid = $(this).attr('name');
//		getBasedRegionData(pid,$(this));
//	}
//	
//	function showCountyInfo(){
//		var county = $(this).text();
//		$("#county").empty().hide();
//		$('#express>span').html(county);
//	}
//
//	// 隐藏城市列表
//	$('.city_info>div img').click(function() {
//		$('.city_info').slideUp();
//	});
//	$('.city_info>div img').hover(function() {
//
//		$('.city_info>div img').attr('src', 'goods/img/close_yellow.png');
//	}, function() {
//		$('.city_info>div img').attr('src', 'goods/img/close_grey.png');
//	});
	
	//读取默认地址
	getAddr();
	function getAddr(){
		var userId = $("#onlineUser").attr('value');
		
		if(userId == " " || userId == null){
			$('#location').html("登录后才能获取默认收货地址").css("color","red");
			
		}else{
			$.ajax({
				type : "post", // 请求方式,get,post等
				dataType : 'json',// response返回数据的格式
				async : false, // 同步请求
				url : baseUrl + "/addrs/selectAddrs.action?master=" + userId, // 需要访问的地址
				success : function(data) {
					console.log(data);
					setAddrData(data);
				},
				error : function(data) {
					console.log(data);
				}
			});
		}

	}
	var userData;
	function setAddrData(data){
		userData = data[0];
		if(data.length == 0){
			if(confirm("您还没有设置收货地址，请前往个人中心填写!") == true)
				location.href=baseUrl + "/users/view/personalInfo.jsp";
			else{
				$('#location').html("暂无收货地址");
			}
		}
			
		var section = $('#addr');
		$.each(data,function(index,item){
			if(item['isdefault'] == 1){
				$('#location').html(item['addr']).css("color","black");
			}
			
			var option = $('<option >'+item['addr']+'</option>');
			
			section.append(option);
			
		});
		
		
	}
	
	
	
	$('#addr').change(function(){
		var city = $(this).children('option:selected').val();   
		if(city == 0)
			return false;
		$('#location').html(city).css("color","black");
	})
	
	
	//
	
	var msgnum = $("#msgnum").val();
	if(msgnum != 0)
		getMsgData(id);
	
	function getMsgData(id){
		$('.reply').html("");
		$('.reply').removeAttr('name');
		$('#comment-content').val("");

		$.ajax({
			type : "post", // 请求方式,get,post等
			dataType : 'json',// response返回数据的格式
			async : false, // 同步请求
			url : baseUrl + "/messages/selectAllMessages.action?id=" + id, // 需要访问的地址
			success : function(data) {
				console.log("访问留言成功!");
	
				console.log(data);
				setMsgData(data);
				
			},
			error : function(data) {
				console.log("访问留言失败!");
				console.log(data);
			}
		});
	}
	
	var recieveUser;
	function setMsgData(data){
		
		var container = $('.comment-container').empty();
		
		$.each(data,function(index,item){
			
			var headImg = item['headImg'];
			
			headImg = baseUrl+"/common/users_getUsersHeadImg.action?size=30&headimg="+headImg;
			
			console.log(headImg);
			var li = $("<li></li>");
			var img = $("<img src='"+headImg+"'/>");
			var reply = "";

			if(item['message'] != "" && item['message'] != null)
				reply = "回复"+item['recivername']+":";
			else
				reply = "评论内容:";
			
			var div = $("<div><span>用户："+item['username']+"</span><span>"+reply+"&nbsp;&nbsp;&nbsp;&nbsp;"+item['text']+"</span><span>"+item['createtime']+"</span></div>");
			var a = $('<a href="javascript:void(0)" title="'+item['users']+'" name="'+item['id']+'" value="'+item['username']+'">回复</a>');

			a.on('click',addComments);
			
			li.append(img);
			
			li.append(div);
			
			li.append(a);
			
			container.append(li);
			
		})
	}
	
	function addComments(){
		//留言id
		var messageId = $(this).attr('name');
		//用户名
		var username = $(this).attr('value');
		//评论的用户id
		var users = $(this).attr('title');
		//此时登录的用户id
		var usersId = $('#onlineUser').val();
		
		if(users.trim() == usersId.trim()){
			alert("不能回复自己的评论！");
			return false;
		}
			
		$('.reply').html("回复:"+username);
		
		$('.reply').attr('name',messageId);
		$('.comment-content>textarea').focus();
		
	}
	
	$('.submit').click(function(){
		var text = $('#comment-content').val();
		var users = $('#onlineUser').val();
		var message = $('.reply').attr('name');

		if(message == null)
			message = "";
		
		if(users == null || users == " "){
			alert("请先登陆，登陆后才可评论!");
			return false;
		}else if(text == "" || text == null){
			alert("请输入评论内容");
			return false;
		}
			
		insertMsgData(text,users,message,id);
	});
	function insertMsgData(text,users,message,id){
		url = "text="+text+
			  "&users="+users+
			  "&message="+message+
			  "&goods="+id;
		$.ajax({
			type : "post", // 请求方式,get,post等
			dataType : 'json',// response返回数据的格式
			async : false, // 同步请求
			url : baseUrl + "/messages/insertMessages.action?" +url , // 需要访问的地址
			success : function(data) {
				console.log(data);
				if(data == 1){
					alert("提交留言成功!");
					getMsgData(id);
				}else
					alert("提交留言失败!");
				
				
				
			},
			error : function(data) {
				alert("提交留言失败!");
				console.log(data);
			}
		});
	}
	
	
	$('#buy').click(function(){
		
		if(confirm("确定购买?") == false)
			return false;
		var users = $('#onlineUser').val();
		var price = $('#price').attr('name');
		var addr = $("#location").html();
		
		if(users == " " || users == null){
			alert("请先登录!");
			return false;
		}else if(addr == null || addr == ""){
			alert("请选择收获地址!");
			return false;
		}
		
		var phone = userData['phone'];
		
		var realName = userData['realname'];
		
		var detail = userData['detail'];
		
		var goodsId = $('#goodsId').attr('value');
		
		var url =   "id="+users+
					"&price="+price+
					"&addr="+addr +
					"&phone="+ phone +
					"&torealname="+ realName +
					"&todetail="+ detail +
					"&goodsId="+goodsId;
		$.ajax({
			type : "post", // 请求方式,get,post等
			dataType : 'json',// response返回数据的格式
			async : false, // 同步请求
			url : baseUrl + "/user/updateUsersMoney.action?"+url, // 需要访问的地址
			success : function(data) {
				console.log(data);
				if(data == -1)
					alert("购买失败");
				else if(data == 3)
					alert("余额不足,请先充值");
				else{
					alert("购买成功!");
					location.href=baseUrl + "/goods/view/index.jsp";
				}
					
			},
			error : function(data) {
				console.log(data);
				alert("购买失败");
			}
		})
	})

});

function judgmentLogin(){
	var onlineUser = $('#onlineUser').attr('value');
	var baseUrl = $("#baseUrl").attr('value');

	if(onlineUser == " "){
		alert("请登录");
	}else{
		location.href=baseUrl+"/users/view/personalInfo.jsp";
	}
	
}