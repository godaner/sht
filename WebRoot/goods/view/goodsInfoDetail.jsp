<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <script src="${baseUrl }/goods/js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="${baseUrl }/goods/js/goodsInfoDetail.js"></script>
    <link href="${baseUrl }/goods/css/goodsInfoDetail.css" rel="stylesheet">
</head>
<body>
<%@ include file="commonTitle.jsp"  %>

<article>
    <div class="head">
        <ul>
            <li>
                <img src="goods/img/content_icon.png"/>
                <a href="#">xxxxxxxx</a>
            </li>

            <li>
                <div class="dividing_line"></div>
            </li>
            <li class="browse">
                <span>宝贝浏览次数&nbsp;:&nbsp;80</span>
                <!--<br>-->
                <!--<span>80</span>-->
            </li>
            <li>
                <div class="dividing_line"></div>
            </li>
            <li class="edit">
                <span>最近编辑&nbsp;:&nbsp;2017-09-09</span>
                <!--<br>-->
                <!--<span>2017-09-09</span>-->
            </li>
            <li>

                <div class="dividing_line"></div>
            </li>
        </ul>
        <!--<a href="#">举报该宝贝</a>-->
    </div>

    <div class="content">
        <div class="content-left">
            <img src="goods/img/content.png"/>
            <ul id="rotation-item">
                <li><img src="goods/img/content_icon.png"></li>
                <li><img src="goods/img/rotation_icon.png"></li>
                <li><img src="goods/img/content_icon.png"></li>
                <li><img src="goods/img/rotation_icon.png"></li>
            </ul>
        </div>

        <div class="content-right">
            <p class="content-right-title">短裤短裤短裤短裤短裤</p>

            <p class="new-price">
                转卖价&nbsp;:&nbsp;￥<span>430.00</span>
                <span><img src="goods/img/tip.png">&nbsp;该商品拒绝讲价!</span>
            </p>

            <p class="old-price">原&nbsp;&nbsp;&nbsp;&nbsp;价&nbsp;:&nbsp;&nbsp;￥480.00</p>
            <hr/>
            <p class="state">成色&nbsp;:&nbsp;非全新</p>

            <p class="state">所在地&nbsp;:&nbsp;江苏南通</p>
            <span class="state">联系方式&nbsp;:&nbsp;</span><span id="link-way"><img
                src="goods/img/link.png"/>&nbsp;与他对话</span>
            <br/>

            <div id="pay-info">
                <span class="state" id="pay-way">交易方式&nbsp;:&nbsp;</span>

                <div class="state" id="online-pay">
                    <span>在线交易</span>
                    <span id="location">&nbsp;至&nbsp;<span>江苏南通</span>&nbsp;<img src="goods/img/down_grey.png"/>&nbsp;&nbsp;</span>
                </div>

                <span class="state" id="express">快递&nbsp;:&nbsp;￥&nbsp;8.00</span>

                <div class="clear"></div>
            </div>

            <input type="button" value="立&nbsp;即&nbsp;购&nbsp;买"/>
            <br/>
            <input type="button" value="分享(0)"/>
            <input type="button" value="赞(4)"/>

            <div class="city_info">
                <div>
                    <span>选择期望交易的城市</span>
                    <img src="goods/img/close_grey.png">
                </div>

                <table>
                    <tr>
                        <td>直辖市</td>
                        <td>河北</td>
                        <td>山西</td>
                        <td>内蒙古</td>
                        <td>辽宁</td>
                    </tr>
                    <tr>
                        <td>吉林</td>
                        <td>黑龙江</td>
                        <td>江苏</td>
                        <td>浙江</td>
                        <td>安徽</td>
                    </tr>
                    <tr>
                        <td>福建</td>
                        <td>江西</td>
                        <td>山东</td>
                        <td>河南</td>
                        <td>湖北</td>
                    </tr>
                    <tr>
                        <td>湖南</td>
                        <td>广东</td>
                        <td>广西</td>
                        <td>海南</td>
                        <td>四川</td>
                    </tr>
                    <tr>
                        <td>贵州</td>
                        <td>云南</td>
                        <td>西藏</td>
                        <td>陕西</td>
                        <td>甘肃</td>
                    </tr>
                    <tr>
                        <td>青海</td>
                        <td>宁夏</td>
                        <td>新疆</td>
                        <td>台湾</td>
                        <td>香港</td>
                    </tr>
                    <tr>
                        <td>澳门</td>
                        <td>海外</td>
                    </tr>
                </table>

            </div>
        </div>
        <div class="clear"></div>



        <div class="comment">
            <div class="comment-title">
                留&nbsp;言
            </div>
            <hr/>
            <div class="comment-content">
                <ul>
                    <li>
                        <img src="goods/img/content_icon.png"/>
                        <div>
                            <span>xxxxxxxxxx</span>
                            <!--<br/>-->
                            <span>2017-10-10 23:23:23</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>



        <div class="info">
            <p>二手交易消费者支付安全保障服务</p>
            <img src="goods/img/info.png"/>
        </div>


    </div>
</article>
<%@ include file="commonFooter.jsp"  %>
</body>
</html>