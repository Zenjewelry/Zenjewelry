<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>
<article>
<h1>회원리스트</h1>  <br>


<table id="cartList2">

	<tr><th width="60">아이디</th><th width="70"> 이름 </th><th width="120">이메일</th><th width="90">우편번호</th><th width="400">주소</th><th width="130">전화</th><th width="100">가입일</th></tr>
	
	
   <c:forEach items="${memberlist}" var="memberVO">  
	    <tr><td>${memberVO.ID} </td>
	    	<td>${memberVO.NAME}</td><td>${memberVO.EMAIL}</td><td>${memberVO.ZIP_NUM}</td><td>${memberVO.ADDRESS}</td>
	    	<td>${memberVO.PHONE}</td><td><fmt:formatDate value="${memberVO.INDATE}"/></td></tr>
  </c:forEach>
</table>

<form name="frm" method="post">
<table id="cartList2">
	<tr><td width="670">회원 이름 <input type="text" name="key" value="${key}">
	<input class="btn" type="button" value="검색" onclick="go_search('adminMemberList')">
	<input class="btn" type="button" name="btn_total" value="전체보기 "	onClick="go_total('adminMemberList')"></td> </tr>
</table>
</form>
<br>
<jsp:include page="../../include/page/paging.jsp">   
<jsp:param value="adminMemberList" name="command"/>
</jsp:include>

</article>


<%@ include file="../../include/adminheaderfooter/footer.jsp" %>