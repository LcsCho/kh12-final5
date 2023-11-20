<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

</style>

<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/flatly/bootstrap.min.css"
	rel="stylesheet">

<script>

$(function(){
    //처음 로딩아이콘 숨김
    $(".btn-send").find(".fa-spinner").hide();
    $(".cert-wrapper").hide();

    //인증번호 보내기 버튼을 누르면
    //서버로 비동기 통신을 보내 인증 메일 발송 요청
    $(".btn-send").click(function(){
    	var email = $("[name=memberId]").val();
    	console.log("버튼 클릭됨");
        //var email = $("#email").val();
        if(email.length == 0) return;

        $(".btn-send").prop("disabled", true);
        $(".btn-send").find(".fa-spinner").show();
        $(".btn-send").find("span").text("이메일 발송중");
        $.ajax({
            url:"http://localhost:8080/rest/cert/send",
            method:"post",
            data:{certEmail: email},
            success:function(){
                $(".btn-send").prop("disabled", false);
                $(".btn-send").find(".fa-spinner").hide();
                $(".btn-send").find("span").text("발송하기");
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
                 console.log(response);
                if(response.result){ //인증성공
                    $(".cert-input").removeClass("is-valid is-invalid")
                                    .addClass("is-valid");
                    $(".btn-cert").prop("disabled", true);
                    //상태객체에 상태 저장하는 코드
                    
                 // 이메일 인증이 성공하면 인증번호 입력창과 버튼을 숨김
                    $(".btn-send").find("span").text("인증완료!");
                    $(".btn-send").prop("disabled", true);
                    $(".cert-wrapper").hide();
                  }
                else{
                    $(".cert-input").removeClass("is-valid is-invalid")
                                    .addClass("is-invalid");
                    alert(response.error);
                }
            },
        });
    });
 });
 
    
</script>



<div class="row my-5 py-5" style="min-height: 400px;">
    <div class="col-md-4 offset-md-4 col-sm-10 offset-sm-1">

        <form class="join-form" action="join" method="post" autocomplete="off">

            <!-- 제목 -->
            <div class="row">
                <div class="col">
                    <h3 class="text-center">회원 가입</h3>
                    <hr>
                </div>
            </div>
            
            <div class="row">
   		 <div class="col-9">
        <div class="form-floating">
            <input type="email" id="email" class="form-control" placeholder="" name="memberId" required>
            <label>아이디</label>
        </div>
    </div>
    		<div class="col-3 d-flex align-items-center">
       			 <button type="button" class="btn-send btn btn-secondary form-control">
            		<i class="fa-solid fa-spinner fa-spin"></i>
           				 <span>인증</span>
        	</button>
   		 </div>
	</div>
	
			<div class="row mt-2">
    		<div class="col-9">
       	 <div class="cert-wrapper">
            <input type="text" class="cert-input form-control">
            <button type="button" class="btn-cert btn btn-secondary form-control">확인완료</button>
        </div>
        	<div class="valid-feedback">사용 가능한 이메일입니다</div>
        	<div class="invalid-feedback">이메일 주소가 올바르지 않습니다</div>
   		 </div>
	</div>
            
            <!-- 비밀번호 입력창-->
             <div class="row mt-4">
                <div class="col">
                    <div class="form-floating">
                        <input type="text" class="form-control" placeholder="" name="memberPw" required>
                        <label>비밀번호
                        </label>
                        <div class="valid-feedback">올바른 형식입니다</div>
                        <div class="invalid-feedback">형식이 올바르지 않습니다</div>
                    </div>
                </div>
            </div>


            <!-- 비밀번호 확인 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <div class="form-floating">
                        <input type="text" class="form-control" placeholder="" required>
                        <label>비밀번호 확인
                        </label>
                        <div class="valid-feedback">비밀번호가 일치합니다</div>
                        <div class="invalid-feedback">비밀번호가 일치하지 않습니다</div>
                    </div>
                </div>
            </div>

			<!-- 닉네임 -->
           <div class="row mt-4">
                <div class="col">
                    <div class="form-floating">
                        <input type="text" class="form-control" placeholder="" name="memberNickname" required>
                        <label>닉네임
                        </label>

                        <div class="valid-feedback">멋진 닉네임입니다!</div>
                        <div class="invalid-feedback">한글/영문/숫자 포함 2~10자로 입력하세요</div>
                    </div>
                </div>
            </div>

            <!-- 연락처 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <div class="form-floating">
                        <input type="text" class="form-control" placeholder="" name="memberContact" required>
                        <label>연락처</label>
                        
                    </div>
                </div>
            </div>


            <!-- 생년월일 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <div class="form-floating">
                    <input type="date" name="memberBirth" class="form-control" name="memberBirth" required>
                    <label>생년월일</label>
                    <div class="invalid-feedback">잘못된 날짜 형식입니다</div>
                    </div>
                </div>
            </div>

            <!-- 성별 선택 -->
            <div class="row mt-4">
                <div class="col">
                    <input type="radio" name="memberGender" value="남자" class="form-radio w-70"> 남자
                    <input type="radio" name="memberGender" value="여자" class="form-radio w-70"> 여자
                </div>
            </div>


            <!-- 가입 버튼 -->
            <div class="row mt-4">
                <div class="col">
                    <button type="submit" class="btn btn-primary w-100">
                        회원가입
                    </button>
                </div>
            </div>


        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>