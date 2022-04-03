function go_cart(){
	if (document.formmm.quantity.value == "") {
	    alert("수량을 입력하여 주세요.");
	    document.formmm.quantity.focus();
	}else{
		document.formmm.action ="cartInsert";
		document.formmm.submit();
	}
}




function go_cart_delete(){

	var count = 0; 
	
	if(document.formm.cseq.length==undefined){   
		if( document.formm.cseq.checked == true )
			count++;
	}else{  // 체크박스가 두개 이상일때
		for( var i=0; i< document.formm.cseq.length ; i++){
			if( document.formm.cseq[i].checked == true )
				count++;
		}
	}	
	
	if( count == 0 ){
		alert("삭제할 항목을 선택해주세요");
	} else{
		document.formm.action = "cartDelete";
	    document.formm.submit();
	}
}

/*

function go_order_insert(){

	document.formm.action ="orderInsert";
	document.formm.submit();
	
	
}
*/




function go_order_one(){
	document.formmm.action ="orderOne";
	document.formmm.submit();
}



function zip_update_delivery(){
	if(document.formm.pwd.value != document.formm.pwdCheck.value){
		alert("비밀번호가 틀렸습니다.");
	}else if(document.formm.zip_num.value==""){
		alert("우편번호를 확인하세요.");
	}else if(document.formm.address.value==""){
		alert("기본주소를 확인하세요.");
	}else if(document.formm.address2.value==""){
		alert("상세주소를 확인하세요.");
	}else{
		document.formm.action = "zipUpdate";
		document.formm.submit();
	}
}

function post_zip1(){
	var url = "shop.do?command=findZipNumDv";
	var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=550,";
	opt = opt + " height=300, top=300, left=300";
	window.open( url, "우편번호 찾기", opt );
}



function result1( zipNum, sido, gugun, dong){
	opener.document.updateDelivery.zip_num.value=zipNum;
	opener.document.updateDelivery.addr1.value=sido+" "+gugun+" "+dong;
	self.close();
}


function go_orderDetail(){
	document.updateDelivery.action = "orderDetail";
	document.updateDelivery.submit();
}

function delete_order(odseq){
	var answer = confirm("주문을 취소하시겠습니까?");
	if( answer ){
	var url = "deleteOrder?" + odseq;
	var pop = "toolbar=no, menubar=no, scrollbars=no, "
	 + "resizable=no, width=550, height=300, top=300, left=300";
	window.open( url, "deleteOrder", pop );
   }
}
	
	
	
	
	