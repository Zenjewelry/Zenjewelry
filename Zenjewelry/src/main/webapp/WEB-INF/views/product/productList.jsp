<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article style="width: 1600px;">
<h2> Item&nbsp;&nbsp;</h2>
<input style=float:left type="button" value="전체상품보기" onClick="productList'" />
<br><br>
<div style="margin-left:100px;">
<c:forEach items="${productList}"  var="productVO" >
	<div id="item"  style="position:relative; width: 350px; height: 400px; margin:32px auto;">
		<a href="productDetail?pseq=${productVO.PSEQ}">
			<img src="product_images/${productVO.IMAGE}" />
			<h3>${productVO.NAME} </h3>        
			<p><fmt:formatNumber value="${productVO.PRICE2}" type="currency"/></p>
		</a>
   	</div>
</c:forEach>
</div>
<div class="clear"></div>
<br/><br/><br/><br/><br/><br/>
<c:choose>
	<c:when test="${not empty kind}">
		<jsp:include page="../include/page/pagingForProduct.jsp">
			<jsp:param name="command" value="productList?kind=${kind}" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty best}">
		<jsp:include page="../include/page/paging.jsp">
			<jsp:param name="command" value="bestProductList" />
		</jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="../include/page/paging.jsp">
			<jsp:param name="command" value="productList" />
		</jsp:include>
	</c:otherwise>
</c:choose>

</article>

<%@ include file="../include/headerfooter/footer.jsp" %>