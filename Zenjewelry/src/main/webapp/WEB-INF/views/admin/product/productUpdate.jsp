<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>
<article>
<form name="frm" method="post">
	<fieldset class="input-box"><h2>상품수정${productVO.kind}</h2>
	<input type="hidden" name="pseq" value="${productVO.PSEQ}">
	<%-- <input type="hidden" name="oldImage" value="${productVO.IMAGE}">
	<input type="hidden" name="oldDetail_image" value="${productVO.DETAIL_IMAGE}"> --%>
	<label>상품분류</label><select name="kind"><option value="">선택</option>	
				<c:forEach items="${kindList}" var="kind" varStatus="status">
					<c:choose>
						<c:when test="${productVO.KIND==status.count}">
							<option value="${status.count}" selected="selected">${kind}</option>
						</c:when>
	          			<c:otherwise><option value="${status.count}">${kind}</option></c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<hr>
	<label>상품명</label><input type="text" name="name" size="47" maxlength="100"	value="${productVO.NAME}">
	<label>원가[A]</label><input type="text" name="price1" size="11" value="${productVO.PRICE1}">
	<label>판매가[B]</label><input type="text" name="price2" size="11" value="${productVO.PRICE2}">
	<label>베스트상품</label>
		 <c:choose>
	  			<c:when test='${productVO.BESTYN=="y"}'><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="bestyn" value="y" checked="checked" />
				<div style="float:left;" >N</div><input type="checkbox" name="bestyn" value="n" /></c:when>
				<c:otherwise><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="bestyn" value="y" />
				<div style="float:left;" >N</div><input type="checkbox" name="bestyn" value="n" checked="checked" /></c:otherwise>
			</c:choose>
			<hr>
	<label>신상유무</label>
			<c:choose>
		     	<c:when test='${productVO.NEWYN=="y"}'><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="newyn" value="y" checked="checked" />
				<div style="float:left;" >N</div><input type="checkbox" name="newyn" value="n" /></c:when>
		      	<c:otherwise><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="newyn" value="y" />
				<div style="float:left;" >N</div><input type="checkbox" name="newyn" value="n" checked="checked" /></c:otherwise>
		    </c:choose>
		    <hr>
	<label>상세설명</label><textarea name="content" rows="8" cols="70" >${productVO.CONTENT}</textarea>
	<hr>
	<label>대표이미지</label><input type="button" value="대표이미지 업로드" onClick="uploadAdminImg('Thumb');">
			<label>대표이미지 파일명</label><div id="previewThumbText" >${productVO.IMAGE}</div>
			<label>Preview</label><img src="/product_images/${productVO.IMAGE}" id="previewThumbImg" width="300" height="300" /><br />
			<input type="hidden" name="image" value="${productVO.IMAGE}"/>
	<hr> 
	<label>상세이미지</label><input type="button" value="상품상세이미지 업로드" onClick="uploadAdminImg('Detail');">
			<label>상세이미지 파일명</label><div id="previewDetailText">${productVO.DETAIL_IMAGE}</div>
			<label>Preview</label><img src="/product_images/${productVO.DETAIL_IMAGE}" id="previewDetailImg" width="300" height="300" /><br />
			<input type="hidden" name="detail_image" value="${productVO.DETAIL_IMAGE}"/>
			
	<!-- <button id="optionButton">Option List</button> -->
	<div id="optionTable">
		<table>
			<tr><th>순번</th><th>옵션1</th><th>옵션2</th><th>옵션3</th><th>옵션별 가격</th><th>재고</th></tr>
			<c:forEach items="${options}" var="option" varStatus="index">
				<tr>
					<td>${index.count}</td>
					<td><input type="text" name="option1${index.count}" value="${option.OPTION1}" /></td>
					<td><input type="text" name="option2${index.count}" value="${option.OPTION2}" /></td>
					<td><input type="text" name="option3${index.count}" value="${option.OPTION3}" /></td>
					<td><input type="text" name="changePrice${index.count}" value="${option.CHANGEPRICE}" /></td>
					<td><input type="text" name="sku${index.count}" value="${option.SKU}" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<input type="hidden" name="optionSize" value="${optionSize}" />
</fieldset>
	
	<div id="buttons">
		<input class="submit" type="button" value="수정" onClick="go_mod_save()">           
		<input class="cancel" type="button" value="취소"  onClick="location.href='adminProductDetail?pseq=${productVO.PSEQ}'">
	</div>
	
</form>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>