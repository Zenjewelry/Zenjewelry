<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>
<article>
<form name="frm" method="post" enctype="multipart/form-data">
	<fieldset class="input-box"><h2>상품수정${productVO.kind}</h2>
	<input type="hidden" name="pseq" value="${productVO.pseq}">
	<input type="hidden" name="oldImage" value="${productVO.image}">
	<input type="hidden" name="oldDetail_image" value="${productVO.detail_image}">
	<label>상품분류</label><select name="kind">
				<c:forEach items="${kindList}" var="kind" varStatus="status">
					<c:choose>
						<c:when test="${productVO.kind==status.count}">
							<option value="${status.count}" selected="selected">${kind}</option>
						</c:when>
	          			<c:otherwise><option value="${status.count}">${kind}</option></c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<hr>
	<label>상품명</label><input type="text" name="name" size="47" maxlength="100"	value="${productVO.name}">
	<label>원가[A]</label><input type="text" name="price1" size="11" value="${productVO.price1}">
	<label>판매가[B]</label><input type="text" name="price2" size="11" value="${productVO.price2}">
	<label>베스트상품</label>
		 <c:choose>
	  			<c:when test='${productVO.bestyn=="y"}'><input type="checkbox" name="bestyn" value="chk" checked="checked">	</c:when>
				<c:otherwise><input type="checkbox" name="bestyn" value="chk"></c:otherwise>
			</c:choose>
			<hr>
	<label>신상유무</label>
			
			<c:choose>
		     	<c:when test='${productVO.newyn=="y"}'><input type="checkbox" name="newyn" value="chk" checked="checked"></c:when>
		      	<c:otherwise><input type="checkbox" name="newyn" value="chk"></c:otherwise>
		    </c:choose>
		    <hr>
	<label>상세설명</label><textarea name="content" rows="8" cols="70" >${productVO.content}</textarea>
	<hr>
	<label>상품이미지</label><img src="product_images/${productVO.image}" width="200pt"><input type="file" name="image">
	<hr> 
	<label>상품 상세 이미지</label><img src="product_images/${productVO.detail_image}" width="200pt"><input type="file" name="detail_image">
</fieldset>
	
	<div id="buttons">
		<input class="submit" type="button" value="수정" onClick="go_mod_save()">           
		<input class="cancel" type="button" value="취소"  onClick="location.href='shop.do?command=adminProductDetail&pseq=${productVO.pseq}'">
	</div>
	
</form>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>