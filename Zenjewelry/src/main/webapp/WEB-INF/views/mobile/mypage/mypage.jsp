<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
<p style="font-size:28px;"><b>${title}</b></p>
<form>
<table  id="cartList" style="text-align:left; border-spacing: 15px;">
	<tr></tr>
    <c:forEach items="${orderList}"  var="orderVO">
    <tr style="margin-top: 100px">
    	<td><a href="morderDetail?oseq=${orderVO.OSEQ}"><img src="product_images/${orderVO.IMAGE}" style="position:relative; width: 230px; height: 230px; object-fit: cover; margin:20px auto;"/></a>
    	<td style="width:1000px; text-align:left;">
    		<a href="morderDetail?oseq=${orderVO.OSEQ}"><p style="font-size:28px;">&nbsp;&nbsp;&nbsp;&nbsp;<b>${orderVO.PNAME}</b></p></a>
    		<p style="font-size:28px;"><b>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatNumber value="${orderVO.SELLPRICE}" type="currency" /></b></p ><p style="font-size:25px; text-align:left;;">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${orderVO.INDATE}" type="date"/><br/></p>
    	<c:if test="${orderVO.RESULT=='1'}"><p style="font-size:25px;">&nbsp;&nbsp;&nbsp;&nbsp;배송준비 중</p><br/></c:if>
		<c:if test="${orderVO.RESULT=='2'}"><p style="font-size:25px;">&nbsp;&nbsp;&nbsp;&nbsp;배송 완료</p><br/></c:if>
    	</td>	
		</tr>
	
    </c:forEach>  
</table><div class="clear"></div>
<div id="buttons" style="float:left">
   <input type="button"  value="총 주문 내역"  class="cancel" onclick="location.href='/morderAll'"></div>
<div id="buttons" style="float:left">
   <input type="button"  value="뒤로가기"  class="cancel" onclick="history.go(-1)'"></div>
<div id="buttons" style="float:right">
	<input type="button"  value="쇼핑 계속하기"  class="cancel" onclick="location.href='/'"></div>

</form>
</article>


<%@ include file="../include/footer.jsp" %>