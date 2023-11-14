<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<script>
    $(document).ready(function () {
        $('#loginModal').on('hidden.bs.modal', function () {
            // 여기에 모달이 닫힌 후 실행되는 코드 추가
            // 예: 로그인이 완료되면 메인 페이지로 리다이렉트
            window.location.href = '/'; // your_main_page에는 실제 메인 페이지 경로를 입력하세요
        });

        // 비밀번호 찾기 모달 표시를 위한 이벤트 처리
        $('#forgotPasswordLink').click(function () {
            $('#forgotPasswordModal').modal('show');
        });
    });
</script>

<style>
    /* 추가적인 스타일이 필요하다면 여기에 추가 */
    .modal-dialog{
    width:400px;
    height:300px;
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
                <!-- 비밀번호 찾기 폼 추가 -->
                <form action="forgotPassword" method="post">
                    <!-- 비밀번호 찾기 폼 요소들을 여기에 추가 -->
                    <div class="mb-3">
                        <input type="email" class="form-control" id="email" name="memberId" placeholder="이메일" required>
                    </div>
                    <button type="submit" class="btn btn-primary">이메일 보내기</button>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>