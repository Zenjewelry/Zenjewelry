function go_search(frm){
	if(frm=="bdfrm" && document.bdfrm.key.value == "") alert("검색어를 입력하세요.");
	else if(frm=="hdfrm" && document.hdfrm.searchProduct.value == "") alert("검색어를 입력하세요.");
	else{
		if(frm=="bdfrm"){
			document.bdfrm.action = "boardList";
			document.bdfrm.submit();
		}else if(frm=="hdfrm"){
			document.hdfrm.action = "productList";
			document.hdfrm.submit();
		}
	}
}

function go_write(com){
	location.href = "write" + com + "Form";
}

function go_save1(com){
	var actions = 'go_' + com + 'Board';
	document.wbfrm.method = "post";
	document.wbfrm.action = actions;
	document.wbfrm.submit();
}

function go_mov1(com){
	if(com=="Detail"){
		location.href = "board" + com + "?num=" + document.wbfrm.boardnum.value;
	}else{
		location.href = "board" + com;
	}
}

function go_mov_All(com){
	location.href="board" + com + "?sub='y'";
}

function writeReply(){
	if(document.rpfrm.reply.value==""){
		alert("댓글을 작성해주세요.");
	}else{
		document.rpfrm.action = 'writeReply';
		document.rpfrm.submit();
	}
}

function delete_Board(){
   var answer = confirm("게시글을 삭제하시겠습니까?");
   if( answer ){
	document.formm.action= "deleteBoard";
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











