<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	opener.frm.detail_image.value='${detailImage}';
	opener.document.getElementById('previewDetailText').innerHTML = '${detailImage}';
	opener.document.getElementById('previewDetailImg').setAttribute('src', '/product_images/' + '${detailImage}');
	opener.document.getElementById('previewDetailImg').style.display='inline';
	self.close();
</script>
</head>
<body>

</body>
</html>