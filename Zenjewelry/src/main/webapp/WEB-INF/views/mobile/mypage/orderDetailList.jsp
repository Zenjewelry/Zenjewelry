<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<article>
<form name="cartList1" method="post">
<h2 style="text-align:left"> 주문 상세정보 / <fmt:formatDate value="${orderDetail.INDATE}" type="date"/></h2>

<br>


<table id="cartList">	
	<tr><th colspan="2">상품 정보</th><th>상품금액</th><th>주문금액</th></tr>
	<c:forEach items="${orderList}" var="orderVO">
		<tr>
			<input  type="hidden" name="oseq" value="${orderVO.OSEQ}">
			<td ><a href="productDetail?pseq=${orderVO.PSEQ}"><img src="product_images/${orderVO.IMAGE}" style="position:relative; width: 150px; height: 150px; object-fit: cover; text-align:left;"/></a></td>        
			<td><a href="productDetail?pseq=${orderVO.PSEQ}" ><h3 style="center">${orderVO.PNAME}</h3></a>${orderVO.OPTION1} / ${orderVO.OPTION2} / ${orderVO.OPTION3}</td>
			
			<td><fmt:formatNumber value="${orderVO.SELLPRICE / orderVO.QUANTITY}" type="currency"/>( ${orderVO.QUANTITY}건 )</td>
       		<td><fmt:formatNumber value="${orderVO.SELLPRICE}" type="currency"/></td>  
       		<%-- ${orderVO.ZIP_NUM}   ${orderVO.ADDRESS}
       		${orderVO.ADDRESS2} --%>
       	</tr>
	</c:forEach>
	
</table>
<table id="cartList">	
	<tr><th width="20%"> 총 액 </th>
       	<td><fmt:formatNumber value="${totalPrice}" type="currency"/></td></tr>	
</table>

<br>

<table id="cartList" style="text:left">	

<h2> 배송지 정보 </h2>

	<tr><th width="20%"> 수령인 </th>
       	<td style="text-align:left;">${orderDetail.MNAME}</td></tr>	
    <tr><th width="20%"> 연락처 </th>
       	<td style="text-align:left;">${orderDetail.PHONE}</td></tr>
    <tr><th width="20%"> 배송지 </th>
       	<td style="text-align:left;">${orderDetail.zip_num} ${orderDetail.ADDRESS} ${orderDetail.ADDRESS2}</td></tr>	

</table>
<br>
<table id="cartList3">
<tr>
	<td>	
  	  <input type="button" value="마이 페이지" class="cancel" onclick="history.go(-1)">   
  	  <input type="button" value="계속 쇼핑" class="cancel" onclick="location.href='/'">  
  	  <c:if test="${orderDetail.RESULT == 1}">
		<input type="button" value="배송지 변경" class="cancel" onclick="location.href='deliveryForm?oseq=${param.oseq}'">
	</c:if> 
   	  
	<c:if test="${orderDetail.RESULT == 1}">
		<input type="button"  value="주문 취소하기"  class="cancel" onclick="delete_order(${orderDetail.OSEQ});">
	</c:if>
   	</td>
</tr>
</table>

</form>	
</article>


<%@ include file="../include/footer.jsp" %>