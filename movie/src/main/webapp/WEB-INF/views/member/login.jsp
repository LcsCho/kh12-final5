<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
       
        <div class="row right">
            <a id="passwordRecoveryButton" class="link navy">비밀번호 찾기</a>
        </div>
        <div class="row pt-20">
            <button class="btn" type="submit">로그인</button>
        </div>
        <div class="row">
            <a class="btn w-100" href="join">회원가입</a>
        </div>
        <div class="row">
            <a class="btn w-100" href="change">정보 수정</a>
        </div>
    </div>
</form>

