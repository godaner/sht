/**
 * Created by tom on 2017/9/17.
 */

$(function() {
	
	
	$('#preview').click(function(){
		console.log('click');
		previewImage($(this));
	});
	
	
	
	function previewImage(file){
		var MAXWIDTH = 100;//图片的最大宽度

		var MAXHEIGHT = 100;//图片的最大高度
		console.log(file);
		var li =$('#preview');

		if (file.files && file.files[0])

		{

			li.innerHTML = '<img id=imghead>';
			
			var createLi = $("<li><img class='new-img'/></li>")

			var img = document.getElementById('imghead');

			img.onload = function() {

				var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT,
						img.offsetWidth, img.offsetHeight);

				img.width = rect.width;

				img.height = rect.height;

				img.style.marginLeft = rect.left + 'px';

				img.style.marginTop = rect.top + 'px';

			}

			var reader = new FileReader();

			reader.onload = function(evt) {
				img.src = evt.target.result;
			}

			reader.readAsDataURL(file.files[0]);

		}

		else

		{

			var sFilter = 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';

			file.select();

			var src = document.selection.createRange().text;

			li.innerHTML = '<img id=imghead>';

			var img = document.getElementById('imghead');

			img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;

			var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth,
					img.offsetHeight);

			status = ('rect:' + rect.top + ',' + rect.left + ',' + rect.width
					+ ',' + rect.height);

			li.innerHTML = "<div id=divhead style='width:" + rect.width
					+ "px;height:" + rect.height + "px;margin-top:" + rect.top
					+ "px;margin-left:" + rect.left + "px;" + sFilter + src
					+ "\"'></div>";

		}

	}

	function clacImgZoomParam(maxWidth, maxHeight, width, height) {

		var param = {
			top : 0,
			left : 0,
			width : width,
			height : height
		};

		if (width > maxWidth || height > maxHeight)

		{

			rateWidth = width / maxWidth;

			rateHeight = height / maxHeight;

			if (rateWidth > rateHeight)

			{

				param.width = maxWidth;

				param.height = Math.round(height / rateWidth);

			} else

			{

				param.width = Math.round(width / rateHeight);

				param.height = maxHeight;

			}

		}

		param.left = Math.round((maxWidth - param.width) / 2);

		param.top = Math.round((maxHeight - param.height) / 2);

		return param;

	}
})