<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>

<article>

<h1>주문리스트</h1><br>

<form name="frm" method="post">

<table id="cartList2">
	<tr><th>주문번호(처리)</th><th>주문자</th><th>상품명</th><th>수량</th><th>우편</th><th>주소</th><th>전화</th><th>주문일</th></tr>
	<c:forEach items="${orderList}" var="orderVO">
		<tr><td><c:choose>
			<c:when test='${orderVO.RESULT=="1"}'>
				<span style="font-weight: bold; color: blue">${orderVO.OSEQ}</span>
				(<input type="checkbox" name="result" value="${orderVO.ODSEQ}">미처리)</c:when>
	    	<c:otherwise>
       			<span style="font-weight: bold; color: red">${orderVO.OSEQ}</span>
      			(<input type="checkbox" checked="checked" disabled="disabled">처리완료)</c:otherwise>
			</c:choose></td>
			<td>${orderVO.MNAME}</td><td>${orderVO.PNAME}</td><td>${orderVO.QUANTITY}</td>
			<td>${orderVO.ZIP_NUM}</td><td>${orderVO.ADDRESS}</td> <td>${orderVO.PHONE}</td>
			<td><fmt:formatDate value="${orderVO.INDATE}" /></td></tr>
	</c:forEach>
</table>

	<table id="cartList2">
		<tr><td width="670">주문자 이름<input type="text" name="key" value="${key}" >
			<input class="btn" type="button" value="검색" 	onClick="go_search('adminOrderList');">
			<input class="btn" type="button" name="btn_total" value="전체보기 " onClick="go_total('adminOrderList');">
			<input type="button" class="btn" style="width: 200px" value="주문처리(입금확인)" onClick="go_order_save()"></td></tr>
	</table>
<br>

<jsp:include page="/admin/paging/paging.jsp" >
	<jsp:param name="command" value="shop.do?command=adminOrderList"/>
</jsp:include>


</form>
<br>



</article>







<%@ include file="../../include/adminheaderfooter/footer.jsp" %>