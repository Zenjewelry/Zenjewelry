<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
	opener.document.getElementById('product_name').innerHTML
	= '조회된 상품 : '+'<div>' + '${output.NAME}' + '</div>'+
	'<input type="hidden" id="accessname'+'${outnum}'+'" value="'+'${output.NAME}'+'" />'+
	'<input type="hidden" id="accesspseq'+'${outnum}'+'" value="'+'${output.PSEQ}'+'" />'+
	'<input type="hidden" id="accessprice2'+'${outnum}'+'" value="'+'${output.PRICE2}'+'" />';
	
	self.close();
	
</script>
</head>
<body>

</body>
</html>