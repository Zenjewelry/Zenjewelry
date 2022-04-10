<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../script/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="../css/shopping.css">
<script type="text/javascript" src="../admin/product.js"></script>
</head>
<body>

<div id="wrap1">
	<div id="logoA">
		<a href="/">
			<img src="images/logo_yw.png"  height="150"/>
		</a>
	</div>
	
	<nav id="top_menu">
		<ul>
			<li><a id="RAm5"  href='adminLogout'>LOGOUT</a></li>
		</ul>
	</nav>
</div>

<div id="wrap2">
<header>

	<nav id="catagory_menu">
		<ul>
			<li><a class="LmR"  href='adminproductList?sub="y"'>상품리스트</a></li>
			<li><a class="LmR" href='adminOrderList?sub="y"'>주문리스트</a></li>
			<li><a class="LmR" href='adminMemberList?sub="y"'>회원리스트</a></li>
			<li><a class="LmR" href='adminQnaList?sub="y"'>Q&amp;A리스트</a></li>
			<li><a class="LmR" href='adminProduct_Qna?sub="y"'>Product Q&amp;A리스트</a></li>
			<li><a class="LmR" href='promotionList?sub="y"'>프로모션리스트</a></li><!-- adminPromotionWrite -->
		</ul>
	</nav>
</header>			
</div>	
				
<div class="clear"></div>










