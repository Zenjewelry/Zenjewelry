<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../include/adminheaderfooter/header.jsp" %>
<article>
<h1>회원리스트</h1>  <br>

<form name="formm" method="post">
<table id="cartList2">

	<tr><th width="100">아이디</th><th width="100"> 이름 </th><th width="120">이메일</th>
	<th width="90">우편번호</th><th width="400">주소</th><th width="200">전화</th><th width="100">가입일</th>
	<th width="100">회원관리</th><th width="100">삭제</th></tr>
	

   <c:forEach items="${memberlist}" var="memberVO" varStatus="index">
   
	    <tr><td>${memberVO.ID} </td>
	    	<input type="hidden" name="id${index.count}" value="${memberVO.ID}" />
	    	<td>${memberVO.NAME}</td><td>${memberVO.EMAIL}</td><td>${memberVO.ZIP_NUM}</td><td>${memberVO.ADDRESS}</td>
	    	<td>${memberVO.PHONE}</td><td><fmt:formatDate value="${memberVO.INDATE}"/>       		
       		
       		<td>
       			<select name = "black${index.count}">
       			    <option value ="${memberVO.USEYN }" selected>${memberVO.USEYN }</option>
          			<option value = "사용">사용</option>
          			<option value = "휴면">휴면</option>
          			<option value = "블랙">블랙</option>
          			<option value = "일시정지">일시정지</option>
       			</select>
       		</td>
       		
       		<td style="width:100px;">
				<input class="btn" type="button" value="삭제" onclick="delete_mem('${memberVO.ID}');">
       		</td>
       	</tr>
  </c:forEach>


</table>
<input type="hidden" name="memListSize" value="${memListSize}" />

<table id="cartList2">
	<tr><td width="670">회원 이름 <input type="text" name="key" value="${key}">
	<input class="btn" type="button" value="검색" onclick="go_search('adminMemberList')">
	<input class="btn" type="button" name="btn_total" value="전체보기 "	onClick="go_total('adminMemberList')">
	<input class="btn" type="button" value="저장" onclick="save_option_mem()">
	</td> </tr>
</table>
</form>
<br>
<jsp:include page="../../include/page/paging.jsp">   
<jsp:param value="adminMemberList" name="command"/>
</jsp:include>

</article>


<%@ include file="../../include/adminheaderfooter/footer.jsp" %>