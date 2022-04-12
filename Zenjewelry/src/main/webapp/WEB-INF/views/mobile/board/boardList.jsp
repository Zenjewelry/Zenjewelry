<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<article>
<h2>게시판</h2>
<div>
<table id="cartList">
	<tr><th>글 번호</th><th>제목</th><th>글쓴이</th><th>조회수</th><th>작성일자</th></tr>
	<c:forEach items="${boardList}" var="bvo">
		<tr><td>${bvo.NUM}</td><td><a href="mboardDetail?num=${bvo.NUM}">${bvo.TITLE}&nbsp;[${bvo.REPLYCOUNT}]</a></td><td>${bvo.USERID}</td><td>${bvo.READCOUNT}</td><td>${bvo.WRITEDATE}</td></tr>
	</c:forEach>
</table>
<form method="post" name="bdfrm">
	<input type="text" name="key" value="${key}" />
	<input  type="button" value="검색" onClick='go_search("bdfrm");' />
	<input  type="button" value="글쓰기" onClick='go_write("Board");' />
	<input  type="button" value="전체보기" onClick='go_mov_All("List");' />
</form>
</div>
<br/>
<jsp:include page="../include/paging.jsp">
	<jsp:param name="command" value="mboardList" />
</jsp:include>

</article>

<%@ include file="../include/footer.jsp" %>