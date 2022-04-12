<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
<form name="frm" action="updatePromotion" method="post">
	<img src="/promotion_images/${promotionView.BANNER}" id="previewbannerImg" width="1920" height="810" />
	<!-- 구분자 섹션 -->
	<c:forEach items="${summary}" var="summary" varStatus="outnum">
		<div style="width:100%; height:200px; background-color:#e9e5da;">
			<img src="/promotion_images/${summary.SUMMARY}" />
		</div>
			<!-- 구분자별 상품 -->
		<div>
			<c:forEach items="${promotionProductList}" var="pp">
				<c:if test="${pp.OUTNUMBER == outnum.count}">
					<a href="productDetail?pseq=${pp.PSEQ}&prmprice=${pp.PRMPRICE}">
						<div id="items">
							<img src="product_images/${pp.IMAGE}" id="imgtest"/>
							<div class="listText">${pp.NAME}</div>
							<div class="listText1">${pp.CONTENT}</div><br>
							<div class="listText2"><fmt:formatNumber value="${pp.PRMPRICE}" type="currency"/></div>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>
		<hr />
	</c:forEach>
</form>

</article>

<%@ include file="../include/footer.jsp" %>