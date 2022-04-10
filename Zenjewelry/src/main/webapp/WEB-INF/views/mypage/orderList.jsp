<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
<!-- 방금 주문한 주문 목록만 보여주고, 같은 화면이 다시 나타나지 않습니다. 이후 해당내용은 주문내역에서 다른 주문과 함께 볼 수 있습니다 -->
<article style=width:1000px;>
<form style=width:1000px>
<table id="cartList" style="text:left">	
<h2> 결제정보 </h2>
<tr><th width="20%"> 최종결제금액 </th>
       	<td style="text-align:left;"><fmt:formatNumber value="${totalPrice}" type="currency"/></td></tr>
    <tr><th width="20%"> 결제수단 </th>
       	<td style="text-align:left;"> </td></tr>
 </table>
<div></div> 
<table id="cartList">  <!-- 동일한 css 적용을 위한 id사용 -->
       	<br>
    <h2> 주문 상품 정보 </h2>
	<tr><th>이미지</th><th colspan="2">상품 정보</th><th>판매가</th><th>수량</th><th>합계</th></tr>
	<c:forEach items="${orderList}" var="orderVO">
		<tr>
			<td ><a href="orderDetail?oseq=${orderVO.OSEQ}"><img src="product_images/${orderVO.IMAGE}" style="position:relative; width: 150px; height: 150px; object-fit: cover; text-align:left;"/></a></td>        
			<td colspan="2"><a href="orderDetail?oseq=${orderVO.OSEQ}" ><h3 style="center">${orderVO.PNAME}</h3></a>${orderVO.OPTION1} / ${orderVO.OPTION2} / ${orderVO.OPTION3}</td>
			<td>${orderVO.SELLPRICE}</td>
			<td> ${orderVO.QUANTITY}</td>
			
       		<td><fmt:formatNumber value="${orderVO.SELLPRICE*orderVO.QUANTITY}" type="currency"/></td>      
       		<%-- <td><fmt:formatDate value="${orderVO.INDATE}" type="date"/></td>
      		<td> 처리 진행 중 </td> --%></tr>
	</c:forEach>
	<tr><th colspan="2"> 합 계 </th>
       	<th colspan="2"><fmt:formatNumber value="${totalPrice}" type="currency"/></th>
       	<th colspan="2"> 주문 처리가 완료되었습니다. </th></tr> 	
</table>
<table id="cartList" style="text:left">	
<br>
<h2> 배송지 정보 </h2>

	<tr><th width="20%"> 수령인 </th>
       	<td style="text-align:left;">${orderList11.MNAME}</td></tr>	
    <tr><th width="20%"> 연락처 </th>
       	<td style="text-align:left;">${orderList11.PHONE}</td></tr>
    <tr><th width="20%"> 배송지 </th>
       	<td style="text-align:left;">${orderList11.ZIP_NUM} ${orderList11.ADDRESS} ${orderList11.ADDRESS2}</td></tr>	

</table>
	<div id="buttons" style="float: right">
       <input type="button" value="계속 쇼핑" class="cancel" onclick="location.href='/'">   
   </div>
   <div id="buttons" style="float: right">
       <input type="button" value="배송지 변경" class="cancel" onclick="location.href='deliveryForm?oseq=${param.oseq}'">
   </div>
  
</form>	
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>