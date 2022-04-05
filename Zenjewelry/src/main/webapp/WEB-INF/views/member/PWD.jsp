<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" name="formm" action="PWD">
	<div>
		<input type=password value="${pwd}" name="pwd">
		<input type=hidden value="${id}" name="id">
		<input type=hidden value="${name}" name="name">
		<input type="submit" value="비밀번호 변경">
	</div>
</form>
</body>
</html>