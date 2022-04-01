<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/adminheaderfooter/header.jsp" %>
<article>
<h1>Q&amp;A 게시글 리스트</h1><br>
<form name="frm" method="post">
<table id="cartList2">
	<tr><th>번호(답변여부)</th><th>제목</th><th>작성자</th><th>작성일</th></tr>
	<c:forEach items="${qnaList}" var="qnaVO">
		<tr><td>${qnaVO.QSEQ}
			<c:choose>
				<c:when test='${qnaVO.REP=="1"}'>(미처리)</c:when>
				<c:otherwise>(답변처리완료)</c:otherwise>
			</c:choose></td>
			<td><a href="#" onClick="javascript:go_view('${qnaVO.QSEQ}')">${qnaVO.SUBJECT}</a></td>
			<td>${qnaVO.ID}</td><td><fmt:formatDate value="${qnaVO.INDATE}"/></td></tr>
	</c:forEach>
</table>

<table id="cartList2">
	<tr><td width="670">제목+내용 검색
		<input type="text" name="key" value="${key}">
			<input class="btn" type="button" value="검색" onClick="go_search('adminQnaList');">
			<input class="btn" type="button" name="btn_total" value="전체보기" onClick="go_total('adminQnaList');">
		</td></tr>
</table>
</form>
<br>
<jsp:include page="/admin/paging/paging.jsp">
	<jsp:param name="command" value="shop.do?command=adminQnaList" />
</jsp:include>
</article>
<%@ include file="../include/adminheaderfooter/footer.jsp" %>