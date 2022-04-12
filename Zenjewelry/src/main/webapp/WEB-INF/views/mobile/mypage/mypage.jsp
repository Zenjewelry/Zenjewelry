<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
<h2>${title}</h2>
<form>
<table  id="cartList">
	<tr></tr>
    <c:forEach items="${orderList}"  var="orderVO">
    <tr style="margin-top: 100px">
    	<td style="margin:30px auto"><img src="product_images/${orderVO.IMAGE}" style="position:relative; width: 200px; height: 200px; object-fit: cover;"/>
    	<td style="width:1000px; margin-left:50px"><a href="morderDetail?oseq=${orderVO.OSEQ}"><h3>${orderVO.PNAME}</h3></a>
    	<td style=width:700px><fmt:formatNumber value="${orderVO.SELLPRICE}" type="currency" /></td>
    	<td style=width:700px><fmt:formatDate value="${orderVO.INDATE}" type="date"/></td>
    	
        <%-- 	<td>${orderVO.OSEQ} </td> --%>
			<td style="width:400px;">
				<c:if test="${orderVO.RESULT=='1'}">배송준비 중</c:if>
				<c:if test="${orderVO.RESULT=='2'}">배송 완료</c:if>
				</td>
		</tr>
		
		<tr></tr>
	
    </c:forEach>  
</table><div class="clear"></div>
<div id="buttons" style="float:left">
   <input type="button"  value="총 주문 내역"  class="cancel" onclick="location.href='/orderAll'"></div>
<div id="buttons" style="float:left">
   <input type="button"  value="뒤로가기"  class="cancel" onclick="history.go(-1)'"></div>
<div id="buttons" style="float:right">
	<input type="button"  value="쇼핑 계속하기"  class="cancel" onclick="location.href='/'"></div>

</form>
</article>


<%@ include file="../include/footer.jsp" %>