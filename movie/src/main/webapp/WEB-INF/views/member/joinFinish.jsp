<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.btn-link{
        color: rgb(179, 57, 57);
        font-size: 18px;
}
.btn-link:hover{
    background-color: rgb(179, 57, 57, 0.1);
    color: rgb(179, 57, 57);
    font-size: 18px;
}
.btn-link:active{
    background-color: rgb(179, 57, 57, 0.1);
    color: rgb(179, 57, 57);
    font-size: 18px;
}
.btn-primary {
    background-color: rgb(179, 57, 57);;
    color:white;
    border-color: rgb(179, 57, 57);
    font-size: 16px;
}
.btn-primary:hover {
    background-color: rgb(179, 57, 57, 0.8);
    color: white;
    border-color: rgb(179, 57, 57, 0.8);
    font-size: 16px;
}
.btn-primary:active {
    background-color: rgb(179, 57, 57);
    color: white;
    border-color: rgb(179, 57, 57);
    font-size: 16px;
}
.btn-danger,
.btn-danger:hover{
    background-color: white;
    color:rgb(179, 57, 57);
    border-color: rgb(179, 57, 57);
    border-width: 2px;
    font-size: 16px;
}
.btn-danger:active{
    background-color: white;
    color:rgb(179, 57, 57, 0.5);
    border-color: rgb(179, 57, 57, 0.5);
    border-width: 2px;
    font-size: 16px;
}
.btn-success,
.btn-success:hover{
    background-color: rgb(179, 57, 57);
    color:white;
    border-color: rgb(179, 57, 57);
    border-width: 2px;
    font-size: 16px;
}
.btn-success:active{
    background-color: rgb(179, 57, 57, 0.5);
    color:white;
    border-color: rgb(179, 57, 57, 0.5);
    border-width: 2px;
    font-size: 16px;
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

<!-- 모달 창 스크립트 -->
<script>
    $(document).ready(function () {
        const checkboxes = $('.check-item');
        let checkedCount = 0;

        checkboxes.change(function () {
            if (this.checked) {
                checkedCount += 1;
                if (checkedCount > 5) {
                    this.checked = false;
                    checkedCount -= 1;
                    // 모달 창 표시 - 체크박스 5개 이상 선택 불가능 메시지
                    $('#limitWarningModal').modal('show');
                }
            } else {
                checkedCount -= 1;
            }
        });

        $(".btn-save").click(function () {
            // 체크박스를 1개 이상 선택했는지 확인
            if ($("[name=selectedGenres]:checked").length === 0) {
                // 모달 창 표시 - 체크박스 1개 이상 선택 필요 메시지
                $('#selectAtLeastOneModal').modal('show');
                return false;
            }

            // 모달 창 표시 - 선택 완료 메시지
            $('#selectionCompleteModal').modal('show');
            return false; // 페이지 이동을 막기 위해 false 반환
        });

        $(".btn-pass").click(function () {
            // 모달 창 표시 - 건너뛰기 확인 메시지
            $('#skipConfirmationModal').modal('show');
        });

        // 확인 버튼을 눌렀을 때의 동작
        $("#skipConfirmBtn").click(function () {
            // 페이지 이동
            window.location.href = "/";
        });

        // 선택 완료 모달 확인 버튼 클릭 시 페이지 이동
        $(".close-choose-complete").click(function () {
            // 폼 제출
            $("#joinForm").submit();
        });

        // 각각의 모달창 닫기
        $(".close-choose-one").click(function () {
            $('#selectAtLeastOneModal').modal('hide');
        });
        $(".close-choose-five").click(function () {
            $('#limitWarningModal').modal('hide');
        });
        $(".close-skip").click(function () {
            $('#skipConfirmationModal').modal('hide');
        });

    });
</script>

<!-- 추가된 부분: Bootstrap JavaScript 라이브러리 로드 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<form action="joinFinish" method="post" autocomplete="off" id="joinForm">
<div class="container-fluid">
    <div class="row">
        <div class="col-md-8 offset-md-2">
        
            <div class="row mt-4">
                <div class="col text-center me-2">
                   <h3 style="color:#B33939;"><i class="fa-solid fa-check fa-2xl"></i>
                   <strong class="ms-2">회원가입 완료</strong>
                   </h3>
                </div>
            </div>
            
            <div class="row mt-4">
                <div class="col text-center mb-2">
                   <h4>선호장르 선택 후 맞춤 정보를 받아보세요!</h4>
                </div>
            </div>
    
            <!-- 장르 체크박스 (최대 5개만 가능) -->
                <div class="row mt-3 genre-name mx-auto" style="width:340px;">
            <c:forEach var="genreDto" items="${list}" varStatus="status">
                    <div class="col-md-6 mb-3">
			            <label class="d-flex align-items-center">
			                <input type="checkbox" class="check-item" name="selectedGenres" value="${genreDto.genreName}" style="width: 20px; height: 20px; margin-right: 9px;">
			                <span style="font-size:16px; height:25px;" class="badge bg-danger badge-pill">${genreDto.genreName}</span>
			            </label>
			        </div>
            </c:forEach>
                </div>
    
            <div class="row mt-3 text-center">
               <div class="col ">
                  <button type="button" class="btn btn-primary btn-save mb-2" style="width:340px;">선택완료</button>
               </div>
            </div>
            <div class="row text-center">
            	<div class="col">
                  <button type="button" class="btn btn-secondary btn-pass" style="width:340px;">건너뛰기</button>
            	</div>
            </div>
    
        </div>
    </div>
</div>
</form>

<!-- 선택 완료 알림 모달 -->
<div class="modal fade" id="selectionCompleteModal" tabindex="-1" 
    role="dialog" aria-labelledby="selectionCompleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="selectionCompleteModalLabel">알림</h5>
                <button type="button" class="btn-close close-choose-complete" 
                    data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                선호 장르 선택 완료!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary close-choose-complete" 
                    data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- 체크박스 1개 이상 선택 필요 모달 -->
<div class="modal fade" id="selectAtLeastOneModal" tabindex="-1" 
    role="dialog" aria-labelledby="selectAtLeastOneModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="selectAtLeastOneModalLabel">알림</h5>
                <button type="button" class="btn-close close-choose-one" 
                    data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                선호 장르를 1개 이상 선택하세요.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary close-choose-one" 
                    data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- 체크박스 5개 이상 선택 불가능 모달 -->
<div class="modal fade" id="limitWarningModal" tabindex="-1" 
    role="dialog" aria-labelledby="limitWarningModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="limitWarningModalLabel">알림</h5>
                <button type="button" class="btn-close close-choose-five" 
                    data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                선호 장르는 5개 이하만 선택이 가능합니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary close-choose-five" 
                    data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- 건너뛰기 모달 창 -->
<div class="modal fade" id="skipConfirmationModal" tabindex="-1" 
    role="dialog" aria-labelledby="skipConfirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="skipConfirmationModalLabel">알림</h5>
                <button type="button" class="btn-close close-skip" 
                    data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body"> 
               추후 선택이 불가능합니다. 정말 건너뛰시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-skip" 
                	data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" 
                	id="skipConfirmBtn">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery 로드 부분 추가 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Bootstrap JavaScript 로드 부분 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>