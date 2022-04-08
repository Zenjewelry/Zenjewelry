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
    	document.formm.action = "joinForm";
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
	var url = "idCheckForm?id=" + document.formm.id.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "IdCheck", opt);	
}

function emailCheck(){
	if(document.formm.email.value==""){
		alert("이메일을 입력하고 중복체크를 진행하세요");
		document.formm.email.focus();
		return;
	}
	var url = "EmailCheckForm?email=" + document.formm.email.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "EmailCheck", opt);
}

function numCheck(){
	if(document.formm.email.value==""){
		alert("이메일을 입력하고 눌러주세요");
		document.formm.email.focus();
		return;
	}
	var url = "numCkeck?email=" + document.formm.email.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "numCheck", opt);
}


function post_zip(){
	var url = "findZipNum";
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

	var url = "findAccount";
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
	 document.qnalist.action= "shop.do?command=deleteProductQna";
	document.qnalist.submit();	
	}
}




