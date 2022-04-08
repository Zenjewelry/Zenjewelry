<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/shopping.css" rel="stylesheet">
<script type="text/javascript">

function check(){
	if(document.formm.numCheck.value != document.formm.checkNum.value){
		alert('인증번호가 다릅니다.')
		return;
	}
	opener.formm.num.value="${checkNum}";
	self.close();
}

</script>

</head>

<body>


	<form method="post" name="formm" >
		<table id="cartlist" align="center" >
			<tr align="center" bgcolor="f7f7f7" width="500" height="30">
				<th><h2>인증번호</h2></th>
		<%-- <table id="cartlist" align="center"  cellspacing="1" width="400">
			<tr>
				<td width="430"><h3>인증번호<input type="text" name="numCheck" value="${numCheck}"></h3></td>
				<input type="hidden" name="checkNum" value="${checkNum}" > --%>
			</tr>
			<tr align="center" bgcolor="f7f7f7" width="500" height="30">
				<td ><input type="text" name="numCheck" value="${numCheck}"></td>
				<input type="hidden" name="checkNum" value="${checkNum}" >
			</tr><tr align="center" bgcolor="f7f7f7" width="500" height="30">
				<td><h3><input type="button" onClick="check();" value="확인"></h3></td>
			</tr>
		</table>
	</form>


</body>

</html>
