<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>
<article>
	<form name="wbfrm" method="post">
		<input type="hidden" name="num" value="${boardVO.NUM}" />
			<fieldset class="input-box"><h2>게시물 수정</h2>
				<label>글 제목</label><input type="text" name="title" value="${boardVO.TITLE}" width="300px"/>
				<label>글 본문</label><textarea rows="5" cols="70" name="content">${boardVO.CONTENT}</textarea>
			<hr>
			<label>이미지 업로드</label><input type="button" value="찾아보기" onClick="uploadImg();" />
			<label>이미지명</label><div id="previewText">${boardVO.PICTUREURL}</div>
			<label>Preview</label><img src="board_images/${boardVO.PICTUREURL}" id="previewImg" width="300" height="300" /><br />
			<input type="hidden" name="pictureurl" value="" />
			<hr />
		</fieldset>
		<hr>
			<input class="submit" type="button" value="수정" onClick="go_save1('edit');" />
			<input class="cancel" type="reset" value="다시 작성" />
			<input class="cancel" type="button" value="되돌아가기" onClick="go_mov1('Detail');" />
</form>
</article>

<%@ include file="../include/headerfooter/footer.jsp" %>