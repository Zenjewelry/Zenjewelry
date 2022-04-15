<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>
<article>

<h1 style="text-align:center;">Q&amp;A 게시판</h1><br>

<form name="frm" method="post">
<input type="hidden" name="qseq" value="${qnaVO.QSEQ}">

<table id="cartList"><!-- 게시물의 내용 -->
	<tr><th width="20%">제목</th><td align="left">${qnaVO.SUBJECT} ${qnaVO.REP}</td></tr>
	<tr><th>등록일</th><td align="left"><fmt:formatDate value="${qnaVO.INDATE}"/></td></tr>
	<tr><th>내용</th><td align="left">${qnaVO.CONTENT}</td></tr>
</table>
<!-- 관리자가 쓴 답글 또는 답글 쓰는 입력란 표시 -->
<c:choose>
	<c:when test='${qnaVO.REP=="1"}'><!-- 관리자 답변 전 표시 -->
		<table id="cartList">
			<tr><td colspan="2"><textarea name="reply"  rows="3" cols="90"></textarea>
				<input type="button" class="btn" value="저장" onClick="go_rep()"></td></tr>
		</table>
	</c:when>
	<c:otherwise><!-- 관리자 답변 완료 후 표시 -->
		<table id="cartList" style="margin-top:-5px"><tr><th width="20%">댓글</th><td>${qnaVO.REPLY}</td></tr></table>
	</c:otherwise>
</c:choose>
<input type="button" class="btn" value="목록" onClick="location.href='adminQnaList'">
</form>
</article>
<%@ include file="../../include/adminheaderfooter/footer.jsp" %>