
$(function(){
    //상태 객체
    var status = {
        memberId:false,
        memberPw:false,
        pwCheck:false,
        memberNickname:false,
        memberContact:false,
        memberBirth:false,
        ok:function(){
            return this.memberId && this.memberPw && this.pwCheck && this.memberNickname &&
           this.memberContact && this.memberBirth;
        },
    };
    
    //아이디검사
	 $("#memberEmail").blur(function (e) {
	    var regex = /^[a-z0-9]+@[a-z]+\.(com|co\.kr|net)$/;
	    var isValid = regex.test($(this).val());
	    var feedbackWrapper = $(this).closest('.row').next().find('.feedback');
	
	    if (isValid) {
	        $.ajax({
	            url: "http://localhost:8080/member/idCheck",
	            method: "post",
	            data: { memberId: $(e.target).val() },
	            success: function (response) {
	                $(e.target).removeClass("is-valid is-invalid");
	                if (response == "Y") {
	                    $(e.target).addClass("is-valid");
	                    feedbackWrapper.find('.valid-feedback').text("사용 가능한 이메일입니다").show();
	                    feedbackWrapper.find('.invalid-feedback').hide();
	                    status.memberId = true;
	                } else {
	                    $(e.target).addClass("is-invalid");
	                    feedbackWrapper.find('.invalid-feedback').text("이미 사용중인 이메일입니다").show();
	                    feedbackWrapper.find('.valid-feedback').hide();
	                    status.memberId = false;
	                }
	            },
	            error: function () {
	                alert("서버와의 통신이 원할하지 않습니다");
	            }
	        });
	    } else {
	        $(e.target).removeClass("is-valid is-invalid");
	        $(e.target).addClass("is-invalid");
	        feedbackWrapper.find('.invalid-feedback').text("이메일 주소가 올바르지 않습니다").show();
	        feedbackWrapper.find('.valid-feedback').hide();
	        status.memberId = false;
	    }
	});



    $("memberPassWord").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,60}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("is-valid is-invalid");
        $(this).addClass(isValid ? "is-valid" : "is-invalid");
         status.memberPw = isValid;

         //비밀번호 확인창에 강제로 blur이벤트를 발생시킨다(트리거)
//         $("#password-check").blur();
    });

	//비밀번호 확인 검사
    $("#password-check").blur(function(){
        var originPw = $("#memberPassWord").val();
        var checkPw = $(this).val();
        $(this).removeClass("is-valid is-invalid");
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
                url:"http://localhost:8080/member/nicknameCheck",
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
    
    
    $("[name=memberBirth]").blur(function(){
        var regex =  /^(19[0-9]{2}|20[0-9]{2})-(((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((02)-(0[1-9]|1[0-9]|2[0-9])))$/;
        var isValid =$(this).val().length != 0 || regex.test($(this).val());
        $(this).removeClass("is-valid is-invalid");
        $(this).addClass(isValid ? "is-valid" : "is-invalid");
         status.memberBirth = isValid;
    });
  
 
//        //페이지 이탈 방지 
//            //- window에 beforeunload 이벤트 설정
//            $(window).on("beforeunload",function(){
//                return false;
//            });
// 		 //- form 전송할 때는 beforeunload 이벤트를 제거
//            $(".join-form").submit(function(e){
//                $(".form-control").blur();
//                console.table(status);
//                console.log(status.ok());
//                if(!status.ok()){
//                    e.preventDefault();
//                }
//            else{
//                $(window).off("beforeunload");
//            }
//    });
});
   