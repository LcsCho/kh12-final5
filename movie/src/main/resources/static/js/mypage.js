
$(function(){
    //상태 객체
    var status = {
        memberPw:false,
        pwCheck:false,
        memberNickname:false,
        memberContact:false,
        memberBirth:false,
        ok:function(){
            return this.memberPw && this.pwCheck && this.memberNickname &&
           this.memberContact && this.memberBirth;
        },
    };
    
	
    $("#newPw").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,60}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("is-valid is-invalid");
        $(this).addClass(isValid ? "is-valid" : "is-invalid");
         status.memberPw = isValid;

         //비밀번호 확인창에 강제로 blur이벤트를 발생시킨다(트리거)
//         $("#password-check").blur();
    });

	//비밀번호 확인 검사
    $("#pw-check").blur(function(){
        var originPw = $("#memberPassword").val();
        var checkPw = $(this).val();
         $(this).removeClass("is-valid").removeClass("is-invalid");
        if(originPw.length === 0){//미입력이면
            $(this).addClass("is-invalid").siblings('.invalid-feedback').text("비밀번호를 먼저 작성하세요");
        status.pwCheck = false;
        }
        else if(originPw === checkPw){//일치하면
            $(this).addClass("is-valid").siblings('.valid-feedback').text("비밀번호가 일치합니다");
        status.pwCheck = true;
        }
        else{//비밀번호 불일치
           $(this).addClass("is-invalid").siblings('.invalid-feedback').text("비밀번호가 일치하지 않습니다");
        status.pwCheck = false;
        }
    });

	 $("[name=memberNickname]").blur(function(e){
        var regex = /^[ㄱ-ㅎㅏ-ㅣ가-힣0-9]{2,10}$/;
        var isValid = regex.test($(e.target).val());

        if(isValid){ //형식이 유효하다면
            $.ajax({   
                url:"http://localhost:8080/rest/member/nicknameCheck",
                method:"post",
                data:{memberNickname: $(e.target).val()}, //jQuery
                success:function(response){
                    $(e.target).removeClass("is-valid is-invalid");  
                    if(response == "Y"){ //사용가능한 닉네임
                        $(e.target).addClass("is-valid");
	                     $(e.target).parent().find('.valid-feedback').text("멋진 닉네임입니다!"); 
	                    status.memberNickname = true;
                    }
                    else{ //이미 사용중인 닉네임
                        $(e.target).addClass("is-invalid");
	                    $(e.target).parent().find('.invalid-feedback').text("이미 사용중인 닉네임 입니다"); 
	                    status.memberNickname = false;
                    }
                },
                error:function(){
                    alert("서버와의 통신이 원활하지 않습니다");
                },
        });
    }
        else {//형식이 유효하지 않다면(1차실패)
           	$(e.target).removeClass("is-valid is-invalid");
        	$(e.target).addClass("is-invalid");
         	$(e.target).parent().find('.invalid-feedback').text("한글/영문/숫자 포함 2~10자로 입력하세요"); 
	        status.memberNickname = false;
        }
    }); 
      
 
    $("[name=memberContact]").blur(function(){
        var regex = /^01[016789][1-9][0-9]{2,3}[0-9]{4}$/;
        var contact = $(this).val();
        var isValid =regex.test(contact);
        $(this).removeClass("is-valid is-invalid");
         if(isValid){
			  $(this).addClass("is-valid"); 
              status.memberContact = true;
		 }
		 else{
			 $(this).addClass("is-invalid");
            status.memberContact = false;
		 }
    });
    
    
    $("#memberBirth").blur(function(){
        var regex =  /^(19[0-9]{2}|20[0-9]{2})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("is-valid is-invalid");
        $(this).addClass(isValid ? "is-valid" : "is-invalid");
         status.memberBirth = isValid;
    });
});


   