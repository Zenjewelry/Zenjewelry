<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
<form method="post" name="formm" id="join" action="mjoin">
	<fieldset class="input-box"><legend>회원가입</legend>
		<label>User ID</label><input id="username" type="text" name="id" size="12" value="${dto.id}">
		<input id="username" type="hidden" name="reid" value="${reid}">
	    <input id="nbutton" type="button" value="중복 체크" class="dup" onclick="idcheck()"><br>
	    <label>Password</label><input id="username"  type="password" name="pwd"><br> 
	    <label>Retype Password</label><input id="username" type="password" name="pwdCheck"><br> 
	    <label>Name</label><input id="username" type="text"  name="name" value="${dto.name}"><br> 
	    <label>E-Mail</label><input id="username" type="text"  name="email" value="${dto.email}"><br>
	    <input id="nbutton" type="button" value="이메일 중복 체크" class="dup" onclick="emailCheck()"><br>
	    <label>인증번호</label><input id="username" type="text" name="num" readonly><br>
	    <input id="nbutton" type="button" value="인증번호 전송" class="dup" onclick="numCheck()"><br>
	    <label>Phone Number</label><input id="username"  type="text" name="phone" value="${dto.phone}"><br>
	    <label>Zip Code</label><input id="username" type="text" name="zip_num"   size="10" >      
	    <input  id="nbutton" type="button" value="주소 찾기" class="dup" onclick="post_zip()"><br>
		<label>Address</label><input id="username" type="text" name="address"   size="50"><br>
		<label>&nbsp;</label><input id="username" type="text" name="address2"   size="25">
		<h3>${message}</h3>
		
	</fieldset>
	<div class="clear"></div>
	<div id="buttons">
	    <input type="submit" value="회원가입" class="submit"> 
	    <input type="reset" value="취소" class="cancel">
	</div>
</form></article>

<%@ include file="../include/footer.jsp" %>