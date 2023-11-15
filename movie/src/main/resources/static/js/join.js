
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
            return this.memberId && this.memberPw && this.memberNickname && this.pwCheck && 
           this.memberContact && this.memberBirth;
        },
    };
    
   $("[name=memberId]").blur(function(e) {
	    var emailValue = $(this).val();
	    var isValid = false;

	    // 이메일 형식 검사
	    if (emailValue) {
	        var regex = /^[a-z0-9]+@[a-z]+\.(com|co\.kr|net)$/;
	        isValid = regex.test(emailValue);
	    }

	    // 클래스 제거
	    $(e.target).removeClass("success fail fail2");

	    // 이메일 형식이 유효하고 null이 아니면 success 클래스 추가
	    if (isValid) {
	        $(e.target).addClass("success");
	        status.memberId = true;
	    } 
	    else {
	        // 이메일 형식이 유효하지 않거나 null이면 fail 클래스 추가
	        $(e.target).addClass("fail");
	        status.memberId = false;
	    }
	});

    $("[name=memberId]").blur(function(e){
        var regex =  /^[a-z0-9]+@[a-z]+\.(com|co\.kr|net)$/;
        var isValid =regex.test($(this).val());
        
        if(isValid){//형식이 유효하다면
			$.ajax({
				url:"http://localhost:8080/member/idCheck",
				method:"post",
				data : {memberId : $(e.target).val()},
				success: function(response){
					$(e.target).removeClass("success fail fail2");
					if(response == "Y"){
						$(e.target).addClass("success");
						status.memberId = true;
					}
					else{
						$(e.target).addClass("fail2");
						status.memberId = false;
					}
				},
				error : function(){
					alert("서버와의 통신이 원할하지 않습니다");
				}
			});
		}
		else{
			$(e.target).removeClass("success fail fail2");
			$(e.target).addClass("fail");
			status.memberId = false;
		}
    });
    
    
    


    $("[name=memberPw]").blur(function(){
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,60}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
         status.memberPw = isValid;
         //비밀번호 확인창에 강제로 blur이벤트를 발생시킨다(트리거)
         $("#password-check").blur();
    });

    $("#password-check").blur(function(){
        var originPw = $("[name=memberPw]").val();
        var checkPw = $(this).val();
        $(this).removeClass("success fail fail2");
        if(originPw.length == 0){//미입력이면
            $(this).addClass("fail2");
            status.pwCheck = false;
        }
        else if(originPw == checkPw){//일치하면
            $(this).addClass("success"); 
            status.pwCheck = true;
        }
        else{//비밀번호 불일치
            $(this).addClass("fail");
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
                    $(e.target).removeClass("success fail fail2");  
                    if(response == "Y"){ //사용가능한 닉네임
                        $(e.target).addClass("success");
                        status.memberNickname = true;
                    }
                    else{ //이미 사용중인 닉네임
                        $(e.target).addClass("fail2");
                        status.memberNickname = false;
                    }
                },
                error:function(){
                    alert("서버와의 통신이 원활하지 않습니다");
                },
        });
    }
        else {//형식이 유효하지 않다면(1차실패)
            $(e.target).removeClass("success fail fail2");  
            $(e.target).addClass("fail");
            status.memberNickname = false;
        }
    }); 
      
 
    $("[name=memberContact]").blur(function(){
        var regex = /^01[016789][1-9][0-9]{2,3}[0-9]{4}$/;
        var contact = $(this).val();
        var isValid =regex.test(contact);
        $(this).removeClass("success fail");
         if(isValid){
			  $(this).addClass("success"); 
              status.memberContact = true;
		 }
		 else{
			 $(this).addClass("fail");
            status.memberContact = false;
		 }
    });
    
    
    $("[name=memberBirth]").blur(function(){
        var regex =  /^(19[0-9]{2}|20[0-9]{2})-(((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((02)-(0[1-9]|1[0-9]|2[0-9])))$/;
        var isValid =$(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
         status.memberBirth = isValid;
    });
  
 
        //페이지 이탈 방지 
            //- window에 beforeunload 이벤트 설정
            $(window).on("beforeunload",function(){
                return false;
            });
 		 //- form 전송할 때는 beforeunload 이벤트를 제거
            $(".join-form").submit(function(e){
                $(".form-input").blur();
                console.table(status);
                console.log(status.ok());
                if(!status.ok()){
                    e.preventDefault();
                }
            else{
                $(window).off("beforeunload");
            }
    });
});
   