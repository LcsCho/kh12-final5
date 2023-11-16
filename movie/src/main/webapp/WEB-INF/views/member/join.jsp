<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- <link rel="stylesheet" type="text/css" href="../css/commons.css"> -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>

</style>

	<!-- <script src="/js/join.js"></script>  -->
	 
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
<div class="row my-5 py-5" style="min-height: 400px;">
    <div class="col-md-4 offset-md-4 col-sm-10 offset-sm-1">

        <form action="#" method="post" autocomplete="off">

            <!-- 제목 -->
            <div class="row">
                <div class="col">
                    <h3 class="text-center">회원 가입</h3>
                    <hr>
                </div>
            </div>

            <!-- 아이디 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <label class="form-label">
                        아이디
                        <i class="fa-solid fa-asterisk text-danger"></i>
                    </label>
                    <input type="text" name="memberId" class="form-control" placeholder="이메일 형식으로 입력하세요">
                    <div class="valid-feedback">올바른 이메일 주소입니다</div>
                    <div class="invalid-feedback">아이디가 형식에 맞지 않습니다</div>
                </div>
            </div>

            <!-- 비밀번호 입력창-->
            <div class="row mt-4">
                <div class="col">
                    <label class="form-label">
                        비밀번호
                        <i class="fa-solid fa-asterisk text-danger"></i>
                    </label>
                    <input type="text" name="memberPw" class="form-control"
                        placeholder="영문 대/소문자, 숫자, 특수문자 반드시 포함한 8~16자">
                    <div class="valid-feedback">비밀번호가 안전한 형식입니다!</div>
                    <div class="invalid-feedback">비밀번호가 올바르지 않습니다</div>
                </div>
            </div>

            <!-- 비밀번호 확인 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <label class="form-label">
                        비밀번호 확인
                        <i class="fa-solid fa-asterisk text-danger"></i>
                    </label>
                    <input type="password" id="password-check" class="form-control" placeholder="비밀번호를 한번 더 입력하세요">
                    <div class="valid-feedback">비밀번호가 일치합니다</div>
                    <div class="invalid-feedback">비밀번호가 일치하지 않습니다</div>
                </div>
            </div>

            <!-- 닉네임 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <label class="form-label">
                        닉네임
                        <i class="fa-solid fa-asterisk text-danger"></i>
                    </label>
                    <input type="text" name="memberNickname" class="form-control" placeholder="한글 또는 숫자 2~10글자 이내">
                    <div class="valid-feedback">사용 가능한 닉네임입니다</div>
                    <div class="invalid-feedback">사용할 수 없는 닉네임입니다</div>
                </div>
            </div>


            <!-- 연락처 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <label class="form-label">
                        연락처
                    </label>
                    <input type="tel" name="memberContact" class="form-control" placeholder="01000000000 (-제외)">
                </div>
            </div>

            <!-- 생년월일 입력창 -->
            <div class="row mt-4">
                <div class="col">
                    <label class="form-label">
                        생년월일
                    </label>
                    <input type="date" name="memberBirth" class="form-control">
                    <div class="invalid-feedback">잘못된 날짜 형식입니다</div>
                </div>
            </div>

            <!-- 성별 선택 -->
            <div class="row mt-4">
                <div class="col">

                    <input type="radio" name="memberGender" class="form-radio w-70"> 남자
                    <input type="radio" name="memberGender" class="form-radio w-70"> 여자
                </div>
            </div>


            <!-- 가입 버튼 -->
            <div class="row mt-4">
                <div class="col">
                    <button type="submit" class="btn btn-primary w-100">
<!--                         <i class="fa-solid fa-right-to-bracket"></i> -->
                        회원가입
                    </button>
                </div>
            </div>


        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>