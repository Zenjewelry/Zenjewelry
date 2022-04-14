<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
<h2> Item&nbsp;&nbsp;</h2><hr>
<input style=float:left type="button" value="전체상품보기" onClick="location.href='/mproductAll'" />
<a href="mkindUpList?kind=${kind}&sub='y'">높은가격순&nbsp;&nbsp;</a>
<div style="float: right; margin-right:20px;">
<c:choose>
	<c:when test="${not empty kind || not empty kindUpList || not empty kindDownList}">
		<a href="mkindUpList?kind=${kind}&sub='y'">높은가격순&nbsp;&nbsp;</a>
		<a href="mkindDownList?kind=${kind}&sub='y'">낮은가격순</a>
	</c:when>
	<c:when test="${not empty best || not empty bestUpList || not empty bestDownList}">
		<a href="mbestUpList?sub='y'">높은가격순&nbsp;&nbsp;</a>
		<a href="mbestDownList?sub='y'">낮은가격순</a>
	</c:when>
	<c:when test="${not empty all || not empty allUpList || not empty allDownList}">
		<a href="mallUpList?sub='y'">높은가격순&nbsp;&nbsp;</a>
		<a href="mallDownList?sub='y'">낮은가격순</a>
	</c:when>
</c:choose>
</div>
<br><br>
<div style="margin-top:30px; margin-left:100px;">
<c:forEach items="${productList}"  var="productVO" >
	<div id="item"  style="position:relative; width: 350px; height: 400px; margin:32px auto;">
		<a href="mproductDetail?pseq=${productVO.PSEQ}">
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
	<c:when test="${not empty kindUpList}">
		<jsp:include page="../include/pagingForProduct.jsp">
			<jsp:param name="command" value="mkindUpList?kind=${kind}" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty kindDownList}">
		<jsp:include page="../include/pagingForProduct.jsp">
			<jsp:param name="command" value="mkindDownList?kind=${kind}" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty kind}">
		<jsp:include page="../include/pagingForProduct.jsp">
			<jsp:param name="command" value="mproductList?kind=${kind}" />
		</jsp:include>
	</c:when>
	
	<c:when test="${not empty best}">
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mbestProductList" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty bestUpList}">
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mbestUpList" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty bestDownList}">
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mbestDownList" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty allUpList}">
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mallUpList" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty allDownList}">
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mallDownList" />
		</jsp:include>
	</c:when>
	<c:when test="${not empty all}">
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mproductAll" />
		</jsp:include>
	</c:when>
	<c:otherwise>
		<jsp:include page="../include/paging.jsp">
			<jsp:param name="command" value="mProductList" />
		</jsp:include>
	</c:otherwise>
</c:choose>

</article>

<%@ include file="../include/footer.jsp" %>