<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
<article>
<h2>게시판</h2>
<form name="formm" method="post" >
<table id="cartList">
<input  type="hidden" name="num" value="${boardVO.NUM}">
<tr><th>글 번호</th><td width="500" style="text-align:left;">${boardVO.NUM}</td></tr>
<tr><th>조회수</th><td width="500" style="text-align:left;">${boardVO.READCOUNT}</td></tr>
<tr><th>작성일 </th><td width="500" style="text-align:left;">${boardVO.WRITEDATE}</td></tr>
<tr><th>작성자</th><td width="500" style="text-align:left;">${boardVO.USERID}</td></tr>
<tr><th>글 제목</th><td width="500" style="text-align:left;"> ${boardVO.TITLE}</td></tr>
<tr><th>글 본문</th><td width="500" style="text-align:left;"> ${boardVO.CONTENT}</td></tr>
<tr><th>첨부이미지</th><td width="500"  > <img src="board_images/${boardVO.PICTUREURL}" style="position:relative; width: 350px; height: 400px; object-fit: cover;"/></td></tr>
</table>

<div id="buttons">
	<c:if test="${loginUser.ID == boardVO.USERID}">
		<input class="submit" type="button" value="수정" onClick="location.href='editBoard?boardnum=${boardVO.NUM}'" />
		<input class="cancel" type="button" value="삭제" onClick="delete_Board()" />
	</c:if>
	<input class="cancel" type="button" value="되돌아가기" onClick="go_mov1('List');" />
</div>


</form>
</article>

<article>
<form method="post" name="rpfrm">
	<input type="hidden" name="boardnum" value="${boardVO.NUM}" />
	<c:choose>
	<c:when test="${loginUser.ID != null}">
		<div>댓글쓰기 <input type="text" name="reply" width="500px" /><input type="button" value="작성" onClick="writeReply();" /></div>
	</c:when>
	<c:otherwise>
		<div>댓글쓰기 <input type="text" value="댓글작성은 로그인 후 이용 가능한 서비스입니다." readonly width="500px" /><input type="button" value="작성" onClick="" /></div>
	</c:otherwise>
	</c:choose>
</form>

<table id="cartList">
<tr><td>작성자</td><td>내용</td><td>작성일</td><td>삭제하기</td></tr>
<c:forEach items="${replyVO}" var="rvo">
	<tr><td>${rvo.USERID}</td><td>${rvo.CONTENT}</td><td>${rvo.WRITEDATE}</td>
	<td><c:if test="${rvo.USERID == loginUser.ID}"><input type="button" value="삭제" onClick="location.href='deleteReply?reply_num=${rvo.REPLY_NUM}&boardnum=${boardVO.NUM}'" /></c:if></td></tr>
</c:forEach>
</table>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>