<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header.jsp</title>
<link href="/css/mobile.css" rel="stylesheet">  
<script src="/script/jquery-3.6.0.js"></script>
<script src="/script/member.js"></script>
<script src="/script/mypage.js"></script>
<script src="/script/basic.js"></script>
</head>
<body>

<div id="wrap1">
	<div id="logo"><!-- 메인 로고 이미지 -->
		<a href="/">
			<img src="images/logo_yw.png"  height="130" />
		</a>
	</div>
	<form method="post" name="hdfrm">
		<div id="search"><!-- 돋보기모양 검색창 -->
			<!-- <img  id= "s-img" src="images/search1.png" width="30px" /> -->
			<input id= "s-box" type="text" name="key" value="${key}" />
			<img  id= "s-img" src="images/search1.png" width="30px" onClick='go_search("hdfrm");' />
			<!-- <input id="sbutton" type="button" value="검색" onClick='go_search("hdfrm");' /> -->
		</div>
	</form>
	
	<nav id="top_menu"><!-- 상단 메뉴 : 로그인 CART MyPage 등-->
		<ul>
			<c:choose>
				<c:when test="${empty loginUser}">
					<li><a class="Rm" href="loginForm">LOGIN</a></li>
					<li><a class="Rm" href="contract">JOIN</a></li>
				</c:when>
				<c:otherwise>
					<li><a class= "Id01">${loginUser.NAME}(${loginUser.ID})</a></li>
					<li><a class="Rm" href="myPage">MYPAGE</a></li>
					<li><a class="Rm" href="editForm">EDIT</a></li>
					<li><a class="Rm" href="logout">LOGOUT</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>
</div>
<header id="wrap2"><!-- 로고, 주상단메뉴, 카테고리 메뉴 등이 표시되는 영역 -->
	
	<nav id="catagory_menu"><!-- 카테고리 메뉴 Heels Boots Sandals 등-->
		<ul>
			<li><img class="Lm" id="hmBtn" src="images/Hbutton.png" style="cursor:pointer" width="70" height="70" /></li>
			<li><a class="Lm" href="bestProductList?sub='y'">BEST</a></li>
			<li><a class="Lm" href="productList?kind=1&sub='y'">RING</a></li>
			<li><a class="Lm" href="productList?kind=2&sub='y'">EARRINGS</a></li>
			<li><a class="Lm" href="productList?kind=3&sub='y'">NECKLACE</a></li>
			<li><a class="Lm" href="productList?kind=4&sub='y'">BRACELET</a></li>
			<li><a class="LmR" href="cartList">CART</a></li>
			<li><a class="LmR" href="boardList?sub='y'">BOARD</a></li>
			<li><a class="LmR" href="qnaList?sub='y'" >Q&amp;A</a></li>
		</ul>
	    
	</nav>
	
	<!-- 햄버거 카테고리 수직메뉴(드롭다운) -->
<div class="dropdown">    
	<div class="ddBtn"><a href="bestProductList?sub='y'">&nbsp;&nbsp;&nbsp;BEST</a></div>
	<div class="ddBtn"><a href="productList?kind=1&sub='y'">&nbsp;&nbsp;&nbsp;RING</a></div>
	<div class="ddBtn"><a href="productList?kind=2&sub='y'">&nbsp;&nbsp;&nbsp;EARRINGS</a></div>
	<div class="ddBtn"><a href="productList?kind=3&sub='y'">&nbsp;&nbsp;&nbsp;NECKLACE</a></div>
	<div class="ddBtn"><a href="productList?kind=4&sub='y'">&nbsp;&nbsp;&nbsp;BRACELET</a></div>
	<div class="ddBtn"><a href="cartList">&nbsp;&nbsp;&nbsp;CART</a></div>
	<div class="ddBtn"><a href="boardList?sub='y'">&nbsp;&nbsp;&nbsp;BOARD</a></div>
	<div class="ddBtn"><a href="qnaList?sub='y'">&nbsp;&nbsp;&nbsp;Q&amp;A</a></div>
</div>	
</header>


