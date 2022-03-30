<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../include/adminheaderfooter/header.jsp" %>
<article>
<h1>회원리스트</h1>  <br>


<table id="cartList2">

	<tr><th width="60">아이디</th><th width="70"> 이름 </th><th width="120">이메일</th><th width="90">우편번호</th><th width="400">주소</th><th width="130">전화</th><th width="100">가입일</th></tr>
	
	
   <c:forEach items="${memberList}" var="memberVO">  
	    <tr><td>${memberVO.id} </td>
	    	<td>${memberVO.name}</td><td>${memberVO.email}</td><td>${memberVO.zip_num}</td><td>${memberVO.address}</td>
	    	<td>${memberVO.phone}</td><td><fmt:formatDate value="${memberVO.indate}"/></td></tr>
  </c:forEach>
</table>

<form name="frm" method="post">
<table id="cartList2">
	<tr><td width="670">회원 이름 <input type="text" name="key" value="${key3}">
	<input class="btn" type="button" value="검색" onclick="go_search('adminMemberList')">
	<input class="btn" type="button" name="btn_total" value="전체보기 "	onClick="go_total('adminMemberList')"></td> </tr>
</table>
</form>
<br>
<jsp:include page="/admin/paging/paging.jsp">   
<jsp:param value="adminMemberList" name="command"/>
</jsp:include>

</article>


<%@ include file="../include/adminheaderfooter/footer.jsp" %>