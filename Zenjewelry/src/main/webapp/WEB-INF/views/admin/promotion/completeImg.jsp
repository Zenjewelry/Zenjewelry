<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

var text = 'preview' + '${where}' + 'Text';
var img = 'preview' + '${where}' + 'Img';

var newP = document.createElement('p');
var add = '<input type="hidden" name="' + '${where}' + '" value="'+ '${image}' +'" />';
newP.innerHTML = add;
opener.document.getElementById('hiddenimage').appendChild(newP);

opener.document.getElementById(text).innerHTML = '${image}';
opener.document.getElementById(img).setAttribute('src', '/promotion_images/' + '${image}');
opener.document.getElementById(img).style.display='inline';
self.close();

</script>
</head>
<body>

</body>
</html>