<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>


<article>


<form name="cartList" method="post">

<center><h1> 주문상세 </h1></center> 
<br>


<table id="cartList2">

</table>
<table id="cartList2">	
	<tr><th>주문자<th>상품명</th><th>주문수량</th><th>상품가격</th><th>주문일자</th><th>배송주소</th></tr>
	<c:forEach items="${orderList}" var="orderVO">
		<tr>
			<input  type="hidden" name="oseq" value="${orderVO.OSEQ}">
			<td>${id}</td>
			<td>${orderVO.PNAME}</td>
			<td>${orderVO.QUANTITY}</td>
       		<td><fmt:formatNumber value="${orderVO.PRICE2*orderVO.QUANTITY}" type="currency"/></td>  
       		<td><fmt:formatDate value="${orderVO.INDATE}" type="date"/></td>
       		<td>${ZIP_NUM}${ADDRESS}</td>
       	</tr>
	</c:forEach>
	
</table>
<table id="cartList2">	
	<tr><th width="20%"> 총 액 </th>
       	<td><fmt:formatNumber value="${totalPrice}" type="currency"/></td></tr>	
</table>


<table id="cartList3">
<tr>
	<td>	
  	  <input type="button" value="마이 페이지" class="cancel" onclick="myPage'">   
  	  <input type="button" value="계속 쇼핑" class="cancel" onclick="location.href='/'">   
   	  <input type="button" value="배송지 변경" class="cancel" onclick="deliveryForm&oseq=${oseq}'">
	  <input type="button"  value="주문 취소하기"  class="cancel" onclick="delete_order()">
   	</td>
</tr>
</table>
 

</form>	
</article>



<%@ include file="../include/headerfooter/footer.jsp" %>