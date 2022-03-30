<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/shopping.css" rel="stylesheet"> 
<script src="member/member.js"></script>
<script type="text/javascript">
function idok(){
		opener.formm.id.value="${id}"; 		
		opener.formm.reid.value="${id}";		
		self.close();
}
</script>
</head>
<body>


<center><h1>ID 중복확인</h1></center>
<form method="post" name="name" action="idCheckForm">
	User ID :  <input type="text" name="id" value="${id}" >
	<input type="submit" value="검색" class="submit"><br><br><br>	
	<div>
		<c:if test="${result == 1}">
			<script type="text/javascript">opener.document.formm.id.value="";</script>
			${id}는 이미 사용중인 아이디입니다.
		</c:if>
		<c:if test="${result == -1}">
			${id}는 사용 가능한 ID입니다.    
			<input type="button" value="사용" class="cancel" onclick="idok()">
		</c:if>
	</div>
	
</form>


</body>
</html>