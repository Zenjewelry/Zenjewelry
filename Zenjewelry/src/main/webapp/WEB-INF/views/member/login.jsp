<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article>
<h1 style=margin-left:80px;>로그인</h1>
<form method="post" action="login" name="loginFrm">

	<fieldset class="input-box">
		<legend></legend>
			<label>User ID</label><input id="username" name="id" type="text" value="${dto.id}"><br> 
	        <label>Password</label><input id="password" name="pwd" type="password"><br>
	</fieldset >

	<div id="buttons">
            <input type="submit" value="로그인" class="submit" 	onclick="return loginCheck()">
            <input type="button" value="회원가입" class="cancel" onclick="location.href='contract'">
            <input type="button" value="아이디 비밀번호 찾기" class="submit" onclick="find_account()">     
    </div><br><br>
    <div>&nbsp;&nbsp;&nbsp;${message}</div>
</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>