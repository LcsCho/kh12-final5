<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC</title>
<!-- favicon 설정 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico">

<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/flatly/bootstrap.min.css" rel="stylesheet">


<script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>
<script>
    $(document).ready(function () {
        $('#loginModal').on('hidden.bs.modal', function () {
            // 여기에 모달이 닫힌 후 실행되는 코드 추가
            // 예: 로그인이 완료되면 메인 페이지로 돌아감
             window.location.href = '/'; // your_main_page에는 실제 메인 페이지 경로를 입력하세요
        });

        // 비밀번호 찾기 모달 표시를 위한 이벤트 처리
        $('#forgotPasswordLink').click(function () {
            $('#forgotPasswordModal').modal('show');
        });
    });
</script>

<script>
	//비밀번호 재설정 이메일 발송 코드
	
	$(function(){
        //처음 로딩아이콘 숨김
        $(".btn-send").find(".fa-spinner").hide();
        $(".cert-wrapper").hide();

        //인증번호 보내기 버튼을 누르면
        //서버로 비동기 통신을 보내 인증 메일 발송 요청
        $(".btn-send").click(function(){
        	var email = $("#email").val();
            //var email = $("[name=memberId]").val();
            if(email.length == 0) return;

            $(".btn-send").prop("disabled", true);
            $(".btn-send").find(".fa-spinner").show();
            $(".btn-send").find("span").text("이메일발송중");
            $.ajax({
                url:"http://localhost:8080/rest/cert/resetPassword",
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
                url:"http://localhost:8080/rest/cert/checkEmail",
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

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
    .custom-search {
    background-color: #e6dcdc;
    border: none;    
    width: 500px; /* 또는 다른 너비를 지정하세요 */
}

</style>
</head>

<body class="center">
	<main>
        <div class="container-fluid">
            <div class="row">
                <div class="col">

		            <header>
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-10 offset-md-1">
                                    <div class="row align-items-center">

                                            <div class="col-4 mt-2 mb-2">
                                                <img src="../images/mvc.png" width="150">
                                            </div>

                                        
                                            <!-- <div class="col">
                                                <form class="d-flex">
                                                    <input class="form-control me-sm-2" type="search" placeholder="Search">
                                                    <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
                                                </form>
                                            </div> -->

                                        <div class="d-flex col-8 justify-content-end">
                                            <form class="d-flex">
                                                <input class="form-control me-sm-2 custom-search" type="search" placeholder="콘텐츠, 인물, 유저를 검색해보세요">
                                                <button class="btn btn-secondary my-2 my-sm-0 custom-search-btn" type="submit">검색</button>
                                            </form>
                                            <c:choose>
                                            	<c:when test="${sessionScope.name !=null}">
                                            		<a href="/member/logout" class="btn">로그아웃</a>
                                            		<a href="/member/mypage" class="btn">마이페이지</a>
                                            	</c:when>
                                            	<c:otherwise>
		                                            <a href="#" class="btn btn-navy ms-4" data-bs-toggle="modal" data-bs-target="#loginModal">로그인하기</a>
		                                            <a href="/member/join" class="btn">회원가입</a>
                                            	</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                            <!-- 로그인 모달 -->
                        <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="loginModalLabel">로그인하기</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- 로그인 폼 추가 -->
                                        <form action="member/login" method="post">
                                            <!-- 로그인 폼 요소들을 여기에 추가 -->
                                            <div class="mb-3">
                                                <input type="text" class="form-control" id="username" name="memberId" placeholder="이메일" required>
                                            </div>
                                            <div class="mb-3">
                                                <input type="password" class="form-control" id="password" name="memberPw" placeholder="비밀번호" required>
                                            </div>
                                            <button type="submit" class="btn btn-primary">로그인</button>
                                            <!-- 비밀번호 찾기 버튼 추가 -->
                                            <button type="button" class="btn btn-link" id="forgotPasswordLink">비밀번호 찾기</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                            <!-- 비밀번호 재설정 모달 -->
                        <div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="forgotPasswordModalLabel">비밀번호 찾기</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row mb-3">
                                            <p>비밀번호를 잊으셨나요?</p><br>
                                            <p>가입했던 이메일을 적어주세요.</p><br>
                                            <p>입력하신 이메일 주소로 비밀번호 변경 메일을 보내드릴게요.</p><br>
                                        </div>
                                        <!-- 비밀번호 찾기 폼 추가 -->
                                        <form id="forgotPasswordForm" action="" method="post">
                                            <!-- 비밀번호 찾기 폼 요소들을 여기에 추가 -->
                                            <div class="mb-3">
                                                <input type="email" class="form-control" id="email" name="memberId" placeholder="이메일" required>
                                            </div>
                                            <button type="button" class="btn-send btn btn-primary">
                                                <i class="fa-solid fa-spinner fa-spin"></i>
                                                <span>이메일 보내기</span>
                                            </button>

                                            <div class="cert-wrapper pt-10">
                                                <input type="text" class="cert-input form-input w-70">
                                                <button type="button" class="btn-cert btn btn-navy">확인완료</button>
                                            </div>
                                            <div class="fail-feedback left">이메일 입력 후 인증해주세요</div>
                                            <div class="fail2-feedback left">이미 사용중인 이메일입니다</div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
		            </header>
		            <section>

