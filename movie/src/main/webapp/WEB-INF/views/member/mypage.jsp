<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

<style>
.center-section {
	height: 48px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.container-border {
	/* border-color: red;  */
	border-radius: 10px;
	border-top: 3px solid #eccccc;
	border-bottom: 3px solid #eccccc;
	border-left: 3px solid #eccccc;
	border-right: 3px solid #eccccc;
}

.sub-border-side {
	border-top: 2px solid #9e9d9d;
	border-bottom: 2px solid #9e9d9d;
	border-right: 2px solid #9e9d9d;
	border-left: 2px solid #9e9d9d;
}

.sub-border-center {
	border-top: 2px solid #9e9d9d;
	border-bottom: 2px solid #9e9d9d;
}

.setting-area {
	/* 		position: absolute; */
	width: 155spx;
	height: 70px;
	display: none;
	/* 		padding: 0.5em 1em; */
	/* 		top: 216px; */
	/* 		left: 1230px; */
	/* 		transform: translate(-50%, -50%);	 */
}

.top-setting-area {
	background: white;
	/* 		box-shadow: 0 0 0 2px #B33939; */
	/* 		border-radius: 2px; */
	border-top: 2px solid #eccccc;
	border-right: 2px solid #eccccc;
	border-left: 2px solid #eccccc;
	border-top-left-radius: 6px;
	border-top-right-radius: 6px;
}

.mid-setting-area {
	background: white;
	border-right: 2px solid #eccccc;
	border-left: 2px solid #eccccc;
}

.bottom-setting-area {
	background: white;
	border-bottom: 2px solid #eccccc;
	border-right: 2px solid #eccccc;
	border-left: 2px solid #eccccc;
	border-bottom-left-radius: 6px;
	border-bottom-right-radius: 6px;
}
.btn-danger{
	background-color:#B33939;
}
.btn-secondary{
	background-color:rgb(241, 185, 185);
	border:rgb(241, 185, 185);
	}
.btn-secondary:hover{
	background:#eccccc;
	border:#eccccc;
	}

</style>

<script src="/js/mypage.js"></script>
<!-- 회원 프로필 관련 -->
<script>
	$(function() {

		$(".fa-gear").click(function() {
			$(".setting-area").toggle();
		});

		$("#logoutConfirmBtn").click(function() {
			window.location.href = "/member/logout";
		});

		$(".logout-btn").click(function() {
			$('#logoutConfirmationModal').modal('show');
		});

		$(".close-logoutCon").click(function() {
			$('#logoutConfirmationModal').modal('hide');
			return false;
		});

		//변경 버튼 누르면 이미지를 업로드 하고 이미지 교체
		$(".image-chooser").change(function() {

			var input = this;
			console.log(input);
			console.log(input.files[0]);
			if (input.files.length == 0)
				return;

			//ajax로 multipart업로드
			var form = new FormData();
			console.log(form);
			form.append("image", input.files[0]);
			$.ajax({
				url : contextPath + "/rest/member/upload",
				method : "post",
				processData : false,
				contentType : false,
				data : form,
				success : function(imageNo) {
					console.log(imageNo);
					//회원 이미지 교체
					$(".member-image").attr("src", "/rest/image/" + imageNo);
				},
				error : function() {
					alert("통신 오류 발생 \n잠시 후 다시 시도해주세요");
				},
			});
		});
		$(".image-delete").click(function() {

			var choice = window.confirm("정말 이미지를 지우시겠습니까?");
			if (choice == false)
				return;

			$.ajax({
				url : contextPath + "/rest/member/delete",
				method : "delete",

				success : function(response) {
					$(".member-image").attr("src", "/images/user.jpg");
				}
			});
		});
	});
</script>

<!-- 비밀번호 변경 모달 -->
<script>
	function openChangePasswordModal() {
		//입력값 초기화 처리
		 $(".pw").removeClass("is-valid is-invalid");
		 $('#newPw').val('');
	   	 $('#pw-check').val('');
		$('#changePasswordModal').modal('show');
	}

    // 비밀번호 변경 처리
    function changePassword() {
        var newPassword = $('#newPw').val();
        var confirmPassword = $('#pw-check').val();

        // 비밀번호가 입력되지 않았을 경우
        if (!newPassword || !confirmPassword || newPassword.trim() === '' || confirmPassword.trim() === '') {
            alert('비밀번호가 입력되지 않았습니다. \n 다시 시도해주세요.');
            return;
        }

        // 비밀번호 일치 여부 확인
        if (newPassword !== confirmPassword) {
            alert('비밀번호가 일치하지 않습니다.');
            return;
        }
        

        //비밀번호 변경 요청
        $.ajax({
            url: "http://localhost:8080/rest/member/newPw",
            method: "POST",
            data: {
                memberPw: newPassword
            },
            success: function (response) {
                alert("비밀번호 재설정이 완료되었습니다. 다시 로그인해주세요!");

                $('#changePasswordModal').modal('hide');

                window.location.href = "/";
            },
            error: function (xhr, status, error) {
                alert("비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
            }

        });

        // 모달 닫기
         $('#changePasswordModal').modal('hide');
     }
	


</script>

<!-- 회원 정보 변경 모달 -->
<script>

	function openChangeInfoModal() {
		 resetModalInputs();
		$('#changeInfoModal').modal('show');
	}
	
	// 기존 값 초기화 함수
	function resetModalInputs() {
		// 닉네임 입력 필드 초기화
        $('#memberNickname').val('${memberDto.memberNickname}');

        // 생년월일 입력 필드 초기화
        $('#memberBirth').val('${memberDto.memberBirth}');

        // 연락처 입력 필드 초기화
        $('#memberContact').val('${memberDto.memberContact}');


	    // 피드백 메시지 초기화
	    $(".info").removeClass("is-valid is-invalid");
	}

	function changeInfo() {

		var memberNickname = $('#memberNickname').val();
		var memberBirth = $('#memberBirth').val();
		var memberContact = $('#memberContact').val();

		// AJAX를 통해 서버로 회원 정보 전송
		$.ajax({
			url : "http://localhost:8080/rest/member/change",
			method : "POST",
			data : {
				memberNickname : memberNickname,
				memberBirth : memberBirth,
				memberContact : memberContact
			},
			success : function(response) {
					console.log(response);
	                // 성공 시 모달 닫기 및 화면 갱신
	                $('#changeInfoModal').modal('hide');
	                window.alert("수정이 완료되었습니다!");
	                location.reload();
	          
	        },
			error : function(xhr, status, error) {
				alert("회원 정보 변경에 실패했습니다. 다시 시도해주세요.");
			}
		});
		
		$('#changeInfoModal').modal('hide');
	}
</script>

<!-- 회원 탈퇴 모달 -->
<script>
	function openExitModal() {
		$('#exitModal').modal('show');
	}

  // 회원 탈퇴 처리
  function exitMember() {
    var memberPw = $('#inputPw').val(); // 사용자로부터 입력받은 비밀번호
    //console.log(memberPw);
    
    
    $.ajax({
      url: "http://localhost:8080/rest/member/exit",
      method: "POST",
      data: {
        memberPw: memberPw
      },
      success: function(response) {
    	  window.confirm("정말 탈퇴하시겠습니까?");
         alert(response);
          if (response.includes("탈퇴")) {
              window.location.href = "/";
          }
        // 모달 닫기
        $('#exitModal').modal('hide');
      },
      error: function(xhr, status, error) {
         console.error(xhr.responseText);
        alert("비밀번호가 일치하지 않습니다. 다시 시도해주세요.");
      }
    });
  }
</script>

<div class="container-fluid mt-5">
	<div class="row">
		<div
			class="col-md-8 offset-md-2 container-border shadow-lg bg-body-tertiary rounded">

			<div class="d-flex mb-2 mt-3">
				<div class="d-flex flex-row">
					<div class="p-2 ms-1">
						<c:choose>
							<c:when test="${memberImage == null}">
								<img src="${pageContext.request.contextPath}/images/user.jpg"
									class="img-fluid rounded-circle member-image img-thumbnail"
									style="width: 230px; height: 230px;">
							</c:when>
							<c:otherwise>
								<img
									src="${pageContext.request.contextPath}/rest/image/${memberImage}"
									class="img-fluid rounded-circle member-image img-thumbnail"
									style="width: 230px; height: 230px;">
							</c:otherwise>
						</c:choose>
					</div>
					<div class="p-2 d-flex align-items-end">
						<div class="me-2">
							<label> <input type="file" class="image-chooser"
								accept="image/*" style="display: none;"> <i
								class="fa-solid fa-camera blue fa-xl"></i>
							</label>
						</div>
						<div class="">
							<i class="fa-solid fa-trash-can red fa-xl image-delete"></i>
						</div>
					</div>
				</div>
				<div class="d-flex ms-auto">
					<div class="container-fluid setting-area ms-auto mt-2">
						<div class="row">
							<div class="col text-center top-setting-area">
								<a class="btn" onclick="openChangePasswordModal()">비밀번호 변경</a>
							</div>
						</div>
						<div class="row">
							<div class="col text-center mid-setting-area">
								<a class="btn" onclick="openChangeInfoModal()">개인정보 수정</a>
							</div>
						</div>
						
						<div class="row">
							<div class="col text-center bottom-setting-area">
								<a class="btn" onclick="openExitModal()">회원 탈퇴</a>
							</div>
						</div>
					</div>
					<div class="p-2 me-2">
						<i class="fa-solid fa-gear fa-xl"></i>
					</div>
				</div>
			</div>

			<div class="container mb-2">
				<div class="row">
					<div class="col d-flex">

						<div class="row">
							<div class="col" style="font-size: 32px;">
								<strong>${memberDto.memberNickname}</strong>
							</div>
						</div>
						<c:if test="${sessionScope.level == '평론가'}">
							<div class="row">
								<div class="col center-section ms-2">
									<i class="fa-solid fa-crown fa-xl"></i>
								</div>
							</div>
						</c:if>
					</div>
				</div>

				<div class="row">
					<div class="col">${memberDto.memberId}</div>
				</div>

				<div class="row">
					<div class="col">
						<fmt:formatDate value="${memberDto.memberJoin}"
							pattern="yyyy년 MM월 dd일" />
						가입
					</div>
				</div>
			</div>

			<div class="container text-center">
				<div class="row align-items-center">
					<div
						class="col justify-content-between d-flex flex-column 
                                align-items-center sub-border-side"
						style="background-color: #eedbdb;">
						<div class="text-center center-section" style="font-size: 22px;">
							<a href="/member/list/reviewList?memberId=${memberDto.memberId}">
								${reviewCount} </a>
						</div>
						<div class="text-center center-section" style="font-size: 22px;">리뷰</div>
					</div>
					<div
						class="col justify-content-between d-flex flex-column
                                align-items-center sub-border-center"
						style="background-color: #eedbdb;">
						<div class="text-center center-section" style="font-size: 22px;">
							<a href="list/ratingList">
								${ratingCount} </a>
						</div>
						<div class="text-center center-section" style="font-size: 22px;">평점</div>
					</div>
					<div
						class="col justify-content-between d-flex flex-column
                                align-items-center sub-border-side"
						style="background-color: #eedbdb;">
						<div class="text-center center-section" style="font-size: 22px;">
							<a href="/member/list/wishList?memberId=${memberDto.memberId}">
								${wishCount} </a>
						</div>
						<div class="text-center center-section" style="font-size: 22px;">찜</div>
					</div>
				</div>
			</div>

			<div class="d-flex mb-1 mt-3">
				<div class="p-2 ms-3" style="font-size: 24px;">오늘의 영화 추천이에요!</div>
				<div class="ms-auto p-2 me-2">
					<!--                         더보기 > -->
				</div>
			</div>

			<div class="swiper row">
				<div class="swiper-wrapper">
					<c:forEach var="todayMovieVO" items="${todayMovieList}">
						<div class="swiper-slide">
							<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
								<div>
									<a href="/movie/detail?movieNo=${todayMovieVO.movieNo}"> <img
										src="/rest/image/${todayMovieVO.imageNo}" class="img-thumbnail"
										style="width: 250px; height: 310px">
									</a>
								</div>
								<div class="col">
									<a href="/movie/detail?movieNo=${todayMovieVO.movieNo}">
										${todayMovieVO.movieName} </a>
								</div>
								<div class="col">
									<fmt:formatDate value="${todayMovieVO.movieReleaseDate}"
										pattern="yyyy" />
									/ ${todayMovieVO.movieNation}
								</div>
								<c:if test="${todayMovieVO.ratingAvg != 0}">
									<div class="col">
										평균 <i class="fa-solid fa-star"></i> ${todayMovieVO.ratingAvg}점
									</div>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next custom-next"></div>
				<div class="swiper-button-prev custom-prev"></div>
			</div>
		</div>
	</div>
</div>

<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="changePasswordModal" tabindex="-1"
	role="dialog" aria-labelledby="changePasswordModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="changePasswordModal">비밀번호 변경</h5>
			</div>
			
            <div class="modal-body">
                <!-- 비밀번호 변경 폼 -->
                <form id="changePasswordForm" action="" method="post" autocomplete="off"
                    onsubmit="changePassword(); return false;">
                    <!-- 비밀번호 입력 -->
                    <div class="form-group">
                        <label for="newPassword">새 비밀번호</label>
                        <input type="password" class="form-control pw" name="memberPw" id="newPw">
                        <div class="valid-feedback">올바른 형식입니다</div>
            			<div class="invalid-feedback">형식이 올바르지 않습니다</div>
                  </div>
                    <!-- 확인용 비밀번호 입력 -->
                    <div class="form-group">
                        <label for="confirmPassword">비밀번호 확인</label>
                        <input type="password" class="form-control pw" name="confirmPassword" id="pw-check">
                    	<div class="valid-feedback"></div>
            			<div class="invalid-feedback"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="submit" class="btn btn-danger" onclick="changePassword()">변경하기</button>
            </div>
        </div>
    </div>
</div>
<!-- 모달 끝 -->

<!-- 회원정보 수정 모달 -->
<div class="modal fade" id="changeInfoModal" tabindex="-1" role="dialog"
	aria-labelledby="changePasswordModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="changeInfoModal">개인정보 수정</h5>
			</div>

            <div class="modal-body">
                <!-- 회원정보 변경 폼 -->
                <form id="changeInfoForm" action="" method="post" autocomplete="off" onsubmit="changeInfo();">

                    <!-- 닉네임 입력 -->
                    <div class="form-group">
                        <label for="memberNickname">닉네임</label>
                        <input type="text" class="form-control info" name="memberNickname" id="memberNickname"
                            value="${memberDto.memberNickname}">
                            <div class="valid-feedback"></div>
           					<div class="invalid-feedback"></div>
                    </div>
                    <!-- 생년월일 입력 -->
                    <div class="form-group">
                        <label for="memberBirth">생년월일</label>
                        <input type="date" class="form-control info" name="memberBirth" id="memberBirth"
                            value="${memberDto.memberBirth}">
                        <div class="invalid-feedback">잘못된 날짜 형식입니다</div>
                    </div>
                    <!-- 연락처 입력 -->
                    <div class="form-group">
                        <label for="memberContact">연락처</label>
                        <input type="text" class="form-control info" name="memberContact" id="memberContact"
                            value="${memberDto.memberContact}">
                       	<div class="valid-feedback">사용 가능한 전화번호입니다</div>
           				<div class="invalid-feedback">형식이 올바르지 않습니다</div>
                            
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="submit" class="btn btn-danger" onclick="changeInfo()">수정하기</button>
            </div>
        </div>
    </div>
</div>
<!-- 모달 끝 -->

<!-- 회원 탈퇴 모달 -->

<div class="modal fade" id="exitModal" tabindex="-1" role="dialog" aria-labelledby="withdrawModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exitModalLabel">회원 탈퇴</h5>
            </div>
            <div class="modal-body">
                <!-- 탈퇴 확인 폼 -->
                <form id="exitForm" action="/member/exit" method="post" autocomplete="off" onsubmit="exitMember();">
                    <p>정말 탈퇴하시겠습니까? 탈퇴 후 모든 정보는 자동으로 삭제됩니다.</p>
                    <div class="form-group">
                        <input type="password" name="memberPw" id="inputPw" class="form-control"
                            placeholder="비밀번호를 입력해주세요">
                    </div>
                    <c:if test="${param.error != null}">
                        <h4>비밀번호가 일치하지 않습니다</h4>
                    </c:if>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-danger" id="exitMember" onclick="exitMember()">탈퇴하기</button>
            </div>
        </div>
    </div>

</div>
<!-- 모달 끝 -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

