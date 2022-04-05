<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/shopping.css" rel="stylesheet">
</head>
<body>

<center><h2>비밀번호 찾기</h2></center>
<c:if test="${result != 1}">
<form method="post" name="formm" action="findPwStep1">
	<table id="cartlist" align="center" bgcolor="black" cellspacing="1" width="400">
			<tr align="center" bgcolor="#FFFFFF" >
				<td width="430"><h3>아이디<input type="text" name="id" value="${id}" ></h3></td>
			</tr>
			<tr align="center" bgcolor="#FFFFFF" >
				<td width="430"><h3>성명<input type="text" name="name" value="${name}" ></h3></td>
			</tr>
			<tr align="center" bgcolor="#FFFFFF" >
				<td width="430"><h3>E-Mail<input type="text" name="email" value="${email}" ></h3></td>
			</tr>
			<tr align="center" bgcolor="#FFFFFF" >
				<td width="430"><h3><input type="submit" value="인증번호 전송"></h3></td>
			</tr>
		</table>
	</form>
</c:if>	
<c:if test="${result == 1}">
	<form method="post" name="formm" action=change_Pwd>
		<table id="cartlist" align="center" bgcolor="black" cellspacing="1" width="400">
			<tr align="center" bgcolor="#FFFFFF" >
				<td width="430"><h3>아이디<input type="text" name="id" value="${id}" ></h3></td>
			</tr>
			<tr align="center" bgcolor="#FFFFFF" >
					<td width="430"><h3>성명<input type="text" name="name" value="${name}" readonly></h3></td>
				</tr>
			<tr align="center" bgcolor="#FFFFFF" >
					<td width="430"><h3>E-Mail<input type="text" name="email" value="${email}" readonly></h3></td>
				</tr>
			<tr>
				<td width="430"><h3>인증번호<input type="text" name="numCheck" value="${numCheck}"></h3></td>
				<input type="hidden" name="checkNum" value="${checkNum}" >
			</tr>
			<tr>
				<td width="430"><h3><input type="submit" value="인증번호 확인" ></h3></td>
			</tr>
		</table>
	</form>
</c:if>
</body>
</html>