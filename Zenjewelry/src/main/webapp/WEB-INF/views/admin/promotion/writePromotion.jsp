<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>

<form name="frm">
	<table>
		<tr><th>메인 기획전명</th><td><input type="text" name="main_subject" value="${promotionVO.main_subject}" /></td></tr>
		<tr><th>서브 기획전명</th><td><input type="text" name="sub_subject" value="${promotionVO.sub_subject}" /></td></tr>
		<tr><th>메인 배너 업로드</th><td><input type="button" value="찾아보기" onClick="uploadImg('PromotionMain');" /></td></tr>
		<tr><th>메인 배너 이미지명</th><td><div id="previewBannerText">${promotionVO.banner}</div></td></tr>
		<tr><th>메인 배너 미리보기</th><td><img src="/promotion_images/${promotionVO.banner}" id="previewBannerImg" width="300" height="300" style="display:none;" />
			<input type="hidden" name="banner" value="${promotionVO.banner}" /></td></tr>
		<tr>
			<th>시작일자 ~ 종료일자</th>
			<td>
				<select name="sYear">
					<c:forEach begin="2022" end="2030" var="index">
						<c:choose>
							<c:when test="${sYear == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>&nbsp;- &nbsp;
				<select name="sMonth">
					<c:forEach begin="1" end="12" var="index">
						<c:choose>
							<c:when test="${sMonth == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>&nbsp;-&nbsp;
				<select name="sDay">
					<c:forEach begin="1" end="31" var="index">
						<c:choose>
							<c:when test="${sDay == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<h3>&nbsp;~&nbsp;</h3>
				<select name="eYear">
					<c:forEach begin="2022" end="2030" var="index">
						<c:choose>
							<c:when test="${eYear == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>&nbsp;- &nbsp;
				<select name="eMonth">
					<c:forEach begin="1" end="12" var="index">
						<c:choose>
							<c:when test="${eMonth == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>&nbsp;-&nbsp;
				<select name="eDay">
					<c:forEach begin="1" end="31" var="index">
						<c:choose>
							<c:when test="${eDay == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th>구분자 개수</th>
			<td>
				<select name="outnumber_chk">
					<c:forEach begin="1" end="10" var="index">
						<c:choose>
							<c:when test="${outnumber_chk == index}">
								<option value="${index}" selected="selected">${index}</option>
							</c:when>
							<c:otherwise>
								<option value="${index}">${index}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				&nbsp;&nbsp;<input type="button" value="구분자 생성" onClick="createPartition();" />
			</td>
		</tr>
	</table>
	<hr />
	<!-- 구분자 섹션 -->
	<c:forEach begin="1" end="${outnumber_chk}" var="outnumber">
		<table <%-- id="partition${outnumber}" --%>>
			<tr><th>Summary 배너 업로드</th><th>Summary 배너 이미지명</th><th>Summary 배너 미리보기</th></tr>
			<tr>
				<td><input type="button" value="찾아보기" onClick="uploadImg('Summary');" /></td>
				<td><div id="previewBannerText">${promotionVO.banner}</div></td>
				<td><img src="/promotion_images/${promotionVO.banner}" id="previewBannerImg" width="300" height="300" style="display:none;" />
					<input type="hidden" name="banner" value="${promotionVO.banner}" /></td>
			<tr>
			<tr><td colspan="3" style="background:black;"></td></tr>
			<tr>
				<th>추가할 상품코드</th>
				<td><input type="text" id="find_pseq${outnumber}" onChange="findProduct('${outnumber}');"/></td>
				<td><div id="product_name${outnumber}"></div><input type="button" value="추가" onClick="addProduct('${outnumber}');" /></td>
			</tr>
		</table>
		<div id="partition${outnumber}"></div>
		<hr />
	</c:forEach>
	
</form>

</article>

<%@ include file="../../include/adminheaderfooter/footer.jsp" %>