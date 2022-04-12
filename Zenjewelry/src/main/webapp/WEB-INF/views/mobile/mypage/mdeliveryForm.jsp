<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
	<form method="post" name="formm">
		<fieldset class="input-box">
			<input type="hidden"  name="oseq" value="${orderList.OSEQ}">
			<legend><h3>구매자정보</h3></legend>
			<label>이름</label><input type="text" name="name"  value="${orderList.MNAME}" readonly><br> 
			<label>이메일</label><input type="text" name="email" value="${loginUser.EMAIL}" readonly><br>
			<label>휴대폰 번호</label><input  type="text" name="phone"  value="${orderList.PHONE}" readonly><br>
			<label>비밀번호 확인</label><input type="password"  name="pwd"><br> 
			<input type="hidden"  name="pwdCheck" value="${loginUser.PWD}"> <br><br>

			<legend><h3>배송정보</h3></legend>
			<label>구매상품</label><input type="text" name="name"  value="${orderList.PNAME}" readonly><br> 
			<label>우편번호</label><input type="text" name="zip_num" size="10" value="${orderList.ZIP_NUM}">      
			<input id="nbutton" type="button" value="주소 찾기" class="dup" onclick="post_zip()"><br>
			<label>주소</label><input type="text" name="address"   size="50" value="${orderList.ADDRESS}"><br>
			<label>상세주소</label><input type="text" name="address2"   size="50" value="${orderList.ADDRESS2}"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
	<input type="button" value="배송정보변경" class="submit" onclick="zip_update_delivery();"> 
	<input type="button" value="취소" class="cancel" onclick="go_orderDetail();">
</div>
</form></article>

<%@ include file="../include/footer.jsp" %>