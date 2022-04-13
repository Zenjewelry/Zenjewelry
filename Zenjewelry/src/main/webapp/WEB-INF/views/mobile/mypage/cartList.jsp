<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<article>
<h2 style="text-align:center"> 장바구니 </h2>
<form name="formm" method="post" action="morderInsert">
	<c:choose>
		<c:when test="${cartList.size() == 0}">
			<h3 style="color: red;text-align: center;">장바구니가 비었습니다.</h3> 
		</c:when>
		<c:otherwise>
			<table id="cartList" style="margin-right:auto; margin-left:auto; table-layout:fixed;" >
					<c:forEach items="${cartList}" var="cartVO">
						<tr><td width="120px"><input type="checkbox" name="cseq" value="${cartVO.CSEQ}" style="width:30px; height:30px;"></td>
						<td width="300px"><a href="mproductDetail?pseq=${cartVO.PSEQ}" target="_blank" >
						<img src="product_images/${cartVO.IMAGE}" style="position:relative; width: 300px; height: 300px; object-fit: cover; margin:10px auto;"/>
						</a></td>
						<td colspan="2"><a href="productDetail?pseq=${cartVO.PSEQ}" target="_blank" >
							<p style="font-size:25px;"> <b>${cartVO.PNAME}</b> </p>
							<p style="font-size:25px;">[옵션 : ${cartVO.OPTION1} / ${cartVO.OPTION2} / ${cartVO.OPTION3}]</p></a>
							<p style="text:bold; font-size:20px;"><b><fmt:formatNumber value="${cartVO.SELLPRICE}"	type="currency"/></b></p>
							<p style="font-size:20px;">수량 : [${cartVO.QUANTITY}] <p>	
						</td>
					
					
						</tr>
					</c:forEach>
				<tr><th width="20%"> 총 액 </th><td colspan="2">
       				<B style="font-size:25px;"><fmt:formatNumber value="${totalPrice}" type="currency" /></B></td>
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

<%@ include file="../include/footer.jsp" %>