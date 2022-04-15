<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/shopping.css" rel="stylesheet">  
<script type="text/javascript">

function workerCheck(){
	  if(document.frm.workId.value==""){
	      	alert("아이디를 입력하세요.");
	      	return false;
	  }else if(document.frm.workPwd.value==""){
	     	alert("비밀번호를 입력하세요.");
	      	return false;
	  }
	  return true;
}
</script>

</head>
<body>
<div id="wrap_a">
	<div id="logo_a">
		<img src="images/logo_yw.png" width="500" height="350"/>	
	</div>
</div>

<div class="clear"></div>
<article>
<h1 style=margin-left:80px;>ADMIN PAGE</h1>
	<form name="frm" method="post" action="adminLogin">
		
		<fieldset  class="input-box">
			<legend></legend>
				<label>ADMIN ID</label><input type="text" name="workId" size="10"><br>
				<label>Password</label><input type="password" name="workPwd" size="10"><br>
		</fieldset>
		
		<div id="buttons">
				<input class="submit" type="submit"   value="로그인" onClick="return workerCheck();">
		</div><br><br>
		<h4 style="color:red">${message}</h4>
	</form>

</article>


</body>
</html>
<%@ include file="../include/adminheaderfooter/footer.jsp" %>