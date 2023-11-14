<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<link rel="stylesheet" type="text/css" href="../css/commons.css">
	<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
     <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


<style>
.flex-container {
    display: flex;
    flex-direction: column;
}

    </style>
    
    <!--jquery CDN-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	  <script src="/js/join.js"></script>
	 
    <!--javascript 작성 공간-->
    <script>

    $(function(){
        //처음 로딩아이콘 숨김
        $(".btn-send").find(".fa-spinner").hide();
        $(".cert-wrapper").hide();

        //인증번호 보내기 버튼을 누르면
        //서버로 비동기 통신을 보내 인증 메일 발송 요청
        $(".btn-send").click(function(){
            var email = $("[name=memberId]").val();
            if(email.length == 0) return;

            $(".btn-send").prop("disabled", true);
            $(".btn-send").find(".fa-spinner").show();
            $(".btn-send").find("span").text("이메일발송중");
            $.ajax({
                url:"http://localhost:8080/rest/cert/send",
                method:"post",
                data:{certEmail: email},
                success:function(){
                    $(".btn-send").prop("disabled", false);
                    $(".btn-send").find(".fa-spinner").hide();
                    $(".btn-send").find("span").text("인증번호 보내기");
                    // window.alert("이메일 확인하세요!");

                    $(".cert-wrapper").show();
                    window.email = email;
                },
            });
        });

        //확인 버튼을 누르면 이메일과 인증번호를 서버로 전달하여 검사
        $(".btn-cert").click(function(){
            // var email = $("[name=memberEmail]").val();
            var email = window.email;
            var no = $(".cert-input").val();
            if(email.length == 0 || no.length == 0) return;

            $.ajax({
                url:"http://localhost:8080/rest/cert/check",
                method:"post",
                data:{
                    certEmail:email,
                    certNo:no
                },
                success:function(response){
                    // console.log(response);
                    if(response.result){ //인증성공
                        $(".cert-input").removeClass("success fail")
                                        .addClass("success");
                        $(".btn-cert").prop("disabled", true);
                        //상태객체에 상태 저장하는 코드
                        
                     // 이메일 인증이 성공하면 인증번호 입력창과 버튼을 숨김
                        $(".btn-send").find("span").text("인증완료!");
                        $(".btn-send").prop("disabled", true);
                        $(".cert-wrapper").hide();
                        
                    }
                    
                    else{
                        $(".cert-input").removeClass("success fail")
                                        .addClass("fail");
                        //상태객체에 상태 저장하는 코드
                    }
                },
            });
        });
    });
    
   
    </script>



    <form class="join-form" action="join" method="post" autocomplete="off">

        <div class="row container w-600 navy">
            <div class="row">
                <h2 >회원가입</h2>
            </div>
            <div class="row right">
                <span><span class="red">*</span>필수입력사항</span>
            </div>
            <hr class="navy">

                <div class="row flex-container">
                
                    <div class="row w-25 left">
                        <label>아이디<span class="red">*</span></label>
                    </div>

                    <div class="row w-75 pr-30 left">
                        <input type="email" name="memberId" placeholder="예: test@kh.com" class="form-input w-70">
   					<button type="button" class="btn-send btn btn-navy">
    			<i class="fa-solid fa-spinner fa-spin"></i>
    					<span>인증</span>
								</button>
                        <div class="cert-wrapper pt-10">
       					 <input type="text" class="cert-input form-input w-70">
       					 <button type="button" class="btn-cert btn btn-navy">확인완료</button>
   					</div>
   					 <div class="fail-feedback left">이메일 입력 후 인증해주세요</div>
                        <div class="fail2-feedback left">이미 사용중인 이메일입니다</div>
   					
                </div>
                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>비밀번호<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberPw"
                             placeholder="비밀번호를 입력해주세요"
                            class="form-input w-100">
                             <div class="success-feedback left"></div>
                        <div class="fail-feedback left">영문,숫자,특수문자(!@#$) 반드시 1개 이상 포함 8~16자</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>비밀번호 확인<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" id="password-check" placeholder="비밀번호 한 번 더 입력해주세요"
                                    class="form-input w-100">
                        <div class="success-feedback"></div>
                        <div class="fail-feedback left">동일한 비밀번호를 입력하세요</div>
                        <div class="fail2-feedback left">비밀번호를 먼저 작성하세요</div>
                    </div>
                </div>
               
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>닉네임<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberNickname" 
                         class="form-input w-100">
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="date" name="memberBirth" 
                        class="form-input w-100">
                         <div class="fail-feedback left">잘못된 날짜를 선택하셨습니다</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>휴대폰<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" placeholder="01012341234(-없이)"
                                class="form-input w-100">
                                <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                    </div>
                </div>
                  <div class="row flex-container">
                
                    <div class="row w-25 left">
                        <label>성별<span class="red">*</span></label>
                    </div>

                    <div class="row w-75 pr-30 left">
                        <input type="text" name="memberGender" class="form-input w-70">
   					</div>
   					
                </div>
              

                <div class="row pt-10 text-center">
                    <button type="submit" class="btn btn-orange">가입하기</button>
                </div>

        </div>
        </div>
    </form>
