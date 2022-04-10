<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article>


<form method="post" action="break" name="formm">
	<div>
	<h2>"${MemberVO.USEYN }" 계정 입니다 계정을 활성화 하시겠습니까?</h2><br>
	</div>
	<div id="buttons">
            <input type="submit" value="예" class="submit" 	onclick="return loginCheck()">
            <input type="button" value="아니요" class="cancel" onclick="location.href='loginForm'">      
    </div><br><br>
    
</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>