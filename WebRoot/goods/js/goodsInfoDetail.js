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

	var rotationEvent;
	var rotationIndex = 0;

	var imgSrc = [ 'goods/img/content.png', 'goods/img/rotation.png',
			'goods/img/content.png', 'goods/img/rotation.png' ];
	$('#rotation-item>li').hover(function() {
		clearTimeout(rotationEvent);
		var index = $(this).index();
		restoreBorder();
		$(this).css('border-color', 'orangered');
		var target = $('.content-left>img');
		target.attr('src', imgSrc[index]);
	}, function() {
		restoreBorder();
		rotationIndex = $(this).index();
		rotation();
	});

	$('.content-left>img').hover(function() {
		clearTimeout(rotationEvent);
	}, function() {
		rotation();
	});

	function rotation() {
		rotationIndex++;
		if (rotationIndex >= 4) {
			rotationIndex = 0;
		}
		restoreBorder();

		$('.content-left>ul>li:eq(' + rotationIndex + ')').css('border-color',
				'orangered');
		$('.content-left>img').attr('src', imgSrc[rotationIndex]);

		rotationEvent = setTimeout(rotation, 2000);
	}
	rotationEvent = setTimeout(rotation, 2000);
	function restoreBorder() {
		$('#rotation-item li').css({
			'border' : '1px solid gold'
		});
	}

	var baseUrl = $('#baseUrl').val();

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
				console.log(data);

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
			
			if ((index % 4) == 0 && index != 0) {

				table.append(tr);
				tr = $('<tr></tr>');
			}
			
			if(data.length <= 5)
				table.append(tr);

		});
		
		if(data.length >= 5){
			table.css('width','400px');
//			table.find('tr').find('td').css('width',"100px");
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

	function setCityInfo() {
		var city = $(this).text();
		table.find('tr').remove();
		table.empty().hide();
		$('.city_info table').find('tr').remove();
		$('.city_info').toggle('slow');
		$('#location>span').text(city);

	}
	;

	// 隐藏城市列表
	$('.city_info>div img').click(function() {
		$('.city_info').slideUp();
	});
	$('.city_info>div img').hover(function() {

		$('.city_info>div img').attr('src', 'goods/img/close_yellow.png');
	}, function() {
		$('.city_info>div img').attr('src', 'goods/img/close_grey.png');
	});

})