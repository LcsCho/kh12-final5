
$(function(){
    //상태 객체
    var status = {
        memberId:false,
        memberPw:false,
        pwCheck:false,
        memberContact:false,
        memberBirth:false,
        ok:function(){
            return this.memberId && this.memberPw && this.pwCheck&& 
           this.memberContact && this.memberBirth;
        },
    };


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
   