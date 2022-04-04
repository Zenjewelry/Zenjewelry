<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>

<form name="frm" action="insertPromotion" method="post">
	<table>
		<tr><th>메인 기획전명</th><td>${promotionVO.MAIN_SUBJECT}</td></tr>
		<tr><th>서브 기획전명</th><td>${promotionVO.SUB_SUBJECT}</td></tr>
	</table>
</form>

</article>

<%@ include file="../../include/adminheaderfooter/footer.jsp" %>