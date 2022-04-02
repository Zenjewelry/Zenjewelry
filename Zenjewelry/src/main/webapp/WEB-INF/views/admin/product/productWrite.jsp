<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>
	<form name="frm" method="post" action="adminProductWrite">
			<fieldset class="input-box"><legend>상품등록</legend>
			<label>상품분류</label><select name="kind">
				<option value="">선택</option>	
				<c:forEach items="${kindList}" var="kind" varStatus="status">
	    				<option value="${status.count}">${kind}</option>
	   				</c:forEach></select>
				<br><hr>
			<label>상품명</label><input type="text" name="name" size="47" maxlength="100" value="${dto.name}">
			<label>원가[A]</label><input type="text" name="price1" size="11" onkeyup="cal();" value="${dto.price1}">
		  	<label>판매가[B]</label><input type="text" name="price2" size="11" onkeyup="cal();" value="${dto.price2}">
			<label>[B-A]</label><input type="text" name="price3" size="11" >
			<label>상세 설명</label><textarea name="content" rows="8" cols="70">${dto.content}</textarea>
			<label>대표이미지</label><input type="button" value="대표이미지 업로드" onClick="uploadAdminImg('Thumb');">
			<label>대표이미지 파일명</label><div id="previewThumbText" >${dto.image}</div>
			<label>Preview</label><img src="" id="previewThumbImg" width="300" height="300" style="display:none;" value="/product_images/${dto.image}"/><br />
			<input type="hidden" name="image" value="${dto.image}"/>
			<label>상세이미지</label><input type="button" value="상품상세이미지 업로드" onClick="uploadAdminImg('Detail');">
			<label>상세이미지 파일명</label><div id="previewDetailText">${dto.detail_image}</div>
			<label>Preview</label><img src="" id="previewDetailImg" width="300" height="300" style="display:none;"  value="/product_images/${dto.detail_image}"/><br />
			<input type="hidden" name="detail_image" value="${dto.detail_image}"/> 
			<label>신상품 유무</label><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="newyn" value="y" checked="checked" />
				<div style="float:left;" >N</div><input type="checkbox" name="newyn" value="n" />
			<label>베스트 유무</label><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="bestyn" value="y" />
				<div style="float:left;" >N</div><input type="checkbox" name="bestyn" value="n" checked="checked" />
		</fieldset>
		<div class="clear"></div>
		<div id="buttons">
			<input class="submit" type="submit" value="등록" >
			<input class="cancel" type="button" value="목록" onClick="go_mov()">
		</div>
	</form>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>