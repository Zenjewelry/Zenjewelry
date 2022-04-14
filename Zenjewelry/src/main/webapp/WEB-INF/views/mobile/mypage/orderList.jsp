<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<!-- 방금 주문한 주문 목록만 보여주고, 같은 화면이 다시 나타나지 않습니다. 이후 해당내용은 주문내역에서 다른 주문과 함께 볼 수 있습니다 -->
<article>
<form>
<table id="cartList">	
<h2 style="text-align:left"> 결제정보 </h2>
<tr><th width="20%" style="font-size:25px;"> 최종결제금액 </th>
       	<td style="text-align:left; font-size:25px;">&nbsp;&nbsp;<fmt:formatNumber value="${totalPrice}" type="currency"/></td></tr>
 </table>
<div></div> 
<table id="cartList">  <!-- 동일한 css 적용을 위한 id사용 -->
       	<br>
    <h2 style="text-align:left"> 주문 상품 정보 </h2>

	<c:forEach items="${orderList}" var="orderVO">
		<tr>
			<td><a href="morderDetail?oseq=${orderVO.OSEQ}"><img src="product_images/${orderVO.IMAGE}" style="position:relative; width: 230px; height: 230px; object-fit: cover; text-align:left; margin:0px auto;"/></a></td>        
			<td  style="text-align:left; font-size:25px"><a href="morderDetail?oseq=${orderVO.OSEQ}" ><p style="font-size:28px"><b>${orderVO.PNAME}</b></p></a><p>${orderVO.OPTION1} / ${orderVO.OPTION2} / ${orderVO.OPTION3}</p>
			<fmt:formatNumber value="${orderVO.SELLPRICE / orderVO.QUANTITY}" type="currency"/>&nbsp;원&nbsp;|&nbsp;${orderVO.QUANTITY}&nbsp;개</td>
			
       		<td style="font-size:25px"><b><fmt:formatNumber value="${orderVO.SELLPRICE}" type="currency"/></b></td>      
       		<%-- <td><fmt:formatDate value="${orderVO.INDATE}" type="date"/></td>
      		<td> 처리 진행 중 </td> --%></tr>
	</c:forEach>
	<tr><th> 합 계 </th>
       	<th><p style="font-size:25px;"><fmt:formatNumber value="${totalPrice}" type="currency"/></p></th>
       	<th> 주문 처리가 완료되었습니다. </th></tr> 	
</table>
<table id="cartList" style="text:left">	
<br>
<h2 style="text-align:left"> 배송지 정보 </h2>

	<tr><th width="20%"> 수령인 </th>
       	<td style="text-align:left;"><p style="font-size:25px;">&nbsp;&nbsp;${orderList11.MNAME}</p></td></tr>	
    <tr><th width="20%"> 연락처 </th>
       	<td style="text-align:left;"><p style="font-size:25px;">&nbsp;&nbsp;${orderList11.PHONE}</p></td></tr>
    <tr><th width="20%"> 배송지 </th>
       	<td style="text-align:left;"><p style="font-size:25px;">&nbsp;&nbsp;${orderList11.ZIP_NUM} ${orderList11.ADDRESS} ${orderList11.ADDRESS2}</p></td></tr>	

</table>
	<div id="buttons" style="float: right">
       <input type="button" value="계속 쇼핑" class="cancel" onclick="location.href='/'">   
   </div>
   <div id="buttons" style="float: right">
       <input type="button" value="배송지 변경" class="cancel" onclick="location.href='mdeliveryForm?oseq=${param.oseq}'">
   </div>
  
</form>	
</article>

<%@ include file="../include/footer.jsp" %>