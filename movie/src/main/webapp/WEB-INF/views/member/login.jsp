<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<!--jquery CDN-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<style></style>

<script></script>
	
	<form action="login" method="post" autocomplete="off">
    <div class="container w-300">
        <div class="row pt-50">
            <h2>로그인 테스트</h2>
        </div>
        <div class="row pt-20">
            <input type="text" name="memberId" class="form-input login" placeholder="아이디를 입력해주세요">
        </div>
        <div class="row">
            <input type="password" name="memberPw" class="form-input login" placeholder="비밀번호를 입력해주세요">
        </div>
        <div class="row left">
            <c:if test="${param.error != null}">
                <h5 class="orange">아이디 또는 비밀번호가 일치하지 않습니다</h5>
            </c:if>
        </div>
        <div class="row pt-20">
            <button class="btn btn-orange w-100" type="submit">로그인</button>
        </div>
        <div class="row">
            <a class="btn w-100" href="join">회원가입</a>
        </div>
    </div>
</form>

