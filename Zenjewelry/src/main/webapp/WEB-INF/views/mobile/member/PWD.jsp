<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function change_Pwd(){
	if(document.formm.pwd.value == ''){
		alert('비밀번호를 입력하세요');
		return
	}
	opener.name='parentPage';
	document.formm.target = opener.name;
	document.formm.action= 'PWD';
	document.formm.submit();
	self.close();
}

</script>
</head>
<body>
<form method="post" name="formm">
	<div>
		<input type=password value="${pwd}" name="pwd">
		<input type=hidden value="${id}" name="id">
		<input type=hidden value="${name}" name="name">
		<input type="button" class="submit" value="비밀번호 변경" onClick="change_Pwd();">	
	</div>
</form>
</body>
</html>