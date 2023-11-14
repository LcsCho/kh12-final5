<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        /* 추가적인 스타일이 필요하다면 여기에 추가 */
        .modal-dialog {
            width: 400px;
            height: 300px;
        }

        .btn-next {
            display: none;
        }
    </style>
    
    



<h1 class="text-center">환영합니다! MVC 입니다.</h1>
<h3 class="text-center">
    <a href="#" class="btn btn-navy" data-bs-toggle="modal" data-bs-target="#loginModal">로그인하기</a>
</h3>

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- ... (로그인 모달 내용) ... -->
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
                    <button type="button" class="btn btn-primary btn-prev">이전</button>
                    <button type="button" class="btn btn-primary btn-next">다음</button>
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
            <!-- ... (비밀번호 재설정 모달 내용) ... -->
             <div class="modal-header">
                <h5 class="modal-title" id="forgotPasswordModalLabel">비밀번호 찾기 및 회원가입</h5>
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
</form>

<!-- 비밀번호 재설정 폼 -->
<form id="resetPw" action="" method="post">
    <div class="row left">
        <label>비밀번호 <i class="fa-solid fa-asterisk red"></i></label>
        <input type="password" name="memberPw" placeholder="영문,숫자,특수문자 반드시 1개 이상 포함" class="form-input w-100">
        <div class="success-feedback">올바른 비밀번호 형식입니다</div>
        <div class="fail-feedback">잘못된 비밀번호 형식입니다</div>
    </div>
    <div class="row left">
        <label>비밀번호 확인 <i class="fa-solid fa-asterisk red"></i></label>
        <input type="password" id="password-check" placeholder="비밀번호 한 번 더 입력" class="form-input w-100">
        <div class="success-feedback">비밀번호가 일치합니다</div>
        <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
        <div class="fail2-feedback">비밀번호를 먼저 작성하세요</div>
    </div>
</form>
	<div class="cert-wrapper pt-10">
    <input type="text" class="cert-input form-input w-70">
    <button type="button" class="btn-cert btn btn-navy">확인완료</button>
</div>
<div class="fail-feedback left">이메일 입력 후 인증해주세요</div>
<div class="fail2-feedback left">이미 사용중인 이메일입니다</div>
</div>
</div>
</div>
</div>


</body>
</html>
	