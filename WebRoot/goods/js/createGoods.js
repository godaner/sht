/**
 * Created by tom on 2017/9/17.
 */

$(function() {
	var baseUrl = $('#baseUrl').val();
	console.log(baseUrl);
	/**
	 * 点击按钮上传
	 */
	var imgDataLen = 0;
	var fd = new FormData();
	$("#create").click(
			function() {
				var onlineUser = $('#onlineUser').val();
				var description = $("#description").val();
				var title = $('#title').val();
				var sprice = $('#sprice').val();
				var price = $('#price').val();
				sprice = parseInt(sprice);
				price = parseInt(price);
				var condition = $('#condition>option:selected').val();
				var region = $('#region>option:selected').val();
				var img = $('#file').val();
				var clazzs = $('#clazzs>option:selected').val();
				// 判断是否为空
				var isEmpty = judgementEmpty(onlineUser,description, title, sprice, price,
						condition, region, img ,clazzs);

				if (!isEmpty) {
					return false;
				}

				var url = "description=" + description + "&title=" + title
						+ "&sprice=" + sprice + "&price=" + price
						+ "&condition=" + condition + "&region=" + region
						+ "&status=0" + "&owner=1" ;

				// console.log(url);
				// uploadGoodsInfo(url);

			});

	/**
	 * 上传图片
	 */

	function uploadImg(goodsId) {
		// $.ajax({
		// url:baseUrl+"/files/createFiles.action",
		// type:"post",
		// data:"{'imgs':"+pd+"}",
		// success:function(data){
		// console.log('上传图片成功');
		//				
		// },
		// error:function(data){
		// alert("图片上传失败");
		// $.post(baseUrl+"goods/deleteGoods.action",function(data,status){
		//					
		// })
		// }
		// });
	}

	/**
	 * 上传商品信息
	 */
	function uploadGoodsInfo(url) {
		$.ajax({
			type : "post",
			async : false, // 同步请求
			
			url : baseUrl + "/goods/createGoods.action?" + url, // 需要访问的地址
			success : function(data) {
				console.log('商品信息发布成功');
				// if(data['msg']){
				// msg = data['msg'];
				// console.log(msg);
				// }else{
				// goodsId = data;
				//		    		
				// }
				// uploadImg(data);
			},
			error : function(data) {
				console.log('商品信息发布失败');
			}
		})
	}

	/**
	 * 判断商品信息输入字段是否为空
	 */
	function judgementEmpty(onlineUser,description, title, sprice, price, condition,
			region, img ,clazzs) {
		if(onlineUser == null || onlineUser == " "){
			alert("登录后才可发布商品");
			return false;
		}else if (null == description || "" == description) {
			alert("请描述你的商品");
			return false;
		} else if (null == title || "" == title) {
			alert("请填写商品标题");
			return false;
		} else if (null == sprice || "" == sprice) {
			alert("请填写商品转卖价");
			return false;
		} else if (null == price || "" == price) {
			alert("请填写商品原价");
			return false;
		}else if(sprice > price){
			alert("商品转卖价不能高于原价!");
			return false;
			
		}else if (null == condition || "" == condition || 0 == condition) {
			alert("请选择商品成色");
			return false;
		} else if ( -1 == region) {
			alert("请选择商品销售地(省-市-县)");
			return false;
		} else if (null == img || "" == img) {
			alert("请至少上传一张图片");
			return false;
		} else if (null == clazzs || "" == clazzs || 0 == clazzs) {
			alert("请为你的商品选择一个所属类别");
			return false;
		}
		return true;
	}

	/*
	 * 预览并上传图片
	 * 
	 */
	var uploadNum = 0;

	
	

	$('#file').change(function(e) {
		var files = e.target.files;
		console.log("length=" + files.length);
		for (var i = 0; i < files.length; i++) {
			preview(files[i]);
			fd.append("file"+(i+1), files[i]);
		}
//		console.log(fd);
//		for (var i = 0; i < files.length; i++) {
//			console.log(fd.get('file'+(i+1)));
//		}
	});
	
	$('.preview').click(function() {
		$('#file').click();
	});
	
//	 $("#file").uploadify({  
//	        'swf'       : 'plugin/uploadify/uploadify.swf',  
//	        'uploader'  : 'UploadServlet',    
//	        'folder'         : '/upload',  
//	        'queueID'        : 'fileQueue',
//	        'cancelImg'      : 'plugin/uploadify/uploadify-cancel.png',
//	        'buttonText'     : '上传文件',
//	        'auto'           : false, //设置true 自动上传 设置false还需要手动点击按钮 
//	        'multi'          : true,  
//	        'wmode'          : 'transparent',  
//	        'simUploadLimit' : 999,  
//	        'fileTypeExts'        : '*.*',  
//	        'fileTypeDesc'       : 'All Files'
//	    });  

	function preview(file) {
		// 检查图片格式和大小

		// if(file.size > 20480){
		// alert("对不起，图片超过20k，请调整图片大小后上传，谢谢 !");
		// return;
		// }
		var suffix = file.name.substring(file.name.lastIndexOf("."),
				file.name.length);

		if (suffix != ".jpg" && suffix != ".gif" && suffix != ".png"
				&& suffix != ".jpeg" && suffix != ".bmp") {
			alert("对不起，系统仅支持标准格式的照片，请您调整格式后重新上传，谢谢 !");
			return;
		}

		// 显示图片
		var img = new Image(), url = img.src = URL.createObjectURL(file);
		// console.log(url);
		img.style.width = "100px";
		img.style.height = "120px";

		var container = $('.add-img>ul');

		// 创建读取文件的对象
		var reader = new FileReader();
		// reader.readAsDataURL(file);
		// console.log(file.type);
		//		
		// reader.onerror = function(){
		// alert("无法预览该图片");
		// }
		//		
		// reader.onprogress = function(){
		// console.log("upload...");
		// }

		img.onload = function(e) {
			// console.log(e.target.result);
			// 保存图片数据,base64码
			// if(imgDataLen == 0){
			// params["requestMap.imgmain"] = e.target.result;
			// }else{
			// params["requestMap.img"+imgDataLen] = e.target.result;
			// }
			// imgDatas[imgDataLen] = e.target.result;
			// imgDataLen ++;

			// 显示预览图片
			previewImg(container, img);
			// var wshShell = new ActiveXObject("WScript.Shell");
			// window.clipboardData.setData('text',url);
			$("input[name='files']").eq(uploadNum).focus();
			// wshShell.sendKeys("^a");
			// wshShell.sendKeys("^v");

			uploadNum++;
			if (uploadNum >= 5) {
				$('#add').css("display", "none");
			}

		}

	}

	function previewImg(container, img) {
		var url = img.src;
		var li = $("<li class='preview new-li'></li>");
		container.append(li);
		li.empty().append(img);
		URL.revokeObjectURL(url);
	}
	

	$('#province').change(function(){
		var pid = $(this).children('option:selected').val();   
		getRegionData(pid,$('#city'));
	})
	
	$('#city').change(function(){
		var pid = $(this).children('option:selected').val();   
		getRegionData(pid,$('#county'));
	})
	
//	$('#county').change(function(){
//		alert($(this).children('option:selected').val());   
//	})
	
	getRegionData(1.0,$('#province'));
	function getRegionData(pid,target){
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/regions/selectAllRegions.action?pid="+pid,  //需要访问的地址
			success:function(data){
				console.log("访问地区成功!");

				console.log(data);
				setRegionData(data,target);
			},
			error:function(data){
				console.log("访问地区失败!");
				console.log(data);
			}
		});
	}

	function setRegionData(data,target){
    	var container = target;
    	container.find('option:not(:first)').remove();
    	
    	$.each(data,function(index,item){
    		var id = item['id'];
    		var name = item['name'];
    		if(name != '中国'){
    			var option = $('<option value="'+id+'" name="">'+name+'</option>');
    			container.append(option);
    		}

		});
    }

	getUsersInfo();
	getClazzs();
	
	
	function getUsersInfo(){
		var id = $('#onlineUser').attr('value');
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/user/selectUsersInfo.action?id="+id,  //需要访问的地址
			success:function(data){
				console.log("访问用户成功!");
				console.log(data);
				setUserInfo(data);
			},
			error:function(data){
				console.log("访问用户失败!");
				console.log(data);
			}
		});
	}
	
	function setUserInfo(data){
		var container = $('.content-left>div');
		var url = baseUrl+"/common/users_getUsersHeadImg.action?size=30&headimg=";
		
		var img = $("<img src='"+url+data['headimg']+"'>");
		
		var p = $("<p>"+data['username']+"</p>");
		
		container.append(img);
		
		container.append(p);
		
	}
	
	
	function getClazzs(){
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/clazzs/selectCategoryGoods.action",  //需要访问的地址
			success:function(data){
				console.log("访问成功!");
				console.log(data);
				setClazzsData(data);
			},
			error:function(data){
				console.log("访问失败!");
				console.log(data);
			}
		});
	}
	
	function setClazzsData(data){
		var container = $('#clazzs');
    	container.find('option:not(:first)').remove();
    	
    	$.each(data,function(index,item){
    		var id = item['id'];
    		var text = item['text'];
 
    		var option = $('<option value="'+id+'">'+text+'</option>');
    		container.append(option);


		});
	}
	
})