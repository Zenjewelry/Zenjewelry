function go_search(frm){
	if(frm=="bdfrm" && document.bdfrm.key.value == "") alert("검색어를 입력하세요.");
	else if(frm=="hdfrm" && document.hdfrm.key.value == "") alert("검색어를 입력하세요.");
	else{
		if(frm=="bdfrm"){
			document.bdfrm.action = "mboardList";
			document.bdfrm.submit();
		}else if(frm=="hdfrm"){
			document.hdfrm.action = "mproductList?kind=0";
			document.hdfrm.submit();
		}
	}
}

function go_write(com){
	location.href = "mwrite" + com + "Form";
}

function go_save1(com){
	var actions = 'mgo_' + com + 'Board';
	document.wbfrm.method = "post";
	document.wbfrm.action = actions;
	document.wbfrm.submit();
}

function go_mov1(com){
	if(com=="Detail"){
		location.href = "mboard" + com + "?num=" + document.wbfrm.boardnum.value;
	}else{
		location.href = "mboard" + com;
	}
}

function go_mov_All(com){
	location.href="board" + com + "?sub='y'";
}

function writeReply(){
	if(document.rpfrm.reply.value==""){
		alert("댓글을 작성해주세요.");
	}else{
		document.rpfrm.action = 'mwriteReply';
		document.rpfrm.submit();
	}
}

function delete_Board(){
   var answer = confirm("게시글을 삭제하시겠습니까?");
   if( answer ){
	document.formm.action= "mdeleteBoard";
	document.formm.submit();   
   }
}

/*var defRol = 0;
function prev(size){
	if(defRol!=0){
		defRol+=320;
		document.getElementById("itemsbox").style.left = defRol + 'px';
	}
}
function next(size){
	var ck = defRol - 320;
	if((size*-1)+1280<=ck){
		defRol-=320;
		document.getElementById("itemsbox").style.left = defRol + 'px';
	}
}*/

$(function(){
	
	var defRol = 0;
	$('#prev').click(function(){
		if(defRol!=0){
			defRol+=320;
			$('#itemsbox').animate({left:defRol}, 500);
		}
	});
	
	$('#next').click(function(){
		var size = $('#nls').val();
		var ck = defRol - 320;
		if((size*-1)+1280<=ck){
			defRol-=320;
			$('#itemsbox').animate({left:defRol}, 500);
		}
		/*console.log(size);*/
	});
	
	$('#items:nth-of-type(1)').hover(
		function(){/*마우스엔터*/
			$(this).css('transform', 'scale(1.1)').css('transition', '300ms');
		},
		function(){/*마우스리브*/
			$(this).css('transform', 'scale(1)');
		}
	);
	
	$('.rolBtn').hover(
		function(){/*마우스엔터*/
			$(this).css('transform', 'scale(1.4)').css('transition', '300ms');
		},
		function(){/*마우스리브*/
			$(this).css('transform', 'scale(1)');
		}
	);
	
	var defRol1 = 0;
   $('#prev1').click(function(){
      if(defRol1!=0){
         defRol1+=320;
         $('#itemsbox1').animate({left:defRol1}, 500);
      }
   });
   
  
   
   $('#next1').click(function(){
      var size = $('#bls').val();
      var ck = defRol1 - 320;
      if((size*-1)+1280<=ck){
         defRol1-=320;
         $('#itemsbox1').animate({left:defRol1}, 500);
      }
      /*console.log(size);*/
   });
   
   $(document).ready(function(){$('#hmBtn').click();});
   
   $('#hmBtn').click(function(){
         /*$('.ddBtn').eq(i).css('left', '0px').css('opacity', '1').css('transition', '700ms');*/
         $('.ddBtn').toggle(500, function(){
            $(this).css('left', '0px').css('opacity', '0.8');
         });
      }
   );
   
   $('.ddBtn').hover(
      function(){/*마우스엔터*/
         $(this).css('transform', 'scale(1.1)').css('transition', '300ms');
         $(this).css('opacity', '1');
         /*$(this, 'a').css('color', '#B3B3B3');*/
      },
      function(){/*마우스리브*/
         $(this).css('transform', 'scale(1)');
         $(this).css('opacity', '0.8');
      }
   );
});



function uploadImg(){
	var opt = "toolbar=no, menubar=no, resizable=no, width=550, height=300";
	window.open('uploadImg', '이미지 업로드', opt);
}

function uploadedImg(){
	document.frm.submit();
}



