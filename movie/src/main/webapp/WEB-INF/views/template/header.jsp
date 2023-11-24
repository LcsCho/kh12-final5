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

<script src="js/header.js"></script>

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

//아이디(이메일) 정규식
var regex = /^[a-z0-9]+@[a-z]+\.(com|co\.kr|net)$/;

$(function(){
       //처음 로딩아이콘 숨김
       $(".btn-emailSend").find(".fa-spinner").hide();
       $(".cert-wrapper").hide();

       //인증번호 보내기 버튼을 누르면
       //서버로 비동기 통신을 보내 인증 메일 발송 요청
       $(".btn-emailSend").click(function(){
          var email = $("#email").val();
           //var email = $("[name=memberId]").val();
           if(email.length == 0 || !regex.test(email)) {//0이거나 형식이 맞지 않으면
        	   //$(".btn-send").prop("disabled", true);//버튼 비활성화
        	   window.alert("이메일 주소를 확인하시고 다시 시도해주세요.");
        	   return;
           }
           $(".btn-emailSend").prop("disabled", true);
           $(".btn-emailSend").find(".fa-spinner").show();
           $(".btn-emailSend").find("span").text("이메일발송중");
           $.ajax({
               url:"http://localhost:8080/rest/cert/resetPassword",
               method:"post",
               data:{certEmail: email},
               success:function(){
                   $(".btn-emailSend").prop("disabled", false);
                   $(".btn-emailSend").find(".fa-spinner").hide();
                   $(".cert-wrapper").hide();
                   $(".btn-cert").hide();
                   $(".btn-emailSend").find("span").text("인증번호 재발송");
                   // window.alert("이메일 확인하세요!");

                   $(".cert-wrapper").show();
                   $(".btn-cert").show();
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
                       $(".cert-input").removeClass("is-valid is-invalid")
                                       .addClass("is-valid");
                       $(".btn-cert").prop("disabled", true);
                       //상태객체에 상태 저장하는 코드
                       
                    // 이메일 인증이 성공하면 인증번호 입력창과 버튼을 숨김
                       $(".btn-send").find("span").text("인증완료!");
                       $(".btn-send").prop("disabled", true);
                       $(".cert-wrapper").hide();
                       $(".btn-cert").hide();
                       
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
    
$(document).ready(function () {
        // '비밀번호 재설정하러가기' 버튼 클릭 이벤트 처리
        $(document).on('click', '#resetPasswordButton', function () {
            // 비밀번호 재설정 모달을 띄움
            $('#resetPasswordModal').modal('show');
            //$('#forgotPasswordModal').modal('hide');
            $('#resetPasswordButton').hide();
        });
        
     // 비밀번호 재설정 폼 제출 이벤트 처리
        $("#resetPasswordForm").submit(function (event) {
            // 폼의 기본 동작을 막음
            event.preventDefault();

            // 새로운 비밀번호와 비밀번호 확인을 가져옴
            var newPassword = $("[name=memberPw]").val();
            var confirmPassword = $("[name=confirmPassword]").val();
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
                $("#suggestionsContainer").empty().hide();
                return;
            }
            
            // 추가된 부분: 입력이 있을 때 popularContainer 숨기기
            $("#popularContainer").hide();
            $("#recentContainer").hide();

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
                            .on("click", function () {
                                // 클릭한 연관 검색어를 검색 입력란에 설정
                                $("#searchInput").val($(this).text());

                                // form을 서버로 전송
                                $("#movieSearchForm").submit();
                            });
						
                        suggestionsContainer.append("<div>").append(movieLink);
                    }
                    $("#suggestionsContainer").show();
                },

                error: function (error) {
                    console.error("연관검색에 대한 오류 발생:", error);
                }
            });

        }, doneTypingInterval);
    });

    // 추가된 부분: Form이 제출될 때 추가적인 Ajax 요청
    $("#movieSearchForm").on("submit", function (event) {
        event.preventDefault(); // Prevent the default form submission

        var keyword = $("#searchInput").val();
        
        $.ajax({
            url: "/search/inputKeyword",
            method: "POST",
            data: { "keyword": keyword },
            success: function (response) {
                console.log("전송완료", response);
            },
            error: function (error) {
                console.error("에러:", error);
            }
        });
        
		
        // Continue with the form submission
        this.submit();
    });
    
    
    
 // 입력창이 클릭되었을 때의 이벤트 핸들러
    $("#searchInput").on("click", function () {
//         console.log("실행");
    	// 서버에 비동기 요청을 보냄
    	 var currentText = $(this).val().trim();
    	 if (currentText === "") {
	        $.ajax({
	            url: "/search/showPopular",
	            method: "GET",
	            success: function (response) {
// 	                console.log(response);
	            	var popularContainer = $("#popularContainer");
	                // 받아온 데이터를 popularContainer에 표시
	                popularContainer.empty();
	            	popularContainer.append($("<h3>").text("인기 검색어"));
	                for (var i = 0; i < response.length; i++) {
	                	var popularItem = $("<div>")
	                        .addClass("link link-underline link-underline-opacity-0 link-danger")
	                        .text(response[i])
	                        .on("click", function () {
	                            // 클릭한 인기 검색어를 검색 입력란에 설정
	                            $("#searchInput").val($(this).text());
	
	                            // 폼을 서버로 전송
	                            $("#movieSearchForm").submit();
	                        });
	
	                    popularContainer.append(popularItem);
	                }
	
	                // 인기 검색어를 표시한 후 popularContainer를 보여줌
	                popularContainer.show();
	            },
	            error: function (error) {
	                console.error("인기 검색어 불러오기에 실패했습니다.", error);
	            }
	        });
	        // 최근 검색어를 서버에서 가져오는 Ajax 요청
	        $.ajax({
	            url: "/search/showRecent",
	            method: "GET",
	            success: function (response) {

	            	var recentContainer = $("#recentContainer");

	            	
	            	if(response && response.length > 0){
	                recentContainer.empty();
	                recentContainer.append(
	                		$("<div>").addClass("d-flex")
	                		.append($("<div>").addClass("w-100").append($("<h3>").text("최근 검색어")))
	                		.append($("<div>").addClass("flex-shrink-1 me-2").append($("<i>").addClass("fas fa-times fa-2x delete-recent-all")))
	                		.on("click", function () {
	                	    	// 확인 창 띄우기
	                	        if (confirm("정말로 모든 검색 기록을 삭제하시겠습니까?")) {
	                	            // 사용자가 확인을 선택한 경우에만 Ajax 요청 보내기
	                	            $.ajax({
	                	                url: "/search/deleteAll",
	                	                method: "DELETE",
	                	                success: function(response) {
	                	                    // 요청이 성공하면 할 일 작성
	                	                    console.log("삭제 성공");
	                	                },
	                	                error: function(error) {
	                	                    // 요청이 실패하면 할 일 작성
	                	                    console.error("삭제 실패:", error);
	                	                }
	                	            });
	                	        }
							})
	                		)
	                

	                // 최대 5개까지만 출력
	                for (var i = 0; i < Math.min(response.length, 5); i++) {
	                    
	                	var keyword=response[i];
	                	var recentItem = $("<div>")
	                        .addClass("link link-underline link-underline-opacity-0 link-danger d-flex")
							.append($("<div>").addClass("w-100")
									.append(
										$("<span>")
											.text(keyword)
			                        			.on("click", function () {
						                            // 클릭한 최근 검색어를 검색 입력란에 설정
						                            $("#searchInput").val($(this).text());
					
						                            // 폼을 서버로 전송
						                            $("#movieSearchForm").submit();
			                        				})									
										)
									)
					        .append($("<div>").addClass("flex-shrink-1 me-2")
					        		.append(
					        			$("<i>")
					        			.addClass("fas fa-times")
					                		.on("click", function () {
					                			console.log(keyword);
					                			// 확인 창 띄우기
					                	        if (confirm("정말로 검색 기록을 삭제하시겠습니까?")) {
					                	            // 사용자가 확인을 선택한 경우에만 Ajax 요청 보내기
					                	            $.ajax({
					                	                url: "/search/deleteEach",
					                	                method: "DELETE",
					                	                data: {keyword: keyword},
					                	                success: function(response) {
					                	                    // 요청이 성공하면 할 일 작성
					                	                    console.log("삭제 성공");
					                	                },
					                	                error: function(error) {
					                	                    // 요청이 실패하면 할 일 작성
					                	                    console.error("삭제 실패:", error);
					                	                }
					                	            });
					                	        }
											})					        			
					        			)
					        		)



	                    recentContainer.append(recentItem);
	                }
	                recentContainer.show();
		            } else{	
		            	recenContainer.hide();
		            }
	        	},
	            error: function (error) {
	                console.error("최근 검색어 불러오기에 실패했습니다.", error);
	            }
	        });	       	
	        
	        
    	} 
        
        
        
    });

    // 다른 부분에서 입력창이 아닌 곳을 클릭했을 때 popularContainer를 숨김
    $(document).on("click", function (event) {
        if (!$(event.target).closest("#searchInput").length) {
            $("#popularContainer").hide();
            $("#recentContainer").hide();
            
        }
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


.delete-recent-all{
	color: rgb(179, 57, 57);
}

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

#suggestionsContainer, #popularContainer, #recentContainer {
	position: absolute;
	top: 100%;
	z-index: 1000;
	background-color: #fff;
	border: 1px solid #ccc;
	max-height: 200px;
	overflow-y: auto;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 50%; /* 입력창의 절반 크기로 조정 */
}
/* #recentContainer { */
/*     position: absolute; */
/*     top: 100%; */
/*     left: 40%; /* 오른쪽에 위치하도록 수정 */ */
/*     z-index: 1000; */
/*     background-color: #fff; */
/*     border: 1px solid #ccc; */
/*     max-height: 200px; */
/*     overflow-y: auto; */
/*     box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); */
/* } */
#suggestionsContainer {
    left: 0;
}

#popularContainer {
    left: 0;
    border-right: 0; /* 오른쪽 테두리 제거 */
}

#recentContainer {
    right: 0; /* 오른쪽 끝에 위치하도록 설정 */
    border-left: 0;
}




