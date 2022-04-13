<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

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
