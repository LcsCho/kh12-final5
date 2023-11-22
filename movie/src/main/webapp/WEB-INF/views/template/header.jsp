<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC</title>

<!-- favicon 설정 -->
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/images/favicon.ico">

<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- 구글 웹 폰트 사용을 위한 CDN -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

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
	window.contextPath = "${pageContext.request.contextPath}";
</script>

<script>
    $(document).ready(function () {
        $('#loginModal').on('hidden.bs.modal', function () {
            // 모달이 닫힌 후
             window.location.href = window.location.href;//이용중인 페이지 유지
        });

        // 비밀번호 찾기 모달 표시를 위한 이벤트 처리
        $('#forgotPasswordLink').click(function () {
            $('#forgotPasswordModal').modal('show');
        });
    });
</script>

<!-- 로그인 처리 -->
<script>

$(document).ready(function() {
    $("#loginForm").submit(function(event) {
        event.preventDefault();
		console.log("memberId", $("#memberId").val(), "memberPw", $("#memberPw").val());

        // Ajax를 이용한 비동기 요청
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/member/login",
            data: {
            	 memberId: $("#memberId").val(),
                 memberPw: $("#memberPw").val()
            },
            success: function(response) {
                // 로그인 성공 시의 동작
            	$("#loginModal").modal("hide");
            	// if (response && response.redirect) {
                     //window.location.href = response.redirect;
                // }
            },
            error: function(error) {
                // 로그인 실패 시의 동작
                alert("아이디,비밀번호가 일치하지 않습니다.");
            }
        });
    });
});

</script>

<!-- 비밀번호 재설정 -->
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
                       
                    // '비밀번호 재설정하러가기' 버튼 생성
                    	//if (!$('#resetPasswordButton').length) {
                       var resetPasswordButton = $('<button/>', {
                           type: 'button',
                           class: 'btn btn-primary',
                           text: '비밀번호 재설정하러가기',
                           id: 'resetPasswordButton'
                       });
                   		// 버튼을 특정 위치에 추가 (예: 모달 바디의 끝에 추가)
                       $("#cert-modal-body").append(resetPasswordButton);

                       // 클릭 이벤트 추가
//                        resetPasswordButton.click(function () {
//                            // 비밀번호 재설정 모달 띄우기
//                            $('#resetPasswordModal').modal('show');
//                            $('#resetPasswordButton').hide();
//                            // 추가로 필요한 초기화 또는 설정 작업을 수행할 수 있습니다.
//                        }); 
                     }
                   
                   else{
                       $(".cert-input").removeClass("success fail")
                                       .addClass("fail");
                       alert(response.error);
                   }
               },
           });
       });
       
//        // '비밀번호 재설정하러가기' 버튼 클릭 시 이벤트 처리
//        $(document).on('click', '#resetPasswordButton', function () {
//            // 비밀번호 재설정 모달 띄우기
//            $('#resetPasswordModal').modal('show');
           
//            // 추가로 필요한 초기화 또는 설정 작업을 수행할 수 있습니다.
//        });
    });
    
    
    

