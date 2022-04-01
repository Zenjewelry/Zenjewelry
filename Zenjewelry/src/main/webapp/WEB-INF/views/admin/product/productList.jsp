<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>


<article>

<h1>상품 리스트</h1><br>

<form name="frm" method="post">
		
<table id="cartList2">
		<tr><th>번호</th><th>상품명</th><th>원가</th><th>판매가</th><th>등록일</th><th>신상유무</th><th>베스트상품</th></tr>
		<c:forEach items="${productList}" var="productVO">
			<tr><td height="23" align="center" >${productVO.PSEQ}</td>
				<td>
					<a href="#" onClick="go_detail('${productVO.PSEQ}')">${productVO.NAME}</a></td>
				<td><fmt:formatNumber value="${productVO.PRICE1}"/></td>
				<td><fmt:formatNumber value="${productVO.PRICE2}"/></td>
				<td><fmt:formatDate value="${productVO.INDATE}"/></td>
				<td><c:choose>
	      				<c:when test='${productVO.NEWYN=="n"}'>신상x</c:when>
	   	 				<c:otherwise>신상품</c:otherwise> 
					</c:choose></td>
				<td><c:choose>
	      				<c:when test='${productVO.BESTYN=="n"}'>베스트x</c:when>
	   	 				<c:otherwise>베스트상품</c:otherwise> 
					</c:choose></td></tr>
		</c:forEach>
</table>

		<table id="cartList2">
			<tr><td width="670">상품명<input type="text" name="key" value="${key}">
				<input class="btn" type="button" name="btn_search" value="검색" onClick="go_search()">
				<input class="btn" type="button" name="btn_total" value="전체보기 " onClick="go_total()">
				<input class="btn" type="button" name="btn_write" value="상품등록"  onClick="go_wrt()"></td>
			</tr>
		</table>	

</form>
<br>

<jsp:include page="../../include/page/pagingForProduct.jsp">
	<jsp:param name="command" value="adminproductList" />	
</jsp:include>
<!-- include 로  paging.jsp 를 불러오면서 그페이지안에  command  값을 파라미터로 전송해줍니다 -->
<br /><br />
	

</article>

<%@ include file="../../include/adminheaderfooter/footer.jsp" %>







