/**
 * Created by tom on 2017/9/14.
 */



$(function () {

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



    //根据点击事件切换价格上下箭头的颜色
    var direction = 1;
    $('.select>li:nth-of-type(2)').click(function(){
        restoreDefaults();
        if(1 == direction){
            $('#price>img:nth-of-type(1)').attr('src',"goods/img/price_top_yellow.png");
            direction = 2;
        }else{
            $('#price>img:nth-of-type(2)').attr('src',"goods/img/price_down_yellow.png");
            direction = 1;
        }
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


    //显示城市信息二级菜单
    var site = '{ "sites" : [' +
        '{ "name":"全国" , "city":"" },' +
        '{ "name":"直辖市" , "city":"北京,重庆,天津,上海" },' +
        '{ "name":"河北" , "city":"承德,石家庄,唐山" },'+
        '{ "name":"山西" , "city":"太原,长治" } ]}' ;
    var citys =JSON.parse(site);
    var table = $("<table class='secondary_menu'>"+"</table>");
    $('.city_info>table tr td').hover(function(e){

        $(this).append(table);

        var ld = $(this).index();//这个前面得到的是td的序号，从0开始，要得到第几行，+1即可
        var lh = $(this).parent().index();
        var content = $(this).text();
        var sum = (lh+1)*(ld+1);
        if(sum > citys.sites.length){
            return false;
        }else if(content != citys.sites[sum-1].name || "全国" == citys.sites[sum-1].name){
                return false;
        }

        var info = citys.sites[sum-1].city.split(",");

        var i;

        var row = $("<tr></tr>");
        table.append(row);
        for(i = 0 ; i < info.length ; i ++){
            console.log(info[i]);
            var col = $("<td>"+info[i]+"</td>");
            row.append(col);
        }

        if(info.length < 5){
            var j;
            for(j = 0 ; j < 5-info.length ; j++)
                row.append("<td></td>");
        }

        table.show();
    },function(){
        table.empty().hide();
    });


});



$(function(){

	var baseUrl = $('#baseUrl').val();

//	console.log(baseUrl);
	
	getTotalNum();
	var isFirstAcsse = true;
	function getData(min){
//		alert("getData获取页面数据");
		$('.trading_item_info>ul').empty();//清除容器中的所有数据
		
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : true,  //同步请求  
		    url : baseUrl+"/goods/showInfo.action?minLine="+min,  //需要访问的地址
			success:function(data){
				console.log("访问成功!");
				//显示商品数据
				setData(data);
				
				if(isFirstAcsse){
					setPage(data);
					isFirstAcsse = false;//设置其不再重复生成分页链接
				}
				
			},
			error:function(data){
//				console.log(data);
				$('.trading_item_info>ul').append("<center>查询出错<center>");
			}
		});
	}
	
	function setData(data){
//		alert("setData设置数据");
		var container = $('.trading_item_info>ul');
		$.each(data,function(index,item){
//			console.log(item);
			
			var title = item['title'];
			var headImg = item['headImg'];
			var time =item['createtime'].split("-"); 
			var hour = time[2].split(" ");
			//console.log(hour[1]);
			if(headImg == null){
				headImg = baseUrl+"/goods/img/default_icon.png";
			}else{
				headImg = "http://localhost/sht/common/goods_getGoodsImg.action?size=200&imgName="+headImg;
			}
			var li =	$("<li ></li>");
			li.attr("margint-left","30px");
			//添加标题
			var infoTitle = $("<div >"+"</div>");
			infoTitle.addClass("trading_info_title");
			
			infoTitle.append("<img src='"+headImg+"'/> <a"
					+"	href='#'>"+item['title']+"</a>");
			//图片
			var content = $("<a href='#'><img src='"+baseUrl+"/common/goods_getGoodsImg.action?t="+new Date().getTime()+"&size=200&imgName="+item['path']+"'/></a>");
			content.find("img").attr("width","210px");
			content.find("img").attr("height","210px");
			content.find("img").attr("margin","14px");
			//添加价格
			var priceContent = $("<div></div>");
			priceContent.addClass("trading_price");
			
			var price = $("<span>￥<span>"+item['sprice']+"</span></span> <span>"+item['addr']+"</span>");
			
			priceContent.append(price);
			
		
			var footer = $("<p>"+item['description']+"</p> <span class='time'>"+hour[1]+"前</span> <span class='come'>来自"
					+"	SHT</span> <span>留言"+item['msgNum']+"</span>");
			
			li.append(infoTitle);
			li.append(content);
			li.append(priceContent);
			li.append("<hr/>");
			li.append(footer);
			
			container.append(li);
		});
		
	}
	
	
	/**
	 * 分页
	 */
	var totalNum ;
	function setPage(data){
		
		console.log("totalNum="+totalNum);
//		alert("setPage设置分页");
		
		var pageLine = 4;//每页显示10条数据
//		console.log("数据总量"+data[0]['rn']);
		
//		var rowCount = data[data.length-1]['rownum'];
		
		var pageNum = (totalNum + pageLine -1)/pageLine;//总共多少页
		
//		console.log("页数"+pageNum);
		
		$('.allPage').html("共"+pageNum+"页");
		
		var container = $('.page').empty();
		
		if(pageNum != 1){
			$('.pre').show();
			$('.next').show();
		}
		
		console.log("zk pageNum="+pageNum);
		
		for(var i = 1;i <= pageNum ; i++){
			console.info(i);
			console.info(i <= pageNum);
			var li = $("<li name="+i+">"+i+"</li>");
			container.append(li);
			li.on("click",pageClickFun);
		}
		
	}
	
	
	
	//点击某一页查询相应的数据
	function pageClickFun(){
		var min = num - 1;
		getData(min);
	}
	
	//获取商品总数
	function getTotalNum(){

		var region = 0.0;
		
		$.ajax({
			type : "post",  //请求方式,get,post等
		    dataType:'json',//response返回数据的格式
		    async : false,  //同步请求  
		    url : baseUrl+"/goods/selectGoodsAllNum.action?region="+region,  //需要访问的地址
			success:function(data){
				console.log("访问成功!");
				//显示商品数据
				console.log("total num data="+data);
				totalNum = data;
				console.log("totalNum1="+totalNum);
				//获取商品信息
				getData(0);
			},
			error:function(data){
				console.log(data);
			}
		});
	}
	
})