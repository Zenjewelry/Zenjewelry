<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/mobile.css" rel="stylesheet"> 
<script type="text/javascript">
	function result(zip_num, sido, gugun, dong) {
	   opener.document.formm.zip_num.value=zip_num;
	   opener.document.formm.address.value = sido+ "  " + gugun + " " + dong;
	   self.close();
	};
</script>
</head>
<body>
<div id="popup">
	<center><h1>우편번호검색</h1></center>
	<form method="get" name="formm" action="mfindZipNum">
		<center><h3>동 이름 : <input name="dong"  type="text"><input type="submit" value="찾기"  class="submit"></h3></center>
	</form><br><br>
	<table id="cartList">
		<tr><th>우편번호</th><th>주소</th></tr>
		<c:forEach items="${addressList}" var="addressVO">
			<tr><td>${addressVO.ZIP_NUM}</td>
				<td><a href="#" onclick="result('${addressVO.ZIP_NUM}',
			'${addressVO.SIDO}', '${addressVO.GUGUN}','${addressVO.DONG}')">
			${addressVO.SIDO} ${addressVO.GUGUN} ${addressVO.DONG} </a></td></tr>
		</c:forEach>
	</table>
</div>
</body>
</html>