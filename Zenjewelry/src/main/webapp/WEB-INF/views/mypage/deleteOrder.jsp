<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="popup">
	<center><h1>비밀번호 입력</h1></center>
	<form method="get" name="formm" action="deleteOrderPassWord">
		<input  type="hidden" name="odseq" value="${odseq}" id="odseq">
		<center><h3>비밀번호 : <input id="repassword"  type="password" name="repassword"><input type="submit" value="입력"  class="submit"></h3></center>
		${message}
	</form><br><br>
	
</div>

</body>
</html>