function deleteProductQna_test(){
	var con = confirm('상품문의를 삭제하시겠습니까 ?');
	var pseq = document.qnalist.pseq.value;
	var qna_num = document.qnalist.qna_num.value;
	if(con)
		location.href="'mdeleteProductQna?qna_num=' + qna_num + '&pseq=' + pseq";
}

function deleteProductQna(){
	var con = confirm('상품문의를 삭제하시겠습니까 ?');
	if(con){
		document.qnalist.action = 'mdeleteProductQna';
		document.qnalist.submit();
	}
}





// 프로모션 jQuery
$(function(){

	
	var widthSize = top.window.innerWidth * 0.8;

	var defPRol = 0;
	$('#prevPromotion').click(function(){
		if(defPRol!=0){
			defPRol+=widthSize;
			$('#promotionsBox').animate({left:defPRol}, 500);
		}
	});
	
	$('#nextPromotion').click(function(){
		var size = $('#pmls').val() * widthSize;
		var ck = defPRol - widthSize;
		if((size*-1)<ck){
			defPRol-=widthSize;
			$('#promotionsBox').animate({left:defPRol}, 500);
		}
		/*console.log(size);*/
	});
	
	
	
	$('.rolPBtn').hover(
		function(){/*마우스엔터*/
			$(this).css('transform', 'scale(1.4)').css('transition', '300ms');
		},
		function(){/*마우스리브*/
			$(this).css('transform', 'scale(1)');
		}
	);
	
});



function updatePrice(){
	
	var optionName
		= document.getElementById('option1').value + 
		document.getElementById('option2').value + 
		document.getElementById('option3').value;
	
	var fsp = parseInt(document.getElementById('firstsellprice').value);
	var on = parseInt(document.getElementById(optionName).value);
	var quan = parseInt(document.getElementById('quan').value);
	
	var sellprice = (fsp + on) * quan;
	
	var sellpriceOne = fsp + on;
	
	document.getElementById('viewPrice').firstChild.nodeValue
		= sellprice;
	
	document.getElementById('sellprice').value = sellpriceOne;
		
	document.getElementById('sku').innerHTML = document.getElementById(optionName+'_sku').value;
	
}


function loginCheck(){
	if(document.loginFrm.id.value==""){
		alert("아이디는 필수입력사항입니다");
		document.loginFrm.id.focus();
		return false;
	}
	if(document.loginFrm.pwd.value==""){
		alert("비밀번호는 필수입력사항입니다");
		document.loginFrm.pwd.focus();
		return false;
	}
	return true;
}


function go_next() {
	if (document.formm.okon[0].checked == true) {
    	document.formm.action = "mjoinForm";
    	document.formm.submit();
  	} else if (document.formm.okon[1].checked == true) {
    	alert('약관에 동의하셔야만 합니다.');
  	}
}



function idcheck(){
	if( document.formm.id.value=="" ){
		alert("아이디를 입력하고 중복체크를 진행하세요" );
		documnet.formm.id.focus();
		return;
	}
	var url = "midCheckForm?id=" + document.formm.id.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "IdCheck", opt);	
}

function emailCheck(){
	if(document.formm.email.value==""){
		alert("이메일을 입력하고 중복체크를 진행하세요");
		document.formm.email.focus();
		return;
	}
	var url = "mEmailCheckForm?email=" + document.formm.email.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "EmailCheck", opt);
}

function numCheck(){
	if(document.formm.email.value==""){
		alert("이메일을 입력하고 눌러주세요");
		document.formm.email.focus();
		return;
	}
	var url = "mnumCkeck?email=" + document.formm.email.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "numCheck", opt);
}


function post_zip(){
	var url = "mfindZipNum";
	var pop = "toolbar=no, menubar=no, scrollbars=no, "
	 + "resizable=no, width=550, height=300, top=300, left=300";
	window.open( url, "find Zip num", pop );
}



function result( zip_num, sido, gugun, dong){
	opener.document.formm.zip_num.value=zip_num;
	opener.document.formm.address.value=sido+" "+gugun+" "+dong;
	self.close();
}



function go_save(){
	if (document.joinForm.pwd.value == "") {
	    alert("비밀번호를 입력해 주세요.");
	    document.joinForm.pwd.focus();
	}else if ((document.joinForm.pwd.value != document.joinForm.pwdCheck.value)) {
	    alert("비밀번호가 일치하지 않습니다.");
	    document.joinForm.pwd.focus();
	}else if (document.joinForm.name.value == "") {
	    alert("이름을 입력해 주세요.");
	    document.joinForm.name.focus();
	} else if (document.joinForm.email.value == "") {
	    alert("이메일을 입력해 주세요.");
	    document.joinForm.email.focus();
	} else if (document.joinForm.addr1.value == "") {
	    alert("주소를 입력해 주세요");
	    document.joinForm.addr1.focus();
	} else if (document.joinForm.addr2.value == "") {
	    alert("상세주소를 입력해 주세요");
	    document.joinForm.addr2.focus();
	}else if (document.joinForm.phone.value == "") {
	    alert("핸드폰 번호를 입력해 주세요");
	    document.joinForm.phone.focus();
	} else {
	    document.joinForm.action = "shop.do";
	    document.joinForm.submit();
	}
}




