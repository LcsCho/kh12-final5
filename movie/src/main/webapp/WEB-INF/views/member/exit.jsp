<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style>
.pw{
font-size:20px;
}

</style>

<div class="container w-500">
	<div class="row pt-20">
		<h2>회원탈퇴</h2>
	</div>
	<div class="row pt-20">
		<h3>정말 탈퇴하시겠습니까? 탈퇴 후 정보는 자동으로 사라집니다.</h3>
	</div>
	<div class="row pt-10" >
		<form action="exit" method="post">
			<div class="row container">
				<div class="row align-center">
					<input type="password" name="memberPw" required class="form-input"
								placeholder="비밀번호를 입력해주세요">
				</div>
				<div class="row align-center">
					<c:if test="${param.error != null}">
					<h4 class="orange">비밀번호가 일치하지 않습니다</h4>
					</c:if>
				</div>
			</div>
			
			<div class="row pt-10">
				<button class="btn btn-orange" type="submit">탈퇴하기</button>
			</div>
		
		</form>
	</div>
	
</div>
