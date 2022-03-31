<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article>
<form name="qnalist" method="post" action="shop.do">
<input  type="hidden" name="pseq" value="${product_QnaVO.PSEQ}">
<table id="cartList">
<tr><th>글 번호</th><td width="500" style="text-align:left;">${product_QnaVO.QNA_NUM}</td></tr>
<tr><th>작성일 </th><td width="500" style="text-align:left;">${product_QnaVO.INDATE}</td></tr>
<tr><th>작성자</th><td width="500" style="text-align:left;">${product_QnaVO.ID}</td></tr>
<tr><th>글 제목</th><td width="500" style="text-align:left;"> ${product_QnaVO.SUBJECT}</td></tr>
<tr><th>글 본문</th><td width="500" style="text-align:left;"> ${product_QnaVO.CONTENT}</td></tr>
<tr><th>답변</th><td width="500" style="text-align:left; color:blue; "> ${product_QnaVO.REPLY}</td></tr>
<tr><th>답변 여부</th><td><c:choose>
				<c:when test="${product_QnaVO.REP==1}"> 답변예정 </c:when>
				<c:when test="${product_QnaVO.REP==2}"><span style="font-weight:bold; color:red; text-align:left;" > 답변완료 </span></c:when>
			</c:choose></td></tr>
</table>
</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>