<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>


<article>
<h2>정보수정</h2>
<form method="post" name="formm" action="memberUpdate">
	<fieldset class="input-box">
		<label>User ID</label><input id="username"  type="text" name="id" value="${dto.id}" readonly><br>
		<label>Password</label><input id="username" type="password"  name="pwd"><br> 
        <label>Retype Password</label>	<input id="username" type="password"  name="pwdCheck"><br> 
        <label>Name</label><input id="username" type="text" name="name"  value="${dto.name}"><br> 
        <label>E-Mail</label><input id="username" type="text" name="email" value="${dto.email}"><br> 
        <label>Phone Number</label><input  id="username" type="text" name="phone"  value="${dto.phone}"><br>
	    <label>Zip Code</label><input id="username" type="text" name="zip_num" size="10" value="${dto.zip_num}">      
	    <input id="nbutton" type="button" value="주소 찾기" class="dup" onclick="post_zip()"><br>
	    <label>Address</label><input id="username" type="text" name="address"   size="50" value="${dto.address}"><br>
	    <label>&nbsp;</label>	<input id="username" type="text" name="address2"   size="25" value="${dto.address2}"><br>
	</fieldset><div class="clear"></div>
	<div id="buttons"><input type="submit" value="정보수정" class="submit"> 
		<input type="reset" value="취소" class="cancel"></div>
</form>
</article>





<%@ include file="../include/headerfooter/footer.jsp" %> 