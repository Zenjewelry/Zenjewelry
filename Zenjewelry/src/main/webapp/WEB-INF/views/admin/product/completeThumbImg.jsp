<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	opener.frm.image.value='${thumbImage}';
	opener.document.getElementById('previewThumbText').innerHTML = '${thumbImage}';
	opener.document.getElementById('previewThumbImg').setAttribute('src', '/product_images/' + '${thumbImage}');
	opener.document.getElementById('previewThumbImg').style.display='inline';
	self.close();
</script>
</head>
<body>

</body>
</html>