/**
 * Created by tom on 2017/9/20.
 */


$(function(){

    //闲置
    $('.idle').hover(function(){
        
        $('.idle>img').attr('src','goods/img/up_black.png');
        $('.idle_down').show();
    },function(){
        $('.idle>img').attr('src','goods/img/down_black.png');
        $('.idle_down').hide();
    });
})