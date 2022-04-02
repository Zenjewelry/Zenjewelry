<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>
<h1>상품 Q&amp;A 리스트</h1><br>
<form name="frm" method="post" >

<table id="cartList2">
	<tr>	<th>번호</th><th>아이디</th><th>상품번호</th><th>제목</th><th>내용</th><th>답변</th><th>등록일</th><th>답변 여부</th></tr>
		<c:forEach items="${productList}" var="productList">
		<%-- <input  type="hidden" name="pseq" value="${productList.pseq}"> --%>
		<tr ><td><input  type="hidden" name="qnanum" value="${productList.QNA_NUM}"> ${productList.QNA_NUM}</td>    
    		<td>${productList.ID}</td>  
    		<td>${productList.PSEQ}</td>  
    		<td><a href="shop.do?command=adminProductQnaView&qnanum=${productList.QNA_NUM}">${productList.SUBJECT}</a></td>   
    		<td>${productList.CONTENT}</td>      
    		<td>${productList.REPLY}</td>      
       		<td><fmt:formatDate value="${productList.INDATE}" type="date"/></td>
       		<td><c:choose>
				<c:when test="${productList.REP==1}"> 답변예정 </c:when>
				<c:when test="${productList.REP==2}"><span style="font-weight:bold; color:red"> 답변완료 </span></c:when>
			</c:choose></td>    
   		</tr>
   	</c:forEach>
</table>

<table id="cartList2">
	<tr><td width="670">검색<input type="text" name="key" value="${key}" >
		<input class="btn" type="button" value="검색" 	onClick="go_search('adminProduct_Qna');">
		<input class="btn" type="button" name="btn_total" value="전체보기 " onClick="go_total('adminProduct_Qna');">
		</td></tr>
</table>
</form>
<br>


<jsp:include page="/admin/paging/paging.jsp" >
	<jsp:param name="command" value="shop.do?command=adminProduct_Qna"/>
</jsp:include>

</article>

<%@ include file="../../include/adminheaderfooter/footer.jsp" %>