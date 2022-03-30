<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article>
	<form method="post" name="updateDelivery">
		<fieldset class="input-box">
			<input type="hidden"  name="oseq" value="${OrderVO.OSEQ}">
			<legend>구매자정보</legend>
			<label>이름</label><input type="text" name="name"  value="${OrderVO.MNAME}" readonly><br> 
			<label>이메일</label><input type="text" name="email" value="${loginUser.EMAIL}" readonly><br>
			<label>휴대폰 번호</label><input  type="text" name="phone"  value="${OrderVO.PHONE}" readonly><br>
			<label>비밀번호 확인</label><input type="password"  name="pwd"><br> 
			<input type="hidden"  name="pwdCheck" value="${loginUser.PWD}"> <br><br>

			<legend>배송정보</legend>
			<label>구매상품</label><input type="text" name="name"  value="${OrderVO.PNAME}" readonly><br> 
			<label>우편번호</label><input type="text" name="zip_num" size="10" value="${OrderVO.ZIP_NUM}">      
			<input id="nbutton" type="button" value="주소 찾기" class="dup" onclick="post_zip1()"><br>
			<label>주소</label><input type="text" name="addr1"   size="50" value="${addr1}"><br>
			<label>상세주소</label><input type="text" name="addr2"   size="50" value="${addr2}"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
	<input type="button" value="배송정보변경" class="submit" onclick="zip_update_delivery();"> 
	<input type="button" value="취소" class="cancel" onclick="go_orderDetail();">
</div>
</form></article>

<%@ include file="../include/headerfooter/footer.jsp" %>