<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<article style="width: 700px;" >
<div id="itemdetail"  style="float:left;">
<h1>Item</h1>
<form  method="post" name="formmm">
	<fieldset>	<legend> Item detail Info</legend>
		<span style="float: left; margin-right:20px;">
			<img  src="product_images/${productVO.IMAGE}" 
			style="width: 350px; height: 350px; object-fit: cover;"/></span>              
       	<h2> ${productVO.NAME} </h2>  
		<label>가 격 : </label>
		<p>
			<c:choose>
				<c:when test="${not empty prmprice}">
					<p><fmt:formatNumber value="${prmprice}" type="currency" /> 원</p>
				</c:when>
				<c:otherwise>
					<p><fmt:formatNumber value="${productVO.PRICE2}" type="currency"/> 원</p>
				</c:otherwise>
			</c:choose>
		</p>
		<label>순 도 : </label>
			<select name="option1" id="option1" onChange="updatePrice();"><option value="">선택(필수)</option>
				<c:forEach items="${option1}" var="option">
					<option value="${option.OPTION1}">${option.OPTION1}</option>
				</c:forEach>
			</select>
		<label>사이즈 : </label>
			<select name="option2" id="option2" onChange="updatePrice();"><option value="">선택(필수)</option>
				<c:forEach items="${option2}" var="option">
					<option value="${option.OPTION2}">${option.OPTION2}</option>
				</c:forEach>
			</select>
		<label>색 상 : </label>
			<select name="option3" id="option3" onChange="updatePrice();"><option value="">선택(필수)</option>
				<c:forEach items="${option3}" var="option">
					<option value="${option.OPTION3}">${option.OPTION3}</option>
				</c:forEach>
			</select>
       	<label>수 량 : </label><input  type="text" name="quantity" id="quan" size="2" value="1" onChange="updatePrice();"><br>
       	<label>재 고 : </label><p id="sku"></p>
       	<label>최종 결제가격 : </label>
       		<p>
				<c:choose>
					<c:when test="${not empty prmprice}">
						<p id="viewPrice"><fmt:formatNumber value="" type="currency" /> 원</p>
						<input type="hidden" name="sellprice" id="sellprice" value="${prmprice}" />
						<input type="hidden" id="firstsellprice" value="${prmprice}" />
					</c:when>
					<c:otherwise>
						<p id="viewPrice"><fmt:formatNumber value="" type="currency"/> 원</p>
						<input type="hidden" name="sellprice" id="sellprice" value="${productVO.PRICE2}" />
						<input type="hidden" id="firstsellprice" value="${productVO.PRICE2}" />
					</c:otherwise>
				</c:choose>
			</p>
       	<label>제품설명 : </label><label>${productVO.CONTENT}</label><br>
       	<input  type="hidden" name="pseq"	 value="${productVO.PSEQ}"><br>
	<c:forEach items="${options}" var="option">
		<input type="hidden" id="${option.OPTION1}${option.OPTION2}${option.OPTION3}" value="${option.CHANGEPRICE}" />
		<input type="hidden" id="${option.OPTION1}${option.OPTION2}${option.OPTION3}_sku" value="${option.SKU}" />
	</c:forEach>
	</fieldset>
	<div class="clear"></div>
	<div id="buttons">
		<!-- <input type="button" value="장바구니에 담기"  onClick="go_cart();"> -->
		<input class="cancel" type="button" value="장바구니에 담기" onClick="go_cart()" />
		<input class="cancel" type="button" value="즉시 구매" onClick="go_order_one()" />
	<!-- 	<input type="button" value="즉시 구매"  onClick="go_order();">  -->
		<input type="reset"  value="취소" 	class="cancel">
		<br><br><br><br>
		<span style="float: left; margin-right:20px;">
			<img  src="product_images/${productVO.DETAIL_IMAGE}" 
			style="width: 700px;  object-fit: cover;"/></span>   
	</div>
</form>
</div>

<br><br><br><br>

<h2> Q&A </h2>

<h3> 제품에 대한 질문을 운영자가 답변을 드립니다.</h3>
<form name="formm" method="post">
<table id="cartList">
	<tr>	<th>번호</th><th>제목</th><th>내용</th><th>등록일</th><th>답변 여부</th></tr>
		<c:forEach items="${product_QnaVO}" var="product_QnaVO">
		<tr ><td><input  type="hidden" name="qnanum"  value="${product_QnaVO.QNA_NUM}"> ${product_QnaVO.QNA_NUM}</td>    
    		<td><a href="mproductQnaView?qna_num=${product_QnaVO.QNA_NUM}">${product_QnaVO.SUBJECT}</a></td>   
    		<td>${product_QnaVO.CONTENT}</td>      
       		<td><fmt:formatDate value="${product_QnaVO.INDATE}" type="date"/></td>
       		<td><c:choose>
				<c:when test="${product_QnaVO.REP==1}"> 답변예정 </c:when>
				<c:when test="${product_QnaVO.REP==2}"><span style="font-weight:bold; color:red"> 답변완료 </span></c:when>
			</c:choose></td>  
			  
   		</tr>
   		</c:forEach>
</table>
<br>
<br>
</form>
<form method="post" action="mwriteProductqna" style="bottom:1000px;">
<h2>Q&A 작성</h2>
<fieldset> 
	<label>Title</label><input type="text" name="subject"  size="60" ><br>
	<label>Content</label><textarea rows="8" cols="65" name="content"></textarea>
	<label>Q&A password</label><input type="password" name="pwd"  size="30" ><br>
	<input  type="hidden" name="pseq"	 value="${productVO.PSEQ}">
		
</fieldset>
<input type="submit" value="Q&A 등록" class="submit" />
<input type="reset"   value="취소"     class="cancel">
	
</form>

</article>

<br><br><br><br>
<%@ include file="../include/footer.jsp" %>