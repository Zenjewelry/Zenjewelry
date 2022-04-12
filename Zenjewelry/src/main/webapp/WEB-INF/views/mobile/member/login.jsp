<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article>
<h1 style=text-align:center>로그인</h1>
<form style=text-align:center method="post" action="mlogin" name="loginFrm">

	<fieldset class="input-box">
		<legend></legend>
			<label>User ID</label><input id="username" name="id" type="text" value="${dto.id}"><br> 
	        <label>Password</label><input id="password" name="pwd" type="password"><br>
	</fieldset >

	<div id="buttons">
            <input type="submit" value="로그인" class="submit" 	onclick="return loginCheck()">
            <input type="button" value="회원가입" class="cancel" onclick="location.href='mcontract'">
            <input type="button" value="아이디 비밀번호 찾기" class="submit" onclick="find_account()">     
    </div><br><br>
    <div>&nbsp;&nbsp;&nbsp;${message}</div>
</form>
</article>

<%@ include file="../include/footer.jsp" %>