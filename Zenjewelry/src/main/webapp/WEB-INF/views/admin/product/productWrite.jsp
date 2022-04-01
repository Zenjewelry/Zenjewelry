<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>
	<form name="frm" method="post" enctype="multipart/form-data">
			<fieldset class="input-box"><legend>상품등록</legend>
			<label>상품분류</label><select name="kind"><option value="">선택</option>				
					<c:forEach items="${kindList}" var="kind" varStatus="status">
		    				<option value="${status.count}">${kind}</option>
		   				</c:forEach>
					</select>
				<br><hr>
			<label>상품명</label><input type="text" name="name" size="47" maxlength="100">
			<label>원가[A]</label><input type="text" name="price1" size="11" onkeyup="cal();">
		  	<label>판매가[B]</label><input type="text" name="price2" size="11" onkeyup="cal();">
			<label>[B-A]</label><input type="text" name="price3" size="11" >
			<label>상세 설명</label><textarea name="content" rows="8" cols="70"></textarea>
			<label>상품 이미지</label><input type="file" name="image">  
			<label>상품 상세 이미지</label><input type="file" name="detail_image"> 
		</fieldset>
		<div class="clear"></div>
		<div id="buttons">
			<input class="submit" type="button" value="등록" onClick="go_save()">           
			<input class="cancel" type="button" value="목록" onClick="go_mov()">
		</div>
	</form>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>