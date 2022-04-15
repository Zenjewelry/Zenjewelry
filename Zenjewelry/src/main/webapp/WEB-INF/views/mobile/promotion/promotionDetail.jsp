<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script type="text/javascript">
window.onload = function(){
	var size = 980 * 0.8;
	// promotion
	var cnt = document.getElementsByClassName('boxSize').length;

	for(var i=1; i<=cnt; i++){
		var leng = Math.ceil(document.getElementsByClassName('itemboxs' + i).length / 2);
		document.getElementById('boxSize' + i).style.height = (477 * leng) + 'px';
	}
	for(var i=1; i<=cnt; i++){
		var cnt2 = document.getElementsByClassName('itemboxs' + i).length;
		for(var j=0; j<cnt2; j++){
			document.getElementsByClassName('itemboxs' + i)[j].style.width = (size * 0.46) + 'px';
			document.getElementsByClassName('itemboxs' + i)[j].style.margin = '0px ' + (size * 0.02) + 'px';
			document.getElementsByClassName('pimgtest' + i)[j].setAttribute('width', (size * 0.46) + 'px');
			document.getElementsByClassName('pimgtest' + i)[j].setAttribute('height', (size * 0.46) + 'px');
		}
	}
}
</script>

<article style="width:100%; margin:0; padding:0;">
<form name="frm" action="updatePromotion" method="post" style="width:100%;">
	<img src="/promotion_images/${promotionView.BANNER}" id="previewbannerImg" style="width:100%;" />
	<!-- 구분자 섹션 -->
	<c:forEach items="${summary}" var="summary" varStatus="outnum">
		<div style="width:100%; height:300px; background-color:#e9e5da; text-align:center;">
			<img src="/promotion_images/${summary.SUMMARY}" style="height:300px; margin:0 auto;" />
		</div>
			<!-- 구분자별 상품 -->
		<div style="width:100%; margin:0 auto;" class="boxSize" id="boxSize${outnum.count}" style="margin:0 auto;">
			<div style="width:80%; margin:0 auto;">
				<c:forEach items="${promotionProductList}" var="pp">
					<c:if test="${pp.OUTNUMBER == outnum.count}">
						<a href="productDetail?pseq=${pp.PSEQ}&prmprice=${pp.PRMPRICE}">
							<div id="promotionitems${outnum.count}" class="itemboxs${outnum.count}" style="float:left">
								<img src="product_images/${pp.IMAGE}" class="pimgtest${outnum.count}">
								<div class="listText">${pp.NAME}</div>
								<div class="listText2"><fmt:formatNumber value="${pp.PRMPRICE}" type="currency"/></div>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</c:forEach>
</form>
</article>

<%@ include file="../include/footer.jsp" %>