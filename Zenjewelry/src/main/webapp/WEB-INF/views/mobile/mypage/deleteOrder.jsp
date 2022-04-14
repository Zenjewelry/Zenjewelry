<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
function checkPwd(){
	if(document.formm.repassword.value != '${loginUser.PWD}'){
		alert('비밀번호를 확인해주세요');
		return;
	}
	opener.name = 'parentPage';
	document.formm.target = opener.name;
	document.formm.action = 'mdeleteOrder';
	document.formm.submit();
	self.close();
}
</script>
</head>
<body>

<div id="popup">
	<center><h1>비밀번호 입력</h1></center>
	<form name="formm">
		<input  type="hidden" name="oseq" value="${oseq}">
		<center>
		<h3>비밀번호 : <input type="password" name="repassword">
		<input type="button" value="입력"  class="submit" onClick="checkPwd();"></h3></center>
	</form><br><br>
	
</div>

</body>
</html>