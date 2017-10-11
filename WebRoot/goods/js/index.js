/**
 * Created by tom on 2017/9/14.
 */



$(function () {
	var baseUrl = $('#baseUrl').val();
	$('#minPrice').html('');
	$('#maxPrice').html('');
    //展开或收起闲置列表
    var flag = false;
    $('#show').click(function () {

        if (!flag) {
            $('#option').animate(
                {
                    height: '200px'
                }, 'slow');
            $('#show').html('收起');
            flag = true;
        }else{
            $('#option').animate(
                {
                    height: '100px'
                }, 'slow');
            $('#show').html('展开');
            flag = false;
        }


    });


    var globalRegion=0,globalData = null,isOrderByTime = 3,isOrderByPrice = 3;
    var minPrice = 0,maxPrice = 0,globalClazz = 0;
    
    //根据点击事件切换价格上下箭头的颜色
    var direction = 1;
    $('.select>li:nth-of-type(1)').click(function(){
    	restorePrice();
    	$('.select li').css("background-color","#f9fbff");
    	$(this).css("background-color","#e6fdff");
    	isOrderByTime = 1;//按照时间降序排列
    	isOrderByPrice = 3;//3表示不为查询条件
    	getData(0,globalRegion,isOrderByTime,isOrderByPrice,minPrice,maxPrice,globalClazz);
    })
    
    
    $('.select>li:nth-of-type(2)').click(function(){
    	restorePrice();
    	$('.select li').css("background-color","#f9fbff");
    	$(this).css("background-color","#e6fdff");
        restoreDefaults();
        if(1 == direction){
            $('#price>img:nth-of-type(1)').attr('src',"goods/img/price_top_yellow.png");
            direction = 2;
            isOrderByTime = 3;
        	isOrderByPrice = 2;//按照价格升序排列
        }else{
            $('#price>img:nth-of-type(2)').attr('src',"goods/img/price_down_yellow.png");
            direction = 1;
            isOrderByTime = 3;
        	isOrderByPrice = 1;//按照价格降序排列
        }
        
        
    	getData(0,globalRegion,isOrderByTime,isOrderByPrice,minPrice,maxPrice,globalClazz);
    })

    function restoreDefaults(){
        $('#price>img:nth-of-type(1)').attr('src',"goods/img/price_top_grey.png");
        $('#price>img:nth-of-type(2)').attr('src',"goods/img/price_down_grey.png");
    }

    $('.city_info>div img').hover(function(){

        $('.city_info>div img').attr('src','goods/img/close_yellow.png');
    },function(){
        $('.city_info>div img').attr('src','goods/img/close_grey.png');
    });


    //显示城市列表
    $('.city>div>ul').click(function(){
    	restorePrice();
    	getRegionData();
        var height = $(document).scrollTop();
        $('.city_info').css({
            'top':height+'px'
        });
        $('.city_info').slideDown();
    });
    //隐藏城市列表
    $('.city_info>div img').click(function(){
        $('.city_info').slideUp();
    });

    function getRegionData(){
    	var pid = 1;
    	$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/regions/selectAllRegions.action?pid="+pid,  //需要访问的地址
			success:function(data){
				console.log("访问地区成功!");
				//显示商品类别
				console.log(data);
				setRegionData(data);
			},
			error:function(data){
				console.log("访问地区失败!");
				console.log(data);
			}
		});
    }

    function setRegionData(data){
    	var table = $('.city_info table').empty();
    	var tr = null;
    	
    	$.each(data,function(index,item){
			var name = item['name'];

			if(name.indexOf('省') != -1  )
				name = name.substring(0,3);
			else 
				name = name.substring(0,2);
			
			if((index  % 5) == 0){
				tr = $('<tr></tr>');
			}
			
			if(name == '中国')
				name = '全国';
			var td = $('<td name='+item['id']+'> '+name+'</td>');
			
			td.on('click',selectGoodsByRegion)
			
			tr.append(td);
			if(( index  % 5 ) == 0 ){
				table.append(tr);
			}
		});
    }
   
    function selectGoodsByRegion(name){
    	$('.city_info').slideUp();
    	var name = $(this).html();
    	
    	$('.city>div>ul>li:eq(0)').html(name);
    	
    	var region = $(this).attr('name');
    	console.log("region="+region);
    	//根据省份id查询商品总数量
    	if(region == 1)
    		region = 0;
    	getTotalNum(region,minPrice,maxPrice,globalClazz);
    	
    }

	
    
    $('#sure').click(function(){
    	minPrice = $('#minPrice').val();
    	maxPrice = $('#maxPrice').val();
    	
    	if(minPrice == null || minPrice == '' || 
    			maxPrice == null || maxPrice == ''){
    		alert("请输入价格范围");
    		return false;
    	}else if(minPrice <0 || maxPrice < 0){
    		alert("请输入正确的价格");
    		return false;
    	}
    	console.log("globalRegion:"+globalRegion);
    	getTotalNum(globalRegion,minPrice,maxPrice,globalClazz);
    	
    });
    
    function restorePrice(){
    	$('#minPrice').html('');
    	$('#maxPrice').html('');
    	minPrice = 0;
    	maxPrice = 0;
    }
    
	generalCatogaryGoods();
	//获取商品所有类别
	function generalCatogaryGoods(){
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/clazzs/selectCategoryGoods.action",  //需要访问的地址
			success:function(data){
				console.log("访问类别成功!");
				//显示商品类别
				console.log(data);
				setCategory(data);
			},
			error:function(data){
				console.log("访问类别失败!");
				console.log(data);
			}
		});
	}
	
	//填充商品类别数据
	function setCategory(data){

		var table = $('#option table').empty();
		var tr =  $('<tr></tr>');
		
		var tdAll ;

		var line =Math.ceil( data.length/5 );

		var sum = 0,i=1,temp=3;


		$.each(data,function(index,item){

			sum = sum + item['num'];
			if(index  == 0){
				tdAll = $("<td title='全部' name='0'>全部<span></span></td>");
				tdAll.on('click',getDataByCategory);
				tr.append(tdAll);
				
			}

				

			if(temp == index){
				table.append(tr);
			}
			
			
			
			var td = $('<td title="'+item['text']+'" name="'+item['id']+'">'+item['text']+' <span>('+item['num']+')</span></td>');
			
			td.on('click',getDataByCategory);
			tr.append(td);
			

			if(temp == index){

				tr = $('<tr></tr>');
				i++;

				temp +=5;

			}
			
			
		});

		
		if( i < line)
			table.append(tr);
		
		tdAll.find('span').text("("+sum+")");

		

	}
	
	function getDataByCategory(){
		isOrderByTime = 3;
		isOrderByPrice = 3;
	    minPrice = 0;
	    maxPrice = 0;
	    globalClazz = $(this).attr('name');
	    
	
	    $('.city>div>ul>li:eq(0)').html("全国");
	    	
	  
	    	
//	    getTotalNum(globalRegion,minPrice,maxPrice,globalClazz);
	    getTotalNum(0,minPrice,maxPrice,globalClazz);
	}
	
	getTotalNum(0.0,0,0,0);
	function getData(min,region,orderByTime,orderByPrice,minPrice,maxPrice,clazzs){
		console.log("minPrice:"+minPrice);
		console.log("maxPrice:"+maxPrice);
		$('.trading_item_info>ul').empty();//清除容器中的所有数据
		var url ="minLine="+min+
				  "&region="+region +
				  "&orderByTime="+orderByTime+
				  "&orderByPrice="+orderByPrice+
				  "&minPrice="+minPrice+
				  "&maxPrice="+maxPrice+
				  "&clazz="+clazzs;
//		console.log("url:"+url);
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/goods/showInfo.action?"+url,  //需要访问的地址
			success:function(data){
				
				console.log(data);
				globalData = data;
				//显示商品数据
				setData(data);
				
			},
			error:function(data){
				
				console.log(data);
				
				$('.trading_item_info>ul').append("<center>查询出错<center>");
			}
		});
	}
	
	function setData(data){
		var container = $('.trading_item_info>ul');
		$.each(data,function(index,item){
			var title = item['title'];
			var headImg = item['headImg'];

			var time =item['createtime'].split(" "); 

			var description = item['description'];
			
			console.log("headimg"+headImg);
			
			headImg = baseUrl+"/common/users_getUsersHeadImg.action?t="+new Date().getTime()+"&size=30&headimg="+headImg;
			
			var li =$("<li></li>");

			li.attr("margint-left","30px");
			//添加标题
			var infoTitle = $("<div>"+"</div>");
			infoTitle.addClass("trading_info_title");

			infoTitle.append("<img style='width:30px;height:30px;border-radius:50%;' src='"+headImg+"'/> <a"

					+"	href='javascript:void(0)'>"+item['username']+"</a>");
			
			console.log(item['username']);
			
			
			
			//图片
			var content = $("<a href='"+baseUrl+"/goods/showGoodsDetailInfo.action?id="+item['id']+"'><img src='"+baseUrl+"/common/goods_getGoodsImg.action?size=200&imgName="+item['path']+"'/></a>");
			content.find("img").css("width","200px");
			content.find("img").css("height","200px");
			content.find("img").css("margin","13px");
			//添加价格
			var priceContent = $("<div></div>");
			priceContent.addClass("trading_price");
			
			var price = $("<span>￥<span>"+item['sprice']+"</span></span> <span>"+item['addr']+"</span>");
			
			priceContent.append(price);

			if(description.length >15)
				description = description.substring(0,15) + "...";

				
			var footer = $("<b style='margin-left:10px;'>"+item['title']+"</b><p class='description'  title='"+item['description']+"'>"+description+"</p><p>"+item['clazz']+"</p> <span class='time'>"+time[0]+"</span> <span class='come'>来自"
					+"	SHT</span> <span>留言"+item['msgNum']+"</span>");
			
			li.append(infoTitle);
			li.append(content);
			li.append(priceContent);
			li.append("<hr/>");
			li.append(footer);
			
			container.append(li);
		});
		
	}
	function showTipInfo(){
		console.log("showTipInfo");
		var container = $('.trading_item_info>ul');
		container.children('li').remove();
		container.children('p').remove();
		var tip = $('<p>暂无数据</p>');
		tip.css({
			"display":"block",

			"positive":"relative",
			"margin":"20px",
			"text-align":"center"

		});
		container.append(tip);
	}
	
	/**
	 * 分页
	 */
	var totalNum , currentPage=1,pageNum;
	
	function setPage(region){
		console.log("setPage");
		$('section>footer>div').show();
		
		var pageLine = 4;//每页显示4条数据
		
		globalRegion = region;
		
		
		pageNum = Math.ceil(totalNum / pageLine);//总共多少页
		
		
		$('.allPage').html("共"+pageNum+"页");
		
//		var container = $('.page').children('li').remove();
		var container = $('.page').empty();
		
		if(pageNum > 1){
			$('.pre').css("display","inline-block");
			$('.next').css("display","inline-block");
		}
		
		var flag = true;
		for(var i = 1;i <= pageNum ; i++){
			var li;
//			if(i < pageNum - 1 && i > 1){
//				alert(1);
//				if(flag){
//					li = $("<li >...</li>");
//				}
//				flag = false;
//			}else{
				li = $("<li name="+i+">"+i+"</li>");
//			}
			
			container.append(li);
			li.on("click",pageClickFun);
		}
		
	}
	
	$('.pre').click(function(){
		if(currentPage > 1){
			currentPage -=1;
			pageCommonFun();
		}else{
			alert("已经到了第一页");
		}
		
	});
	
	$('.next').click(function(){
		if(currentPage < pageNum){
			currentPage +=1;
			pageCommonFun();
		}else{
			alert("已经到了最后一页");
		}
	});
	
	//点击某一页查询相应的数据
	function pageClickFun(){
		currentPage = $(this).attr('name');
		pageCommonFun();
	}
	
	function pageCommonFun(){
		var num = 4;//每页显示4条数据
		var min = (currentPage - 1) * num;
		
		$('.page li').css("background-color","white");
		$('.page li:eq('+(currentPage-1)+')').css("background-color","#ffcc00");
		
		console.log("最小"+min);
		
		getData(min,globalRegion,isOrderByTime,isOrderByPrice,minPrice,maxPrice,globalClazz);
	}
	
	
	function hidePage(){
		console.log("hidePage");
		$('section>footer>div').hide();
	}
	
	//获取商品总数
	function getTotalNum(region,minPrice,maxPrice,clazz){
		console.log("getTotalNum--region="+region);
		console.log(clazz);
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/goods/selectGoodsAllNum.action?sregion="+region+"&minPrice="+minPrice
		    							+"&maxPrice="+maxPrice+"&clazz="+clazz,  //需要访问的地址
			success:function(data){

				//显示商品数据
				console.log("商品总数="+data);
				$('.city>div>span').html("("+data+")");
				totalNum = data;
				if(totalNum != 0){
					getData(0,region,isOrderByTime,isOrderByPrice,minPrice,maxPrice,clazz);//获取商品信息
					setPage(region);
				}else{
					showTipInfo();
					hidePage();
				}
					

			},
			error:function(data){
				console.log(data);
			}
		});
	}
	
})



