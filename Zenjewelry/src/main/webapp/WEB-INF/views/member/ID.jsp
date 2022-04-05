<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function goodId(){	
	self.close();
}

</script>
</head>
<body>

<div>${findId.NAME}님의 아이디는 ${findId.ID} 입니다</div>
<div><input type=button value="확인" onclick="goodId()"></div>
<div><input type=button value="비밀번호 찾기" onclick="location.href='findPwForm'"></div>

</body>
</html>