<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article style="width:100%; margin:0; padding:0;">
<form name="frm" action="updatePromotion" method="post" style="width:100%;">
	<img src="/promotion_images/${promotionView.BANNER}" id="previewbannerImg" width="1920" height="810" />
	<!-- 구분자 섹션 -->
	<c:forEach items="${summary}" var="summary" varStatus="outnum">
		<div style="width:100%; height:300px; background-color:#e9e5da; text-align:center;">
			<img src="/promotion_images/${summary.SUMMARY}" style="height:300px; margin:0 auto;" />
		</div>
			<!-- 구분자별 상품 -->
		<div style="width:1280px; height:570px; margin:0 auto;">
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
	</c:forEach>
</form>

</article>

<%@ include file="../include/headerfooter/footer.jsp" %>