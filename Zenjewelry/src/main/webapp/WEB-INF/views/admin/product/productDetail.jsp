<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>
<div id="itemdetail" style="float:left;">
<h1>상품 정보</h1>
<form method="post" name="formm"> 
<fieldset> <legend>Item detail Info</legend>
	<input type="hidden" name="pseq" value="${productVO.pseq}">
	<span style= "float:left; margin-right:20px;">
		<img src="product_images/${productVO.image}" style="width: 350px; height: 350px; object-fit: cover;"></span>
	<h2>${productVO.name}</h2>
	<label>상품분류 : </label><p>${kind}</p>
	<label>원가 [A] : </label><p>${productVO.price1} 원</p>      
	<label>판매가 [B] : </label><p>${productVO.price2} 원</p>
	<label>제품설명 : </label><label>${productVO.content}</label><br>
</fieldset>
<div class="clear"></div>

	<div id="buttons">
		<input class="submit"  type="button" value="수정" onClick="go_mod('${productVO.pseq}')">
		<input class="cancel"  type="button" value="목록" onClick="go_mov()">
		<input class="submit"  type="button" value="삭제" onClick="delete_mod()">
	</div>
</form>
</div>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>