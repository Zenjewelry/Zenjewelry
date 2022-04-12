<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mobile.css" rel="stylesheet"> 
<script src="member/mobile.js"></script>
<script type="text/javascript">
function emailok(){
		opener.formm.email.value="${email}"; 		
	
		self.close();
}
</script>
</head>
<body>


<center><h1>Email 중복확인</h1></center>
<form method="post" name="name" action="mEmailCheckForm">
	User ID :  <input type="text" name="email" value="${email}" >
	<input type="submit" value="검색" class="submit"><br><br><br>	
	<div>
		<c:if test="${result == 1}">
			<script type="text/javascript">opener.document.formm.email.value="";</script>
			${email}은 이미 사용중인 이메일입니다.
		</c:if>
		<c:if test="${result == -1}">
			${email}은 사용 가능한 이메일입니다.    
			<input type="button" value="사용" class="cancel" onclick="emailok()">
		</c:if>
	</div>
	
</form>


</body>
</html>