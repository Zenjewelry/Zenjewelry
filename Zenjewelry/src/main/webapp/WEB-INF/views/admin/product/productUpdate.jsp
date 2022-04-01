<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>
<article>
<form name="frm" method="post" enctype="multipart/form-data">
	<fieldset class="input-box"><h2>상품수정${productVO.kind}</h2>
	<input type="hidden" name="pseq" value="${productVO.PSEQ}">
	<input type="hidden" name="oldImage" value="${productVO.IMAGE}">
	<input type="hidden" name="oldDetail_image" value="${productVO.DETAIL_IMAGE}">
	<label>상품분류</label><select name="kind">
				<c:forEach items="${kindList}" var="kind" varStatus="status">
					<c:choose>
						<c:when test="${productVO.KIND==status.COUNT}">
							<option value="${status.COUNT}" selected="selected">${kind}</option>
						</c:when>
	          			<c:otherwise><option value="${status.COUNT}">${kind}</option></c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<hr>
	<label>상품명</label><input type="text" name="name" size="47" maxlength="100"	value="${productVO.NAME}">
	<label>원가[A]</label><input type="text" name="price1" size="11" value="${productVO.PRICE1}">
	<label>판매가[B]</label><input type="text" name="price2" size="11" value="${productVO.PRICE2}">
	<label>베스트상품</label>
		 <c:choose>
	  			<c:when test='${productVO.BESTYN=="y"}'><input type="checkbox" name="bestyn" value="chk" checked="checked">	</c:when>
				<c:otherwise><input type="checkbox" name="bestyn" value="chk"></c:otherwise>
			</c:choose>
			<hr>
	<label>신상유무</label>
			
			<c:choose>
		     	<c:when test='${productVO.NEWYN=="y"}'><input type="checkbox" name="newyn" value="chk" checked="checked"></c:when>
		      	<c:otherwise><input type="checkbox" name="newyn" value="chk"></c:otherwise>
		    </c:choose>
		    <hr>
	<label>상세설명</label><textarea name="content" rows="8" cols="70" >${productVO.CONTENT}</textarea>
	<hr>
	<label>상품이미지</label><img src="product_images/${productVO.IMAGE}" width="200pt"><input type="file" name="image">
	<hr> 
	<label>상품 상세 이미지</label><img src="product_images/${productVO.DETAIL_IMAGE}" width="200pt"><input type="file" name="detail_image">
</fieldset>
	
	<div id="buttons">
		<input class="submit" type="button" value="수정" onClick="go_mod_save()">           
		<input class="cancel" type="button" value="취소"  onClick="location.href='shop.do?command=adminProductDetail&pseq=${productVO.PSEQ}'">
	</div>
	
</form>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>