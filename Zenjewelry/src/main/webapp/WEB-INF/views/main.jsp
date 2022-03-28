<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/headerfooter/header.jsp" %>



<!-- 메인 이미지 시작 -->
<div id="main_img">
	<img src="images/main_img.png" > 
</div>

<!-- 신상품 --> 
<div id=itembox>
	<div id="ct">
		<div id="boxtext1">NEW PRODUCT</div><br>
		<div id="boxtext2">A NEW DESING</div>
		
	
		
		<img src="images/arrow_prev.png" class="rolBtn" id="prev" />
		<div id="mainView">
			<div id="itemsbox" style="width:${newListSize}px;">
				<c:forEach items="${newList}" var="nList">
					<a href="productDetail?pseq=${nList.pseq}">
						<div id="items">
							<img src="product_images/${nList.image}" id="imgtest"/>
							<div class="listText">${nList.name}</div>
							<div class="listText1">${nList.content}</div><br>
							<div class="listText2"><fmt:formatNumber value="${nList.price2}" type="currency"/></div>
						
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<img src="images/arrow_next.png" class="rolBtn" id="next" /><input type="hidden" id="nls" value="${newListSize}" />
	</div>
</div>

<div class="clear"></div>

<!-- 베스트 상품 -->
<div id=itembox>
	<div id="ct">
		<div id="boxtext1">BEST PRODUCT</div><br>
		<div id="boxtext2">CHECK OUT THE BEST PRODUCT</div>
		
		
		<img src="images/arrow_prev.png" class="rolBtn" id="prev1" />
		<div id="mainView">
			<div id="itemsbox1" style="width:${bestListSize}px;">
				<c:forEach items="${bestList}" var="bList">
					<a href="productDetail?pseq=${bList.pseq}">
						<div id="items">
							<img src="product_images/${bList.image}" id="imgtest"/>
							<div class="listText">${bList.name}</div>
							<div class="listText1">${bList.content}</div><br>
							<div class="listText2"><fmt:formatNumber value="${bList.price2}" type="currency"/></div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<img src="images/arrow_next.png" class="rolBtn" id="next1" /><input type="hidden" id="bls" value="${bestListSize}" />
	</div>
</div>

<%@ include file="/include/headerfooter/footer.jsp" %>
