<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

<script type="text/javascript">
window.onload = function(){
	
	// promotion
	var size = top.window.innerWidth * 0.8;
	var pmls = parseInt(document.getElementById('pmls').value);
	
	document.getElementById('prmbox').style.width = top.window.innerWidth + 'px';
	document.getElementById('prmbox').style.height = (size / 2.37) + 'px';
	document.getElementById('prmct').style.width = ((size) + (((size / 2.37) / 5.875)*2)) + 'px';
	document.getElementById('prmct').style.height = (size / 2.37) + 'px';
	document.getElementById('mainPromotionView').style.width = (size) + 'px';
	document.getElementById('mainPromotionView').style.height = (size / 2.37) + 'px';
	
	document.getElementById('prevPromotion').style.width = ((size / 2.37) / 5.875) + 'px';
	document.getElementById('prevPromotion').style.height = (size / 2.37) + 'px';
	document.getElementById('nextPromotion').style.width = ((size / 2.37) / 5.875) + 'px';
	document.getElementById('nextPromotion').style.height = (size / 2.37) + 'px';
	
	document.getElementById('promotionsBox').style.width = (size * pmls) + 'px';
	document.getElementById('promotionBox').style.width = size + 'px';
	
	for(var i=1; i<=pmls; i++){
		document.getElementById('pImg' + i).setAttribute('width', size + 'px');
	}
	
	
	// product
	
	var nls = parseInt(document.getElementById('nls').value);
	var bls = parseInt(document.getElementById('bls').value);
	
	document.getElementById('itembox').style.width = top.window.innerWidth + 'px';
	document.getElementById('itembox').style.height = (size / 2 + 200) + 'px';
	document.getElementById('itemboxb').style.width = top.window.innerWidth + 'px';
	document.getElementById('itemboxb').style.height = (size / 2 + 200) + 'px';
	document.getElementById('ct').style.width = (size + (((size / 2) / 5.875)*2)) + 'px';
	document.getElementById('ct').style.height = (size / 2 + 200) + 'px';
	document.getElementById('ctb').style.width = (size + (((size / 2) / 5.875)*2)) + 'px';
	document.getElementById('ctb').style.height = (size / 2 + 200) + 'px';
	document.getElementById('mainView').style.width = size + 'px';
	document.getElementById('mainView').style.height = (size / 2 + 100) + 'px';
	document.getElementById('mainViewb').style.width = size + 'px';
	document.getElementById('mainViewb').style.height = (size / 2 + 100) + 'px';
	
	document.getElementById('prev').style.width = ((size / 2) / 5.875) + 'px';
	document.getElementById('prev').style.height = (size / 2) + 'px';
	document.getElementById('next').style.width = ((size / 2) / 5.875) + 'px';
	document.getElementById('next').style.height = (size / 2) + 'px';
	document.getElementById('prev1').style.width = ((size / 2) / 5.875) + 'px';
	document.getElementById('prev1').style.height = (size / 2) + 'px';
	document.getElementById('next1').style.width = ((size / 2) / 5.875) + 'px';
	document.getElementById('next1').style.height = (size / 2) + 'px';
	
	document.getElementById('itemsbox').style.width = (size * 0.5 * nls) + 'px';
	for(var i=1; i<=nls; i++){
		document.getElementById('items'+i).style.width = (size * 0.46) + 'px';
		document.getElementById('items'+i).style.margin = '0px ' + (size * 0.02) + 'px';
		document.getElementById('imgtest' + i).setAttribute('width', (size * 0.48) + 'px');
		document.getElementById('imgtest' + i).setAttribute('height', (size * 0.48) + 'px');
	}
	
	document.getElementById('itemsbox1').style.width = (size * 0.5 * bls) + 'px';
	for(var i=1; i<=bls; i++){
		document.getElementById('itemsb'+i).style.width = (size * 0.46) + 'px';
		document.getElementById('itemsb'+i).style.margin = '0px ' + (size * 0.02) + 'px';
		document.getElementById('imgtestb' + i).setAttribute('width', (size * 0.48) + 'px');
		document.getElementById('imgtestb' + i).setAttribute('height', (size * 0.48) + 'px');
	}
}
</script>

<div style="width:100%; height:100px; background-color:#e9e5da;"></div>

<!-- 메인 이미지 시작 -->

<c:choose>
	<c:when test="${not empty promotionList}">
		<div id="prmbox" >
			<div id="prmct">
				<img src="images/arrow_prev.png" class="rolPBtn" id="prevPromotion" />
					<div id="mainPromotionView">
						<div id="promotionsBox">
							<c:forEach items="${promotionList}" var="prmList" varStatus="index">
								<a href="mpromotionDetail?prmseq=${prmList.PRMSEQ}">
									<div class="promotionBox" id="promotionBox">
										<img src="/promotion_images/${prmList.BANNER}" id="pImg${index.count}" />
									</div>
								</a>
							</c:forEach>
						</div>
					</div>
				<img src="images/arrow_next.png" class="rolPBtn" id="nextPromotion" />
				<input type="hidden" id="pmls" value="${promotionListSize}" />
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div id="main_img">
			<img src="images/main_img.png" >
		</div>
	</c:otherwise>
</c:choose>

<div class="clear"></div>
<div style="width:100%; height:100px; background-color:#e9e5da;"></div>
<!-- 신상품 --> 
<div id="itembox" >
	<div id="ct">
		<div id="boxtext1">NEW PRODUCT</div>
		<div id="boxtext2">A NEW DESING</div>
		<img src="images/arrow_prev.png" class="rolBtn" id="prev" />
		<div id="mainView">
			<div id="itemsbox">
				<c:forEach items="${newList}" var="nList" varStatus="index">
					<a href="mproductDetail?pseq=${nList.PSEQ}">
						<div id="items${index.count}" class="items">
							<img src="product_images/${nList.IMAGE}" id="imgtest${index.count}"/>
							<div class="listText">${nList.NAME}</div>
							<div class="listText2"><fmt:formatNumber value="${nList.PRICE2}" type="currency"/></div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<img src="images/arrow_next.png" class="rolBtn" id="next" />
		<input type="hidden" id="nls" value="${newListSize}" />
	</div>
</div>

<div class="clear"></div>
<div style="width:100%; height:100px; background-color:#e9e5da;"></div>
<!-- 베스트 상품 -->
<div id="itemboxb">
	<div id="ctb">
		<div id="boxtext1">BEST PRODUCT</div><br>
		<div id="boxtext2">CHECK OUT THE BEST PRODUCT</div>
		<img src="images/arrow_prev.png" class="rolBtn" id="prev1" />
		<div id="mainViewb">
			<div id="itemsbox1">
				<c:forEach items="${bestList}" var="bList"  varStatus="index">
					<a href="mproductDetail?pseq=${bList.PSEQ}">
						<div id="itemsb${index.count}" class="items">
							<img src="product_images/${bList.IMAGE}" id="imgtestb${index.count}"/>
							<div class="listText">${bList.NAME}</div>
							<div class="listText2"><fmt:formatNumber value="${bList.PRICE2}" type="currency"/></div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<img src="images/arrow_next.png" class="rolBtn" id="next1" />
		<input type="hidden" id="bls" value="${bestListSize}" />
	</div>
</div>
<div style="width:100%; height:100px; background-color:#e9e5da;"></div>
<%@ include file="include/footer.jsp" %>
