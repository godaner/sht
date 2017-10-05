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
			imgSrc = data.split('.png-');
			splitData(imgSrc);
		},
		error : function(data) {
			console.log("访问失败!");
			console.log(data);
		}
	});

	
	function splitData(imgSrc){
		for(var i = 0 ; i < imgSrc.length ; i ++){
			
			if(i != imgSrc.length - 1)
				imgSrc[i] = imgSrc[i] + ".png";
			
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

	

	// 显示城市列表
	$('#location').click(function() {

		var height = $(this).offset().top - 50;
		$('.city_info').css({
			'top' : height + 'px',
			
		});
		//获取省份信息
		getRegionData(1, $('.city_info table'));
		$('.city_info').slideDown();
	});

	function getRegionData(pid, target) {
		$.ajax({
			type : "post", // 请求方式,get,post等
			dataType : 'json',// response返回数据的格式
			async : false, // 同步请求
			url : baseUrl + "/regions/selectAllRegions.action?pid=" + pid, // 需要访问的地址
			success : function(data) {
				console.log("访问地区成功!");
				// 显示商品类别
//				console.log(data);

				if (target.attr('class') == 'secondary_menu')
					setSecondMenuData(data, target);
				else
					setRegionData(data, target);
			},
			error : function(data) {
				console.log("访问地区失败!");
				console.log(data);
			}
		});
	}

	function setRegionData(data, target) {
		var table = target.empty();

		var tr = $("<tr></tr>");
		$.each(data, function(index, item) {
			var name = item['name'];
			if (index == 0)
				return true;
			if (name.indexOf('省') != -1 || name.indexOf('市') != -1)
				name = name.substring(0, 3);
			else
				name = name.substring(0, 2);

			var td = $('<td name=' + item['id'] + '> ' + name + '</td>');
			tr.append(td);

			td.hover(function() {
				showSecondMenu(td);

			}, function() {
				hideSecondMenu();
			})

			if ((index % 5) == 0) {
				table.append(tr);
				tr = $('<tr></tr>');
			}

		});
	}

	function setSecondMenuData(data, target) {

		var table = target.empty();

		var tr = $("<tr></tr>");

		$.each(data, function(index, item) {
			var name = item['name'];
			
			name = name.substring(0, 3);
			
			var td = $('<td name=' + item['id'] + '> ' + name + '</td>');
			
			tr.append(td);
			
			td.on('click', setCityInfo);
	
			if (((1+index) % 5) == 0 && index != 0) {
				
				table.append(tr);
				tr = $('<tr></tr>');
			}
			
			if(data.length <= 5)
				table.append(tr);

		});
		
		if(data.length >= 5){
			table.css('width','400px');

		}
	}

	// 显示城市信息二级菜单

	var table = $("<table class='secondary_menu'></table>");

	function showSecondMenu(target) {

		target.append(table);

		var pid = target.attr('name');

		getRegionData(pid, table);

		table.show();
		
	}

	function hideSecondMenu() {
		table.empty().hide();
		
	}
	
	//显示三级城市列表
	function setCountyInfo(data){
		var table = $('#county').empty();
		var tr = $("<tr></tr>");
		$.each(data,function(index,item){
			
			var name = item['name'];
			name = name.substring(0, 3);
			
			var td = $('<td name=' + item['id'] + '> ' + name + '</td>');
			
			td.on('click',showCountyInfo);
			
			tr.append(td);
			
			if((index % 5) == 0 && index != 0){
				
				table.append(tr);
				tr = $('<tr></tr>');
			}
		})
		if(data.length > 0)
			table.show();

	}

	function getBasedRegionData(pid,target) {
		$.ajax({
			type : "post", // 请求方式,get,post等
			dataType : 'json',// response返回数据的格式
			async : false, // 同步请求
			url : baseUrl + "/regions/selectAllRegions.action?pid=" + pid, // 需要访问的地址
			success : function(data) {
				console.log("访问地区成功!");
				// 显示商品类别
//				console.log(data);

				setCountyInfo(data);
			
			},
			error : function(data) {
				console.log("访问地区失败!");
				console.log(data);
			}
		});
	}
	
	function setCityInfo() {
		var city = $(this).text();
		
		table.find('tr').remove();
		table.empty().hide();
		$('.city_info table').find('tr').remove();
		
		$('.city_info').toggle('slow');
		
		$('#location>span').text(city);
		var pid = $(this).attr('name');
		getBasedRegionData(pid,$(this));
	}
	
	function showCountyInfo(){
		var county = $(this).text();
		$("#county").empty().hide();
		$('#express>span').html(county);
	}

	// 隐藏城市列表
	$('.city_info>div img').click(function() {
		$('.city_info').slideUp();
	});
	$('.city_info>div img').hover(function() {

		$('.city_info>div img').attr('src', 'goods/img/close_yellow.png');
	}, function() {
		$('.city_info>div img').attr('src', 'goods/img/close_grey.png');
	});
	
	
	//
	
	var msgnum = $("#msgnum").val();
	if(msgnum != 0)
		getMsgData(id);
	
	function getMsgData(id){
		$('.reply').html("");
		$('.reply').removeAttr('name');
		$('.comment-content>textarea').html("");
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
	
	
	function setMsgData(data){
		
		var container = $('.comment-container').empty();
		
		$.each(data,function(index,item){
			
			var headImg = item['headImg'];
			
			if(headImg == null || headImg == "")
				headImg = baseUrl + '/goods/img/default_icon.png';
			else 
				headImg = baseUrl + '/common/goods_getGoodsImg.action?size=30&imgName='+headImg;
			
			var li = $("<li></li>");
			var img = $("<img src='"+headImg+"'/>");
			var reply = "";
//			console.log("message:"+item['message']);
			if(item['message'] != "" && item['message'] != null)
				reply = "回复"+item['username']+":";
			else
				reply = "评论内容:";
			var div = $("<div><span>用户："+item['username']+"</span><span>"+reply+item['text']+"</span><span>"+item['createtime']+"</span></div>");
			var a = $('<a href="javascript:void(0)" name="'+item['id']+'" value="'+item['username']+'">回复</a>');
			a.on('click',addComments);
			
			li.append(img);
			
			li.append(div);
			
			li.append(a);
			
			container.append(li);
			
		})
	}
	
	function addComments(){
		var messageId = $(this).attr('name');
		var username = $(this).attr('value');
		$('.reply').html("回复:"+username);
		$('.reply').attr('name',messageId);
		$('.comment-content>textarea').focus();
		
	}
	
	$('.submit').click(function(){
		var text = $('#comment-content').val();
		var users = $('#onlineUser').val();
		var message = $('.reply').attr('name');
//		alert(message);
		if(message == null)
			message = "";
		
		if(users == null || users == ""){
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
				if(data == 1)
					alert("提交留言成功!");
				else
					alert("提交留言失败!");
				
				getMsgData(id);
				
			},
			error : function(data) {
				alert("提交留言失败!");
				console.log(data);
			}
		});
	}

})