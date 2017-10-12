<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="./base.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<jsp:include page="commonTitle.jsp" flush="false" />
<input type="hidden" value="${baseUrl}" id="baseUrl" />
<input type="hidden" value="${sessionScope.goodsDetailInfo.id}" id="goodsId" />
<input type="hidden" value="${sessionScope.goodsDetailInfo.msgNum}" id="msgnum" />
<input type="hidden" value="${sessionScope.goodsDetailInfo.userId}" id="userid" />

<article>
    <div class="head">
        <ul>
            <li>
            	<c:if test="${empty sessionScope.goodsDetailInfo.headImg  }">
            		<img src="goods/img/default_icon.png"/>
            	</c:if>
            	
                <c:if test="${not empty sessionScope.goodsDetailInfo.headImg}">

            		<img style="border-radius:50%;" src="${baseUrl }/common/users_getUsersHeadImg.action?size=30&headimg=${sessionScope.goodsDetailInfo.headImg}"/>

            	</c:if>
                <a href="#">${sessionScope.goodsDetailInfo.username }</a>
            </li>

            <li>
                <div class="dividing_line"></div>
            </li>
            <li class="browse">
           
       		 <fmt:formatNumber var="c" value="${sessionScope.goodsDetailInfo.browsenumber}" pattern="#"/>
                <span>宝贝浏览次数&nbsp;:&nbsp;${c }</span>
            
                <!--<br>-->
                <!--<span>80</span>-->
            </li>
            <li>
                <div class="dividing_line"></div>
            </li>
            <li class="edit">
            	
                <span>最近编辑&nbsp;:&nbsp;<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${sessionScope.goodsDetailInfo.lastupdatetime}" /></span>
                <!--<br>-->
                <!--<span>2017-09-09</span>-->
            </li>
            <li>

                <div class="dividing_line"></div>
            </li>
        </ul>

    </div>
	<script src="${baseUrl }/goods/plugin/js/jquery-2.1.0.min.js"></script>
	<script src="${baseUrl }/goods/plugin/js/jquery.swipebox.min.js"></script>
    <div class="content">
        <div class="content-left">
       
            	<img src="${baseUrl }/common/goods_getGoodsImg.action?size=30&imgName=${sessionScope.goodsDetailInfo.path}"/>

            <ul id="rotation-item">
            
            </ul>
        </div>
		
        <div class="content-right">
        	<p class="content-right-title">${sessionScope.goodsDetailInfo.title}</p>
            <p class="content-right-description" title="${sessionScope.goodsDetailInfo.description}">${sessionScope.goodsDetailInfo.description}</p>

            <p class="new-price">
                转卖价&nbsp;:&nbsp;￥<span id="price" name="${sessionScope.goodsDetailInfo.sprice }">${sessionScope.goodsDetailInfo.sprice }</span>
                <span><img src="goods/img/tip.png">&nbsp;该商品拒绝讲价!</span>
            </p>

            <p class="old-price">原&nbsp;&nbsp;&nbsp;&nbsp;价&nbsp;:&nbsp;&nbsp;￥${sessionScope.goodsDetailInfo.price}</p>
            
            <p class="old-price">类&nbsp;&nbsp;&nbsp;&nbsp;型&nbsp;:&nbsp;&nbsp;${sessionScope.goodsDetailInfo.clazz}</p>
            
            <hr/>
            <p class="state">成色&nbsp;:&nbsp;${sessionScope.goodsDetailInfo.condition}成新</p>

            <p class="state">所在地&nbsp;:&nbsp;${sessionScope.goodsDetailInfo.addr}</p>
         

            <div id="pay-info">
                <span class="state" id="pay-way">交易方式&nbsp;:&nbsp;</span>
				
                <div class="state" id="online-pay">
                    
                    
               		<span id="location"></span>
               		<select name="addr" id="addr">
               			<option value="0">--请选择--</option>
               		</select>

               		<a href="javascript:judgmentLogins();">详情&nbsp;/&nbsp;修改</a>

                </div>
                <div class="clear"></div>
            </div>
			<c:if test="${sessionScope.goodsDetailInfo.status  == '0'}">
            	<input type="button" value="立&nbsp;即&nbsp;购&nbsp;买" id="buy"/>
            </c:if>
            <br/>
           
        </div>
        <div class="clear"></div>



        <div class="comment">
            <div class="comment-title">
                留&nbsp;言
            </div>
            <hr/>
            <div class="comment-content">
            	
            		
            	
                <ul class="comment-container">
                    <c:if test="${sessionScope.goodsDetailInfo.msgNum == 0}">
            			该商品暂时无人评价!
            		</c:if>
            		
                </ul>
               
                <br/>
                <br/>
                <br/>
                <p>欢迎填写评价：</p><!-- <sapn class="reply"></sapn> -->
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