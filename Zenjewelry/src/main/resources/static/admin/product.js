




function go_wrt(){
	document.frm.action = "adminProductWriteForm";
	document.frm.submit();
}




function go_save(){
	document.frm.action = "adminProductWrite";
	document.frm.submit();
}



function cal(){
	if( document.frm.price2.value == "" || document.frm.price1.value=="")return; 
	document.frm.price3.value = document.frm.price2.value - document.frm.price1.value; 
}



function go_detail( pseq ){
	var url = "adminProductDetail?pseq=" + pseq;
	document.frm.action = url; 
	document.frm.submit();
}


function go_mov(){
	location.href = "adminproductList";
}



function go_mod(pseq){
	var url = "adminProductUpdateForm?pseq=" + pseq;
	location.href=url;
	// document.frm.action = url;
	// document.frm.submit();
}




function go_mod_save(){
	if (document.frm.kind.value == '') {
		  alert('상품분류를 선택하세요'); 	  
			document.frm.kind.focus();
	 } else if (document.frm.name.value == '') {
		  alert('상품명을 입력하세요');	  
			document.frm.name.focus();
	 } else if (document.frm.price1.value == '') {
		  alert('원가를 입력하세요');	 
 		document.frm.price1.focus();
	 } else if (document.frm.price2.value == '') {
		  alert('판매가를 입력하세요');	  
			document.frm.price2.focus();
	 } else if (document.frm.content.value == '') {
		  alert('상품상세를 입력하세요');	  
			document.frm.content.focus();
	 }else{
		if( confirm('수정하시겠습니까?') ){
			 document.frm.action = "adminProductUpdate";
			 document.frm.submit();
		}
	}
}





function go_search(comm){
	if( document.frm.key.value=="") return;
	document.frm.action = comm + "?page=1";
	document.frm.submit();
}

function go_total(comm){
	document.frm.key.value="";
	document.frm.action =  comm + "?page=1";
	document.frm.submit();
}


function go_order_save(){

	// 현재 화면에 보여지고 있는 주문들의 체크박스들의 체크된 상태가  몇개나 체크되어 있는지 갯수를  count  합니다
	var count=0;
	if( document.frm.result.length == undefined ){   // 화면에 표시된 체크박스가 한개인경우
		if( cocument.frm.result.checked == true ) count++;
	}else{  //  화면에 표시된 체크박스가 두개 이상인경우
		for( var i=0; i<document.frm.result.length ; i++)
			if( document.frm.result[i].checked==true)
				count++;
	}
	// count  값이 0이면, 더 진행하지 않고 orderList.jsp  로 되돌아 갑니다
	if (count == 0) {
	    alert("주문처리할 항목을 선택해 주세요.");
	}else{  //  count  값이 1이상이라면, 현재 폼안에 있는 체크박스 밸류값들을 갖고, 처리완료로 처리하러 command=AdminOrderSave  로 이동
		document.frm.action = "adminOrderSave";
		document.frm.submit();
	}
	// 처리하고(주문의 result 값을 '1' -> '2' 로 변경)    orderList.jsp 로 되돌 아 옵니다.
}




function go_view( qseq ){
	location.href = "adminQnaDetail?qseq=" + qseq;
}



function go_rep(){
	document.frm.action="adminQnaRepSave";
	document.frm.submit();
	// 답변 글 등록 & rep 필드를 2로 업데이트
}

function save_rep(qna_num){
	if(document.frm.reply.value=="") {
		alert('메세지를 작성해주세요');
		return;
	}
	document.frm.action="adminProductQnaSave";
	document.frm.submit();
}



function go_removeQna(){

	var answer = confirm("Q&A를 삭제하시겠습니까?");
	if( answer ){
		document.frm.action= "adminDeleteProductQna";
		document.frm.submit();	
	}

}

function delete_mod(){

	var answer = confirm("제품을 삭제하시겠습니까?");
	if( answer ){
		document.formm.action= "adminDeleteProduct";
		document.formm.submit();	
	}

}

function uploadAdminImg(comm){
	var opt = "toolbar=no, menubar=no, resizable=no, width=550, height=300";
	var mapping = 'upload' + comm + 'Img';
	window.open(mapping, '대표이미지 업로드', opt);
}

function uploadedThumbImg(){
	document.frm.submit();
}

function uploadedDetailImg(){
	document.frm.submit();
}



function delete_mem(){
	var answer = confirm("회원을 삭제하시겠습니까?");
	if( answer==false ){
		return false;
	}else{
	return true;
	}
}


function save_option_mem(){
	var answer = confirm("회원정보를 저장하시겠습니까?");
	if( answer ){
	 document.formm.action= "saveOptionMember";
	 document.formm.submit();	
	}
	else return false;
}	



function createPartition(){
	document.frm.action = 'adminPromotionWrite';
	document.frm.submit();
}



function findProduct(outnum){
	var find_pseq = "find_pseq" + outnum;
	var pseq = document.getElementById(find_pseq).value;
	
	var opt = "toolbar=no, menubar=no, resizable=no, width=550, height=300";
	window.open('findProduct?pseq=' + pseq + '&outnum=' + outnum, '상품검색', opt);
}



function addProduct(outnum){
	var accesspseq = 'accesspseq' + outnum;
	var accessname = 'accessname' + outnum;
	var accessprice2 = 'accessprice2' + outnum;
	
	var pseq = document.getElementById(accesspseq).value;
	var name = document.getElementById(accessname).value;
	var price2 = document.getElementById(accessprice2).value;
	
	var partition = 'partition' + outnum;
	
	var newP = document.createElement('p');
	
	var add = '<input type="checkbox" name="pseq' + outnum + '" value="' + pseq + '" checked />&nbsp;&nbsp;' 
		+ name + '&nbsp;&nbsp;'
		+ '<input type="text" name="price2' + outnum + '" value="' + price2 + '" />';
	
	newP.innerHTML = add;
	document.getElementById(partition).appendChild(newP);
	
}



function uploadImg(comm){
	var opt = "toolbar=no, menubar=no, resizable=no, width=550, height=300";
	window.open('uploadPromotionImg?where='+comm, '이미지 업로드', opt);
}

function uploadedImg(comm){
	document.frm.action = 'uploadPromotionFile?where=' + comm;
	document.frm.submit();
}

function message(msg){
			alert(msg);
		}





var selectBoxChange = function(value){
		console.log("값변경테스트 : "+value);
		$("#changeInput").val(value);
}























