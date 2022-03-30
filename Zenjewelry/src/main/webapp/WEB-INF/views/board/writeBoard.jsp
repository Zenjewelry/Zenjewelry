<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/headerfooter/header.jsp" %>

<article>
<h2>게시글 작성</h2>
<form name="wbfrm">
	<fieldset class="input-box">
		<input type="hidden" name="id" value="${loginUser.ID}" />

			<label>글 제목</label><input type="text" name="title" />
			<label>본문 내용</label><textarea rows="8" cols="70" name="content"></textarea>
			<hr />
			<label>이미지 업로드</label><input type="button" name="uploadImg" onClick="uploadImg();" />
			<label>이미지명</label><div id="previewText" style="float:left;" ></div>
			<label>Preview</label><img src="" id="previewImg" width="300" height="300" style="display:none;" />
			<input type="hidden" name="pictureurl" value="" />
			<hr />
	</fieldset>			
		<div id="buttons">
			<input class="submit" type="button" value="게시글 등록" onClick="go_save1('write');">
			<input class="cancel" type="button" value="목록" onClick="go_mov1('List');">
		</div>
	</form>
</article>
<%@ include file="../include/headerfooter/footer.jsp" %>