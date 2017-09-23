/**
 * Created by tom on 2017/9/17.
 */

$(function() {
	var baseUrl = $('#baseUrl').val();
	console.log(baseUrl);
	/**
	 * 点击按钮上传
	 */
	var imgDatas = new Array(),imgDataLen = 0;
	
	$("#create").click(function() {
		//console.log(imgDatas.length);
		var description = $("#description").val();
		var title = $('#title').val();
		var sprice = $('#sprice').val();
		var price = $('#price').val();
		var condition = $('#condition').val();
		var region = $('#region').val();
		
		var isEmpty = judgementEmpty(description,title,sprice,price,condition,region);
		
		if(!isEmpty){
			return false;
		}
		
		//console.log("----"+new Date("yyyy-MM-dd HH:mm"));
		//var date = Format(new Date(),"yyyy-MM-dd HH:mm");
		
		var url = "?description="+description+
					"&title="+title+
					"&sprice="+sprice+
					"&price="+price+
					"&condition="+condition+
					"&region="+region+
					"&status=0"+
					
					"&owner=1";
		
		var imgDataJson = JSON.stringify(imgDatas);
		console.log(baseUrl+url);
		$.ajax({
			type : "post",
			//data:{'img':imgDataJson},
			async : true, // 同步请求
			url : baseUrl + "/goods/createGoods.action"+url, // 需要访问的地址
			success : function(data) {
				alert("商品发布成功");
			},
			error : function(data) {
				console.log('ajax-失败');
			}
		})

	});
	
	/**
	 * 判断商品信息输入字段是否为空
	 */
	function judgementEmpty(description,title,sprice,price,condition,region){
		if(null == description || "" == description){
			alert("请描述你的商品");
			return false;
		}else if(null == title || "" == title){
			alert("请填写商品标题");
			return false;
		}else if(null == sprice || "" == sprice){
			alert("请填写商品转卖价");
			return false;
		}else if(null == price || "" == price){
			alert("请填写商品原价");
			return false;
		}else if(null == condition || "" == condition){
			alert("请填写商品成色");
			return false;
		}else if(null == region || "" == region){
			alert("请填写商品销售地");
			return false;
		}
		return true;
	}
	
	
	/*
	 * 日期格式化
	 * 
	 */
	function Format(now,mask)
    {
        var d = now;
        var zeroize = function (value, length)
        {
            if (!length) length = 2;
            value = String(value);
            for (var i = 0, zeros = ''; i < (length - value.length); i++)
            {
                zeros += '0';
            }
            return zeros + value;
        };
     
        return mask.replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g, function ($0)
        {
            switch ($0)
            {
                case 'd': return d.getDate();
                case 'dd': return zeroize(d.getDate());
                case 'ddd': return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][d.getDay()];
                case 'dddd': return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.getDay()];
                case 'M': return d.getMonth() + 1;
                case 'MM': return zeroize(d.getMonth() + 1);
                case 'MMM': return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][d.getMonth()];
                case 'MMMM': return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][d.getMonth()];
                case 'yy': return String(d.getFullYear()).substr(2);
                case 'yyyy': return d.getFullYear();
                case 'h': return d.getHours() % 12 || 12;
                case 'hh': return zeroize(d.getHours() % 12 || 12);
                case 'H': return d.getHours();
                case 'HH': return zeroize(d.getHours());
                case 'm': return d.getMinutes();
                case 'mm': return zeroize(d.getMinutes());
                case 's': return d.getSeconds();
                case 'ss': return zeroize(d.getSeconds());
                case 'l': return zeroize(d.getMilliseconds(), 3);
                case 'L': var m = d.getMilliseconds();
                    if (m > 99) m = Math.round(m / 10);
                    return zeroize(m);
                case 'tt': return d.getHours() < 12 ? 'am' : 'pm';
                case 'TT': return d.getHours() < 12 ? 'AM' : 'PM';
                case 'Z': return d.toUTCString().match(/[A-Z]+$/);
                // Return quoted strings with the surrounding quotes removed
                default: return $0.substr(1, $0.length - 2);
            }
        });
    };
    
    
    
    /*
     * 预览并上传图片
     * 
     */
	var uploadNum = 0;
	
	
	$('#file').change(function(e) {
		var file = e.target.files[0];
		
		preview(file);
		
	});
	$('.preview').click(function() {
		$("#file").click();
	});
	
	
	function preview(file) {
		
	    
//		console.log(file);
		//检查图片格式和大小

//		if(file.size > 20480){
//			alert("对不起，图片超过20k，请调整图片大小后上传，谢谢 !");
//			return;
//		}
		var suffix = file.name.substring(file.name.lastIndexOf("."),
				file.name.length);

		if (suffix != ".jpg" && suffix != ".gif" && suffix != ".png"
				&& suffix != ".jpeg" && suffix != ".bmp") {
			alert("对不起，系统仅支持标准格式的照片，请您调整格式后重新上传，谢谢 !");
			return;
		}

		//显示图片
		var img = new Image(), url = img.src = URL.createObjectURL(file);
		//console.log(url);
		img.style.width="100px";
		img.style.height="120px";
		
		var container = $('.add-img>ul');
		
		 //创建读取文件的对象  
	    var reader = new FileReader(); 
	    reader.readAsDataURL(file);
		console.log(file.type);
		
		reader.onerror = function(){
			alert("无法上传该图片");
		}
		
		reader.onprogress = function(){
			console.log("upload...");
		}
		
		reader.onload = function(e) {
			//保存图片数据,base64码
			imgDatas[imgDataLen] = e.target.result;
			imgDataLen ++;
			
			//显示预览图片
			upLoadImg(container,img);
			uploadNum ++;
			if(uploadNum >=5){
				$('#add').css("display","none");
			}
			
		}
		
	}
	
	function upLoadImg(container,img){
		var url = img.src;
		var li = $("<li class='preview new-li'></li>");
		container.append(li);
		li.empty().append(img);
		URL.revokeObjectURL(url);
	}
	
})