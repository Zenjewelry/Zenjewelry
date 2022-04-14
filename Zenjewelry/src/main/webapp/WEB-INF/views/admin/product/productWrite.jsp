<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>
	<form name="frm" method="post" action="adminProductWrite">
			<fieldset class="input-box"><legend>상품등록</legend>
			<label>상품분류</label>
				<select name="kind">
					<option value="">선택</option>	
					<c:forEach items="${kindList}" var="kindString" varStatus="status">
						<c:choose>
							<c:when test="${status.count == dto.kind}">
								<option value="${status.count}" selected="selected">${kindString}</option>
							</c:when>
							<c:otherwise>
								<option value="${status.count}">${kindString}</option>
							</c:otherwise>
						</c:choose>
	   				</c:forEach>
	   			</select>
				<br><hr>
			<label>상품명</label><input type="text" name="name" size="47" maxlength="100" value="${dto.name}">
			<label>원가[A]</label><input type="text" name="price1" size="11" onkeyup="cal();" value="${dto.price1}">
		  	<label>판매가[B]</label><input type="text" name="price2" size="11" onkeyup="cal();" value="${dto.price2}">
			<label>[B-A]</label><input type="text" name="price3" size="11" >
			<label>상세 설명</label><textarea name="content" rows="8" cols="70">${dto.content}</textarea>
			<label>대표이미지</label><input type="button" value="대표이미지 업로드" onClick="uploadAdminImg('Thumb');">
			<label>대표이미지 파일명</label><div id="previewThumbText" >${dto.image}</div>
			<label>Preview</label><img src="/product_images/${dto.image}" id="previewThumbImg" width="300" height="300" style="display:none;" /><br />
			<input type="hidden" name="image" value="${dto.image}"/>
			<label>상세이미지</label><input type="button" value="상품상세이미지 업로드" onClick="uploadAdminImg('Detail');">
			<label>상세이미지 파일명</label><div id="previewDetailText">${dto.detail_image}</div>
			<label>Preview</label><img src="/product_images/${dto.detail_image}" id="previewDetailImg" width="300" height="300" style="display:none;"/><br />
			<input type="hidden" name="detail_image" value="${dto.detail_image}"/> 
			<label>신상품 유무</label><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="newyn" value="y" checked="checked" />
				<div style="float:left;" >N</div><input type="checkbox" name="newyn" value="n" />
			<label>베스트 유무</label><div style="float:left;" >Y</div><input type="checkbox" style="float:left;" name="bestyn" value="y" />
				<div style="float:left;" >N</div><input type="checkbox" name="bestyn" value="n" checked="checked" />
		</fieldset>
		<div class="clear"></div>
		<fieldset>
			<label>순도(,로 구분해주세요.)</label><input type="text" name="optionParam1" />
			<label>사이즈(,로 구분해주세요.)</label><input type="text" name="optionParam2" />
			<label>색상(,로 구분해주세요.)</label><input type="text" name="optionParam3" />
			<input type="button" value="옵션 조합하기" onClick="createOptions();">
			<table>
				<tr><th>순번</th><th>옵션명</th><th>옵션별 가격</th><th>재고</th></tr>
				<c:forEach items="${optionList}" var="option" varStatus="index">
					<tr>
						<td>${index.count}</td>
						<td><input type="hidden" name="option${index.count}" value="${option}" />${option}</td>
						<td><input type="text" name="changePrice${index.count}" value="0" /></td>
						<td><input type="text" name="sku${index.count}" value="10" /></td>
					</tr>
				</c:forEach>
			</table>
		</fieldset>
		<input type="hidden" name="optionSize" value="${optionSize}" />
		<div id="buttons">
			<input class="submit" type="submit" value="등록" >
			<input class="cancel" type="button" value="목록" onClick="go_mov()">
		</div>
	</form>
	${message}
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>