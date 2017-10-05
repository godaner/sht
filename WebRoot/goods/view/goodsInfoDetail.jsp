<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <script type="text/javascript" src="${baseUrl}/goods/js/jquery-1.11.3.js"></script>
    <script src="${baseUrl }/goods/js/goodsInfoDetail.js"></script>
    <link href="${baseUrl }/goods/css/goodsInfoDetail.css" rel="stylesheet">
</head>
<body>
<%@ include file="commonTitle.jsp"  %>
<input type="hidden" value="${baseUrl}" id="baseUrl" />
<input type="hidden" value="${sessionScope.goodsDetailInfo.id}" id="goodsId" />
<input type="hidden" value="${sessionScope.goodsDetailInfo.msgNum}" id="msgnum" />
<input type="hidden" value="${sessionScope.onlineUser.id} " id="onlineUser"/>
<article>
    <div class="head">
        <ul>
            <li>
            	<c:if test="${empty sessionScope.goodsDetailInfo.headImg  }">
            		<img src="goods/img/default_icon.png"/>
            	</c:if>
            	
                <c:if test="${not empty sessionScope.goodsDetailInfo.headImg}">
            		<img src="${baseUrl }/common/goods_getGoodsImg.action?size=200&imgName=${sessionScope.goodsDetailInfo.headImg}"/>
            	</c:if>
                <a href="#">${sessionScope.goodsDetailInfo.title }</a>
            </li>

            <li>
                <div class="dividing_line"></div>
            </li>
            <li class="browse">
                <span>宝贝浏览次数&nbsp;:&nbsp;${sessionScope.goodsDetailInfo.browsenumber }</span>
                <!--<br>-->
                <!--<span>80</span>-->
            </li>
            <li>
                <div class="dividing_line"></div>
            </li>
            <li class="edit">
                <span>最近编辑&nbsp;:&nbsp;${sessionScope.goodsDetailInfo.lastupdatetime}</span>
                <!--<br>-->
                <!--<span>2017-09-09</span>-->
            </li>
            <li>

                <div class="dividing_line"></div>
            </li>
        </ul>

    </div>

    <div class="content">
        <div class="content-left">
        	
            <img src="${baseUrl }/common/goods_getGoodsImg.action?size=200&imgName=${sessionScope.goodsDetailInfo.path}"/>
            <ul id="rotation-item">
            
            </ul>
        </div>

        <div class="content-right">
            <p class="content-right-title">${sessionScope.goodsDetailInfo.description}</p>

            <p class="new-price">
                转卖价&nbsp;:&nbsp;￥<span>${sessionScope.goodsDetailInfo.sprice }</span>
                <span><img src="goods/img/tip.png">&nbsp;该商品拒绝讲价!</span>
            </p>

            <p class="old-price">原&nbsp;&nbsp;&nbsp;&nbsp;价&nbsp;:&nbsp;&nbsp;￥${sessionScope.goodsDetailInfo.price}</p>
            <hr/>
            <p class="state">成色&nbsp;:&nbsp;${sessionScope.goodsDetailInfo.condition}成新</p>

            <p class="state">所在地&nbsp;:&nbsp;${sessionScope.goodsDetailInfo.addr}</p>
            <span class="state">联系方式&nbsp;:&nbsp;</span><span id="link-way"><img
                src="goods/img/link.png"/>&nbsp;与他对话</span>
            <br/>

            <div id="pay-info">
                <span class="state" id="pay-way">交易方式&nbsp;:&nbsp;</span>

                <div class="state" id="online-pay">
                    <span>在线交易</span>
                    <span id="location">&nbsp;至&nbsp;<span>江苏南通</span>&nbsp;<img src="goods/img/down_grey.png"/>&nbsp;&nbsp;</span>
                </div>

                <span class="state" id="express"><span>江苏南通</span>&nbsp;<img src="goods/img/down_grey.png"/>&nbsp;&nbsp;</span>
				<table id="county"></table>
                <div class="clear"></div>
            </div>

            <input type="button" value="立&nbsp;即&nbsp;购&nbsp;买"/>
            <br/>
            <!-- <input type="button" value="分享(0)"/>
            <input type="button" value="赞(4)"/> -->

            <div class="city_info">
                <div>
                    <span>选择期望交易的城市</span>
                    <img src="goods/img/close_grey.png">
                </div>

                <table>
                    
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
            	<c:if test="${sessionScope.goodsDetailInfo.msgNum == 0}">
            		该商品暂时无人评价!
            	</c:if>
            	<c:if test="${sessionScope.goodsDetailInfo.msgNum != 0}">
            		
            	
                <ul class="comment-container">
                    
                </ul>
                </c:if>
                <br/>
                <br/>
                <br/>
                <p>欢迎填写评价：</p><sapn class="reply"></sapn>
                <br/>
                <textarea rows="3" cols="100" placeholder="请填写..." id="comment-content"></textarea>
                <br>
                <input type="button" id="submit" value="提交评论" class="submit"/>
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