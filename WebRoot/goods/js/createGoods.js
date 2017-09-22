/**
 * Created by tom on 2017/9/17.
 */

$(function() {

	$("#create").click(function() {
		var description = $("#description").val();
		var title = $('#title').val();
		var sprice = $('#sprice').val();
		var price = $('#price').val();
		var condition = $('#condition').val();
		var region = $('#region').val();

		$.ajax({
			type : "post",
			// dataType:'json',//response返回数据的格式
			async : true, // 同步请求
			url : baseUrl + "/goods/showInfo.action", // 需要访问的地址
			success : function(data) {

			},
			error : function(data) {
				console.log('失败');
			}
		})

	});

	$('#preview').click(function() {
		$("#file").click();
		// previewImage($("#file"));
		$('#file').change(function(e) {
			var file = e.target.files[0];

			console.log(file);
			preview1(file);
		});

	});

	function preview1(file) {

		//检查图片格式和大小
//		console.log(file.name);
		if(file.size > 20480){
			alert("对不起，图片超过20k，请调整图片大小后上传，谢谢 !");
			return;
		}
		var suffix = file.name.substring(file.name.lastIndexOf("."),
				file.name.length);
//		console.log(suffix);
		if (suffix != ".jpg" && suffix != ".gif" && suffix != ".png"
				&& suffix != ".jpeg" && suffix != ".bmp") {
			alert("对不起，系统仅支持标准格式的照片，请您调整格式后重新上传，谢谢 !");
			return;
		}

		//显示图片
		var img = new Image(), url = img.src = URL.createObjectURL(file);
		img.css({
			"width":"50px",
			"height":"70px"
			
		});
		var li = $("<li class='.newLi'></li>");
		var container = $('.add-img>ul');
		container.append(li);
		var $img = $(img);
		img.onload = function() {
			URL.revokeObjectURL(url);
			li.empty().prepend($img);
		}

	

	

	}
})