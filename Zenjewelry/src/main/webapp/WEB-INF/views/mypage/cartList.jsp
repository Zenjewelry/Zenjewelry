<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
<article style=width:1000px;>
<h2> 장바구니 </h2>
<form name="formm" method="post" action="orderInsert">
	<c:choose>
		<c:when test="${cartList.size() == 0}">
			<h3 style="color: red;text-align: center;">장바구니가 비었습니다.</h3> 
		</c:when>
		<c:otherwise>
			<table id="cartList" style=width:1000px>
				<tr><th>선 택</th><th colspan=2>제 품</th><th>수 량</th><th>가 격</th></tr>
					<c:forEach items="${cartList}" var="cartVO">
						<tr><td><input type="checkbox" name="cseq" value="${cartVO.CSEQ}"></td>
						<td><a href="productDetail?pseq=${cartVO.PSEQ}" target="_blank" >
						<img src="product_images/${cartVO.IMAGE}" style="position:relative; width: 150px; height: 150px; object-fit: cover; text-align:left;"/>
						</a></td>
						<td><a href="productDetail?pseq=${cartVO.PSEQ}" target="_blank" >
							<h3> ${cartVO.PNAME} </h3></a></td><td> ${cartVO.QUANTITY} </td>
						<td><fmt:formatNumber value="${cartVO.SELLPRICE}"	type="currency"/></td>
					
						</tr>
					</c:forEach>
				<tr><th width="20%"> 총 액 </th><td colspan="2">
       				<fmt:formatNumber value="${totalPrice}" type="currency" /></td>
       				<td style=font-size:20px;font-weight:bold;><a href="#" onClick="go_cart_delete();">삭제하기</a></td></tr> 
			</table>
		</c:otherwise>
	</c:choose>
<div id="buttons" style="float: right">
    <input type="button" value="계속 쇼핑" class="cancel" onclick="location.href='/'">    
    <c:if test= "${cartList.size() != 0}">
   		<input type="submit" value="주문하기"  class="submit">
    </c:if>
</div>
</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>