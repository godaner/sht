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
	console.log(baseUrl);
	$.ajax({
		type : "post",  //请求方式,get,post等
	    dataType:'json',//response返回数据的格式
	    async : true,  //同步请求  
	    url : baseUrl+"/goods/showInfo.action",  //需要访问的地址
		success:function(data){
			console.log("访问成功!");
			setData(data);
		},
		error:function(data){
			console.log(data);
		}
	});
	
	function setData(data){
		console.log(data);
	}
})