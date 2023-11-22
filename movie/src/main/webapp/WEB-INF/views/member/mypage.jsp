<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script src="/js/mypage.js"></script>
<link rel="stylesheet" type="text/css" href="/css/test.css">

<!-- 회원 프로필 관련 -->
<script>
$(function(){
	//변경 버튼 누르면 이미지를 업로드 하고 이미지 교체
	$(".image-chooser").change(function(){
		
		var input =this;
		console.log(input);
		console.log(input.files[0]);
		if(input.files.length == 0) return;
		
		//ajax로 multipart업로드
		var form = new FormData();
		console.log(form);
		form.append("image",input.files[0]);
		$.ajax({
			url: contextPath+"/member/upload",
			method:"post",
			processData:false,
			contentType:false,
			data:form,
			success:function(imageNo){
				console.log(imageNo);
				//회원 이미지 교체
				$(".member-image").attr("src","/image/" +imageNo);
			},
			error:function(){
				alert("통신 오류 발생 \n잠시 후 다시 시도해주세요");
			},
		});
	});
	$(".image-delete").click(function(){
		
		var choice = window.confirm("정말 이미지를 지우시겠습니까?");
		if(choice == false) return;
		
		$.ajax({
			url:contextPath+"/member/delete",
			method:"delete",
			
			success:function(response){
				$(".member-image").attr("src","/images/user.jpg");
			}
		});
	});
});
</script> 

<!-- 비밀번호 변경 모달 -->
<script>
function openChangePasswordModal() {
  $('#changePasswordModal').modal('show');
}

// 비밀번호 변경 처리
function changePassword() {
  var newPassword = $('#memberPassword').val();
  var confirmPassword = $('#password-check').val();

  
  // 비밀번호 일치 여부 확인
  if (newPassword !== confirmPassword) {
    alert('비밀번호가 일치하지 않습니다.');
    return;
  }
  

  //비밀번호 변경 요청
  $.ajax({
	  url: "http://localhost:8080/member/newPw",
	  method: "POST",
	  data: {
		  memberPw : newPassword
	  },
	  success: function(response){
		  alert("비밀번호가 변경되었습니다! 다시 로그인해주세요.");
		  
		  $('#changePasswordModal').modal('hide');
		  
		  window.location.href = "/";
	  },
	  error : function (xhr, status, error){
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
    $('#changeInfoModal').modal('show');
  }

  function changeInfo() {

    var memberNickname = $('#memberNickname').val();
    var memberBirth = $('#memberBirth').val();
    var memberContact = $('#memberContact').val();
    
    // AJAX를 통해 서버로 회원 정보 전송
    $.ajax({
      url: "http://localhost:8080/member/change",
      method: "POST",
      data: {
        memberNickname: memberNickname,
        memberBirth: memberBirth,
        memberContact: memberContact
      },
      success: function(response) {
    	  console.log(response);
        // 성공 시 모달 닫기 및 화면 갱신
        $('#changeInfoModal').modal('hide');
        window.alert("수정이 완료되었습니다!");
        // 새로고침
        location.reload();
      },
      error: function(xhr, status, error) {
        alert("회원 정보 변경에 실패했습니다. 다시 시도해주세요.");
      }
    });
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
    console.log(memberPw);
    
    $.ajax({
      url: "http://localhost:8080/member/exit",
      method: "POST",
      data: {
        memberPw: memberPw
      },
      success: function(response) {
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

<div class="container w-500">

	<div class="row mv-30">
	<c:choose>
	<c:when test="${memberImage == null}">
		<img src="${pageContext.request.contextPath}/images/user.jpg" style="width:200px; height:200px;"
		class="img-fluid rounded-circle member-image">
	</c:when>
	<c:otherwise>
	<img src="${pageContext.request.contextPath}/image/${memberImage}" style="width:200px; height:200px;"
		class="img-fluid rounded-circle member-image">
	</c:otherwise>
	</c:choose>
	
	<div class="row left flex-container w-500">
	<div class="row text-border">
	${memberDto.memberNickname}
	</div>
	<div class="row">
	${memberDto.memberId}
	</div>
	<div class="row">
	${memberDto.memberJoin} 가입
	</div>
		<br>
		
		<!-- 라벨을 만들고 파일선택창을 숨김 -->
		<label>
			<input type="file" class="image-chooser" accept="image/*" 
														style="display:none;">
		<i class="fa-solid fa-camera blue fa-2x"></i>
		</label>	
		<i class="fa-solid fa-trash-can red fa-2x image-delete"></i>
	</div>
	
	
	<div class="row mt-40">
		<button class="btn w-100" onclick="openChangePasswordModal()">
			<i class="fa-solid fa-key"></i>
			비밀번호 변경
		</button>
	</div>
	
	<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="changePasswordModal">비밀번호 변경</h5>
        
      </div>
      <div class="modal-body">
        <!-- 비밀번호 변경 폼 -->
        <form id="changePasswordForm" action="" method="post" autocomplete="off" onsubmit="changePassword(); return false;">
          <!-- 비밀번호 입력 -->
          <div class="form-group">
            <label for="newPassword">새 비밀번호</label>
            <input type="password" class="form-control" name="memberPw" id="memberPassword">
            <div class="valid-feedback">올바른 형식입니다</div>
            <div class="invalid-feedback">형식이 올바르지 않습니다</div>
          </div>
          <!-- 확인용 비밀번호 입력 -->
          <div class="form-group">
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" class="form-control" name="confirmPassword" id="password-check">
            <div class="valid-feedback"></div>
            <div class="invalid-feedback"></div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary" onclick="changePassword()">변경하기</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달 끝 -->
	
	<!-- 회원정보 수정 모달 -->
	<div class="row">
		<a class="btn w-100" onclick="openChangeInfoModal()">
			<i class="fa-solid fa-user"></i>
			개인정보 수정
		</a>
	</div>
	
	<div class="modal fade" id="changeInfoModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
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
            <input type="text" class="form-control" name="memberNickname" id="memberNickname" value="${memberDto.memberNickname}">
         	<div class="valid-feedback"></div>
            <div class="invalid-feedback"></div>
          </div>
          <!-- 생년월일 입력 -->
          <div class="form-group">
            <label for="memberBirth">생년월일</label>
            <input type="date" class="form-control" name="memberBirth" id="memberBirth" value="${memberDto.memberBirth}">
          	<div class="invalid-feedback">잘못된 날짜 형식입니다</div>
          </div>
          <!-- 연락처 입력 -->
          <div class="form-group">
            <label for="memberContact">연락처</label>
            <input type="text" class="form-control" name="memberContact" id="memberContact" value="${memberDto.memberContact}">
          	<div class="valid-feedback">사용 가능한 전화번호입니다</div>
            <div class="invalid-feedback">형식이 올바르지 않습니다</div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary" onclick="changeInfo()">수정하기</button>
      </div>
    </div>
  </div>
</div>
	

	<div class="row mb-40">
		<a class="btn btn-negative w-100" onClick="openExitModal()">
			<i class="fa-solid fa-user-xmark"></i>
			회원 탈퇴
		</a>
		<hr>
	</div> 
	</div>
</div>


	<!-- 회원 탈퇴 모달 -->
<div class="modal fade" id="exitModal" tabindex="-1" role="dialog" aria-labelledby="withdrawModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
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
        <button type="submit" class="btn btn-danger" onclick="exitMember()">탈퇴하기</button>
      </div>
    </div>
  </div>
</div>

<%-- <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>
 --%>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

