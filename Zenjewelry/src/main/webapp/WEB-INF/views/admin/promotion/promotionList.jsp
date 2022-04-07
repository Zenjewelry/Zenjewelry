<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>

<h1>프로모션리스트</h1><br>

<form name="frm" method="post">

<label>노출 관리</label>
<select name="apm"><!-- adminPromotionManagement -->
	<option value="none">비노출</option>
	<option value="main">메인노출</option>
</select>
<input type="button" value="적용" onClick="adminPromotionManagement();" />

<table id="cartList2">
	<tr><th>(선택)프로모션 번호</th><th>메인 카피라이트</th><th>서브 카피라이트</th><th>메인배너 미리보기</th></tr>
	<c:forEach items="${promotionList}" var="promotionVO">
		<tr>
			<td>
				<input type="radio" name="result" value="${promotionVO.PRMSEQ}">
				<span style="font-weight: bold; color: blue">${promotionVO.PRMSEQ}</span>
			</td>
			<td>
				<a href="editPromotion?prmseq=${promotionVO.PRMSEQ}">${promotionVO.MAIN_SUBJECT}</a>
			</td>
			<td>
				<a href="editPromotion?prmseq=${promotionVO.PRMSEQ}">${promotionVO.SUB_SUBJECT}</a>
			</td>
			<td><img src="/promotion_images/${promotionVO.BANNER}" height="150" /></td>
		</tr>
	</c:forEach>
</table>

	<table id="cartList2">
		<tr><td width="670">프로모션 검색(메인+서브 카피라이트)<input type="text" name="key" value="${key}" >
			<input class="btn" type="button" value="검색" 	onClick="go_search('promotionList');">
			<input class="btn" type="button" name="btn_total" value="전체보기 " onClick="go_total('promotionList');">
			<input type="button" class="btn" style="width: 200px" value="프로모션 등록" onClick="location.href='adminPromotionWrite'"></td></tr>
	</table>
<br>

	<jsp:include page="../../include/page/paging.jsp" >
		<jsp:param name="command" value="adminOrderList"/>
	</jsp:include>

</form>
</article>

<%@ include file="../../include/adminheaderfooter/footer.jsp" %>