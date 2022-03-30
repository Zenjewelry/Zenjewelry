<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/script/basic.js"></script>
<link rel="stylesheet" type="text/css" href="/css/shopping.css">
</head>
<body>
<div style=text-align:center>
	
	<form name="frm" action="uploadFile" method="post" enctype="multipart/form-data">
		<h1>이미지 불러오기</h1>
		<input type="file" name="image" onchange="uploadedImg();">
	</form>
	
</div>
</body>
</html>