function find_account(){

	var url = "mfindAccount";
	var opt = "toolbar=no, menubar=no, scrollbars=no, resizable=no, width=700,";
	opt = opt + "height=500, top=300, left=300";
	window.open(url, "Find Id/Pw", opt);
	
}

function go_update(){
   if (document.joinForm.pwd.value == "") {
       alert("비밀번호를 입력해 주세요.");
       document.joinForm.pwd.focus();
   }else if ((document.joinForm.pwd.value != document.joinForm.pwdCheck.value)) {
       alert("비밀번호가 일치하지 않습니다.");
       document.joinForm.pwd.focus();
   }else if (document.joinForm.name.value == "") {
       alert("이름을 입력해 주세요.");
       document.joinForm.name.focus();
   } else if (document.joinForm.email.value == "") {
       alert("이메일을 입력해 주세요.");
       document.joinForm.email.focus();
   } else if (document.joinForm.addr1.value == "") {
       alert("주소를 입력해 주세요");
       document.joinForm.addr1.focus();
   }else if (document.joinForm.addr2.value == "") {
       alert("상세주소를 입력해 주세요");
       document.joinForm.addr2.focus();
   }else if (document.joinForm.phone.value == "") {
       alert("핸드폰 번호를 입력해 주세요");
       document.joinForm.phone.focus();
   } else {
       document.joinForm.action = "shop.do";
       document.joinForm.submit();
   }
}


function save_product_qna(){
	if(document.product_qna.subject.value==""){
	alert("Q&A 제목을 입력해주세요");
	document.product_qna.subject.focus();
	}else if(document.product_qna.content.value==""){
	alert("Q&A 내용을 입력해주세요");
	document.product_qna.content.focus();
	}else if(document.product_qna.qnapwd.value==""){
	alert("Q&A 비밀번호를 설정해주세요");
	document.product_qna.qnapwd.focus();
	}else{
	document.product_qna.action= "shop.do";
	document.product_qna.submit();
	}
}


function go_removeQna(){
	
	var answer = confirm("Q&A를 삭제하시겠습니까?");
	if( answer ){
	 document.qnalist.action= "shop.do?command=mdeleteProductQna";
	document.qnalist.submit();	
	}
}


function Switch_dormant_account(){
	var answer = confirm("계정을 활성화 하시겠습니까?");
	if( answer ){
	 document.formm.action= "mSwitch_dormant_account";
	 document.formm.submit();	
	}
	else return false;
}	


function go_cart(){
	if (document.formmm.quantity.value == "") {
	    alert("수량을 입력하여 주세요.");
	    document.formmm.quantity.focus();
	}else{
		document.formmm.action ="mcartInsert";
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
		document.formm.action = "mcartDelete";
	    document.formm.submit();
	}
}

/*

function go_order_insert(){

	document.formm.action ="morderInsert";
	document.formm.submit();
	
	
}
*/




function go_order_one(){
	document.formmm.action ="morderOne";
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
		document.formm.action = "mzipUpdate";
		document.formm.submit();
	}
}

function post_zip1(){
	var url = "shop.do?command=mfindZipNumDv";
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
	document.updateDelivery.action = "morderDetail";
	document.updateDelivery.submit();
}



function delete_order(oseq){
	var answer = confirm("주문을 취소하시겠습니까?");
	if( answer ){
	var url = "mdeleteOrderPassWord?oseq=" + oseq;
	var pop = "toolbar=no, menubar=no, scrollbars=no, "
	 + "resizable=no, width=550, height=300, top=300, left=300";
	window.open( url, "주문 취소하기", pop );
   }
}



function sizing(){

	var size = top.window.innerWidth;
	var pnls = parseInt(document.getElementById('pnls').value) / 1280;
	var pmls = parseInt(document.getElementById('pmls').value);
	
	document.getElementById('promotionsBox').style.width = (size * pmls * 0.8) + 'px';
	document.getElementById('pnls').value = (size * pmls * 0.8) + 'px';
	document.getElementById('promotionBox').style.width = (size*0.8) + 'px';
}










