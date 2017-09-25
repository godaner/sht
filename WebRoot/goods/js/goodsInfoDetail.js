/**
 * Created by tom on 2017/9/16.
 */

$(function(){



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

    //闲置
    $('.idle').hover(function(){
        $('.idle>img').attr('src','goods/img/up_black.png');
        $('.idle_down').show();
    },function(){
        $('.idle>img').attr('src','goods/img/down_black.png');
        $('.idle_down').hide();
    });


    //显示我的店铺下拉列表信息
    $('#myShop').hover(function(){
        $('#myShop').css('background-color','white');
        $('#myShop>ul').show();
    },function(){
        $('#myShop').css('background-color','transparent');
        $('#myShop>ul').hide();
    });

    //显示收藏夹下拉列表信息
    $('.collection').hover(function(){
        $('.collection').css('background-color','white');
        //切换图片
        $('.collection>img:eq(0)').attr('src','goods/img/star_yellow.png');
        $('.collection>img:eq(1)').attr('src','goods/img/down_yellow.png');

        $('.collection>ul').show();
    },function(){
        $('.collection').css('background-color','transparent');
        //切换图片
        $('.collection>img:eq(0)').attr('src','goods/img/star_grey.png');
        $('.collection>img:eq(1)').attr('src','goods/img/down_grey.png');

        $('.collection>ul').hide();
    });

    //图片轮播

    var rotationEvent ;
    var rotationIndex = 0;

    var imgSrc =['goods/img/content.png','goods/img/rotation.png','goods/img/content.png','goods/img/rotation.png'];
    $('#rotation-item>li').hover(function(){
        clearTimeout(rotationEvent);
        var index = $(this).index();
        restoreBorder();
		$(this).css('border-color','orangered');
        var target = $('.content-left>img');
        target.attr('src',imgSrc[index]);
    },function(){
		restoreBorder();
        rotationIndex = $(this).index();
        rotation();
    });

    $('.content-left>img').hover(function(){
        clearTimeout(rotationEvent);
    },function(){
        rotation();
    });



    function rotation(){
        rotationIndex ++;
        if(rotationIndex >= 4 ){
            rotationIndex = 0;
        }
		restoreBorder();

		$('.content-left>ul>li:eq('+rotationIndex+')').css('border-color','orangered');
        $('.content-left>img').attr('src',imgSrc[rotationIndex]);

        rotationEvent = setTimeout(rotation,2000);
    }
    rotationEvent = setTimeout(rotation,2000);
	function restoreBorder(){
		$('#rotation-item li').css({
            'border':'1px solid gold'
        });
	}





    //显示城市列表
    $('#location').click(function(){
        //var height = $(document).scrollTop();
        var height = $(this).offset().top - 50;
        $('.city_info').css({
            'top':height+'px'
        });
        $('.city_info').slideDown();
    });
    //隐藏城市列表
    $('.city_info>div img').click(function(){
        $('.city_info').slideUp();
    });
    $('.city_info>div img').hover(function(){

        $('.city_info>div img').attr('src','goods/img/close_yellow.png');
    },function(){
        $('.city_info>div img').attr('src','goods/img/close_grey.png');
    });

    //显示城市信息二级菜单
    var site = '{ "sites" : [' +
        '{ "name":"直辖市" , "city":"北京,重庆,天津,上海" },' +
        '{ "name":"河北" , "city":"承德,石家庄,唐山" },'+
        '{ "name":"山西" , "city":"太原,长治" } ]}' ;
    var citys =JSON.parse(site);
    var table = $("<table class='secondary_menu'>"+"</table>");
    var content;
    $('.city_info>table tr td').hover(function(e){

        $(this).append(table);

        var ld = $(this).index();//这个前面得到的是td的序号，从0开始，要得到第几行，+1即可
        var lh = $(this).parent().index();
        content = $(this).text();
        var sum = (lh+1)*(ld+1);
        if(sum > citys.sites.length){
            return false;
        }else if(content != citys.sites[sum-1].name ){
            return false;
        }

        var info = citys.sites[sum-1].city.split(",");

        var i;

        var row = $("<tr></tr>");
        table.append(row);
        for(i = 0 ; i < info.length ; i ++){
            //console.log(info[i]);
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

    //
    $('.city_info>table tr td').on('click','.secondary_menu tr td',function(){
        //console.log(11);
        console.log($(this).text());
        var city = $(this).text();
        table.empty().hide();
        $('.city_info').toggle('slow');
        if(content != '直辖市'){
            city =content + city;
        }
        $('#location>span').text(city);

    });
})