$(document).ready(function () {
        // '비밀번호 재설정하러가기' 버튼 클릭 이벤트 처리
        $(document).on('click', '#resetPasswordButton', function () {
            // 비밀번호 재설정 모달을 띄움
            $('#resetPasswordModal').modal('show');
            $('#resetPasswordButton').hide();
        });
        
     // 비밀번호 재설정 폼 제출 이벤트 처리
        $("#resetPasswordForm").submit(function (event) {
            // 폼의 기본 동작을 막음
            event.preventDefault();

            // 새로운 비밀번호와 비밀번호 확인을 가져옴
            var newPassword = $("#newPassword").val();
            var confirmPassword = $("#confirmPassword").val();
            var memberId = $("#email").val();

            // 비밀번호 일치 여부 확인
            if (newPassword !== confirmPassword) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return;
            }

            // 서버로 비밀번호 변경 요청을 보냄
            $.ajax({
                url: "http://localhost:8080/member/changePw", 
                method: "POST",
                data: {
                    memberId: memberId,
                	memberPw: newPassword
                },
                success: function (response) {
                    // 비밀번호 변경 성공 시 처리
                    alert("비밀번호 재설정이 완료되었습니다.");

                    // 모달을 닫음
                    $('#resetPasswordModal').modal('hide');

                    // 페이지 이동
                    window.location.href = "/";
                },
                error: function (xhr, status, error) {
                    // 비밀번호 변경 실패 시 처리
                    alert("비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });
     

    
    
</script>
<!-- 영화 검색 실시간으로 연관 검색어 출력 -->
<script>
$(document).ready(function () {
    var typingTimer;
    var doneTypingInterval = 500; // 입력 완료 인터벌 (밀리초)

    // 검색 입력란에 이벤트 리스너 추가
    $("#searchInput").on("input", function () {
        clearTimeout(typingTimer);
        var keyword = $(this).val();

        // 타이머를 이용하여 입력이 완료된 후에 서버에 Ajax 요청 보내기
        typingTimer = setTimeout(function () {
            if (keyword.trim() === "") {
                // 입력이 빈 칸인 경우 추천 목록 비우기
                $("#suggestionsContainer").empty();
                return;
            }

            $.ajax({
                url: "/search/movieName",
                method: "GET",
                data: { "keyword": keyword },

                success: function (response) {
                    var suggestionsContainer = $("#suggestionsContainer");

                    suggestionsContainer.empty();

                    // 최대 5개까지만 출력
                    for (var i = 0; i < Math.min(response.length, 5); i++) {
                        var movieName = response[i];

                        // 클릭 가능한 링크 생성하고 suggestionsContainer에 추가
                        var movieLink = $("<a>")
                            .addClass("link link-underline link-underline-opacity-0 link-danger")
                            .text(movieName)
                            .on("click", function() {
                                // 클릭한 연관 검색어를 검색 입력란에 설정
                                $("#searchInput").val($(this).text());

                                // form을 서버로 전송
                                $("#movieSearchForm").submit();
                            });

                        suggestionsContainer.append("<div>").append(movieLink);
                    }
                },

                error: function (error) {
                    console.error("연관검색에 대한 오류 발생:", error);
                }
            });
        }, doneTypingInterval);
    });
});
</script>

<script>
$(document).ready(function () {
    function disableButton() {
        const searchInput = $("#searchInput");
        const searchButton = $("#searchButton");

        if (searchInput.val() === "") {
            searchButton.prop("disabled", true);
        } else {
            searchButton.prop("disabled", false);
        }
    }

    $("#searchInput").on("input", disableButton);
});
</script>

<style>
.custom-search {
	background-color: #e6dcdc;
	border: none;
	width: 450px;
}

.form-group {
	margin-bottom: 10px;
}

.form-control {
	height: 40px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.c-btn {
	width: 60px;
	height: 40px;
	border-radius: 5px;
}

<!--
검색창 안에 스타일 추가 -->.position-relative {
	position: relative;
}

#suggestionsContainer {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	background-color: #fff;
	border: 1px solid #ccc;
	max-height: 200px;
	overflow-y: auto;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>
</head>

<body class="center">
	<main>
		<div class="container-fluid">
			<div class="row">
				<div class="col">

					<header>

						<div class="container-float">
							<div class="row">
								<div class="col-md-10 offset-md-1">
									<div class="row align-items-center me-3 mt-3">

										<div class="col-4">
											<a href="http://localhost:8080/"> <img
												src="../images/mvc.png" width="150">
											</a>
										</div>

										<div class="col-8 d-flex justify-content-end">
											<form action="/" method="post" class="d-flex"
												id="movieSearchForm">
												<div class="position-relative">
													<!-- 부모 요소 추가 -->
													<input class="form-control me-sm-2 custom-search"
														type="text" name="movieName" placeholder="영화 제목을 입력해주세요."
														style="height: fit-content;" autocomplete="off"
														id="searchInput">
													<div id="suggestionsContainer"></div>
												</div>
												<button
													class="btn btn-secondary my-2 my-sm-0 custom-search-btn c-btn"
													id="searchButton" disabled type="submit"
													style="height: fit-content;">검색</button>
											</form>
											<c:choose>
												<c:when test="${sessionScope.name !=null}">
													<a href="/member/logout" class="btn c-btn ms-5"
														style="height: fit-content;"> <i
														class="fa fa-sign-out-alt fa-2xl"></i>
													</a>
													<a href="/member/mypage" class="btn c-btn"
														style="height: fit-content;"> <i
														class="fa-solid fa-user fa-2xl"></i>
													</a>
												</c:when>
												<c:otherwise>
													<a href="#" class="btn c-btn ms-5" data-bs-toggle="modal"
														data-bs-target="#loginModal" style="height: fit-content;">
														<i class="fa-solid fa-right-to-bracket fa-2xl"></i>
													</a>
													<a href="/member/join" class="btn c-btn"
														style="height: fit-content;"> <i
														class="fa fa-user-plus fa-2xl"></i>
													</a>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 로그인 모달 -->
						<div class="modal fade" id="loginModal" tabindex="-1"
							aria-labelledby="loginModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="loginModalLabel">로그인하기</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<!-- 로그인 폼 추가 -->
										<form id="loginForm">
											<!-- 로그인 폼 요소들을 여기에 추가 -->
											<div class="mb-3">
												<input type="text" class="form-control" id="memberId"
													name="memberId" placeholder="이메일">
											</div>
											<div class="mb-3">
												<input type="password" class="form-control" id="memberPw"
													name="memberPw" placeholder="비밀번호">
											</div>
											<button type="submit" id="loginBtn" class="btn btn-primary">로그인</button>
											<!-- 비밀번호 찾기 버튼 추가 -->
											<button type="button" class="btn btn-link"
												id="forgotPasswordLink">비밀번호 찾기</button>
										</form>
									</div>
								</div>
							</div>
						</div>

						<!-- 비밀번호-재설정 이메일 인증 모달 -->
						<div class="modal fade" id="forgotPasswordModal" tabindex="-1"
							aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="forgotPasswordModalLabel">비밀번호
											찾기</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body" id="cert-modal-body">
										<div class="row mb-3">
											<p>비밀번호를 잊으셨나요?</p>
											<br>
											<p>가입했던 이메일을 적어주세요.</p>
											<br>
											<p>입력하신 이메일 주소로 인증번호를 보내드릴게요.</p>
											<br>
										</div>
										<!-- 비밀번호 찾기 폼 추가 -->
										<form id="forgotPasswordForm" action="" method="post"
											autocomplete="off">
											<!-- 비밀번호 찾기 폼 요소들을 여기에 추가 -->
											<div class="mb-3">
												<input type="email" class="form-control" id="email"
													name="memberId" placeholder="이메일">
											</div>
											<button type="button" class="btn-send btn btn-primary">
												<i class="fa-solid fa-spinner fa-spin"></i> <span>이메일
													보내기</span>
											</button>
											<div class="cert-wrapper pt-10">
												<input type="text" class="cert-input form-input w-70">
												<button type="button" class="btn btn-cert">확인완료</button>
											</div>
											<div class="valid-feedback left">이메일 입력 후 인증해주세요</div>
											<div class="invalid-feedback left">이미 사용중인 이메일입니다</div>
										</form>
									</div>
								</div>
							</div>
						</div>

						<!-- 비밀번호 재설정 모달 -->
						<div class="modal fade" id="resetPasswordModal" tabindex="-1"
							aria-labelledby="resetPasswordModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="resetPasswordModalLabel">비밀번호
											재설정</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<!-- 비밀번호 재설정 폼 추가 -->
										<form id="resetPasswordForm" action="member/changePw"
											method="post">
											<!-- 비밀번호 재설정 폼 요소들을 여기에 추가 -->
											<div class="mb-3">
												<input type="password" class="form-control" id="newPassword"
													name="newPassword" placeholder="새로운 비밀번호" required>
											</div>
											<div class="mb-3">
												<input type="password" class="form-control"
													id="confirmPassword" name="confirmPassword"
													placeholder="비밀번호 확인" required>
											</div>
											<button type="submit" class="btn btn-primary">비밀번호
												재설정</button>
										</form>
									</div>
								</div>
							</div>
						</div>
						<hr>
					</header>
					<section>