#popularContainer,#recentContainer,#suggestionsContainer {
	display: none;
}

#suggestionsContainer a, #popularContainer a, #recentContainer a {
	cursor: pointer;
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
													<div id="popularContainer"></div>
													<div id="recentContainer"></div>
													<div id="suggestionsContainer"></div>


												</div>
												<button
													class="btn btn-secondary my-2 my-sm-0 custom-search-btn c-btn"
													id="searchButton" disabled type="submit"
													style="height: fit-content;">검색</button>
											</form>
											<c:if test="${sessionScope.level == '관리자' }">
												<a href="http://localhost:3000/" class="btn c-btn ms-5"
													style="height: fit-content;"><i
													class="fa-solid fa-screwdriver-wrench fa-2x1"></i></a>
											</c:if>
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
									<div class="modal-header p-1">
										<button type="button" class="btn-close p-3"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
								<div class="modal-body">
									<div class="row">
								<div class="modal-title text-center">
									<img src="/images/mvc.png" width="200px" class="mx-auto">
									</div>
								</div>
								<div class="row">
									<div class="col">
										<div class="modal-title text-center" id="loginModalLabel"
												style="font-size:25px;">
										<strong>로그인</strong>
										</div>
									</div>
								</div>
										<!-- 로그인 폼 추가 -->
										<form id="loginForm" autocomplete="off">
											<!-- 로그인 폼 요소들을 여기에 추가 -->
											<div class="mb-3 mx-auto mt-3" style="width:380px;">
											<div class="form-floating">
												<input type="text" class="form-control" id="memberId"
													name="memberId" placeholder="">
													<label>ID(email)</label>
										</div>
									</div>
											<div class="mb-3 mx-auto" style="width:380px;">
												<div class="form-floating">
												<input type="password" class="form-control" id="memberPw"
													name="memberPw" placeholder="">
													<label>Password</label>
											</div>
										</div>
										<div class="mt-4" >
                    					  <div class="modal-title text-center mx-auto" style="width:380px;">
											<button type="submit" id="loginBtn" class="btn btn-danger btn-lg w-100">Login</button>
										  </div>
										</div>
											<!-- 비밀번호 찾기 버튼 추가 -->
									 <div class="row mt-2">
                   						 <div class="modal-title text-center">
											<button type="button" class="btn btn-link text-primary link-underline
                                           link-underline-opacity-0 link-underline-opacity-75-hover"
												id="forgotPasswordLink">비밀번호 찾기</button>
										</div>
									</div>
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
											<button type="button" class="btn-emailSend btn btn-primary">
												<i class="fa-solid fa-spinner fa-spin"></i> <span>이메일
													보내기</span>
											</button>
											<div class="cert-wrapper pt-10">
												<input type="text" class="cert-input form-control">
												<button type="button" class="btn-cert btn btn-primary">확인완료</button>
											</div>
											<div class="valid-feedback left"></div>
											<div class="invalid-feedback left"></div>
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