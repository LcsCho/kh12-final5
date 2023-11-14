<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>
 --%>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 





<div class="container w-500">

	<div class="row mv-30">
	<c:choose>
	<c:when test="${profile == null}">
		<img src="${pageContext.request.contextPath}/images/user.jpg" width="150" height="150" 
		class="image image-circle image-border profile-image">
	</c:when>
	<c:otherwise>
	<img src="${pageContext.request.contextPath}/rest/member/download?imageNo=${profile}"
		width="150" height="150" 
		class="image image-circle image-border profile-image">
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
			<input type="file" class="profile-chooser" accept="image/*" 
														style="display:none;">
		<i class="fa-solid fa-camera blue fa-2x"></i>
		</label>	
		<i class="fa-solid fa-trash-can red fa-2x profile-delete"></i>
	</div>
	
	
	<div class="row mt-40">
		<a class="btn w-100" href="password">
			<i class="fa-solid fa-key"></i>
			비밀번호 변경
		</a>
	</div>
	
	<div class="row">
		<a class="btn w-100" href="change">
			<i class="fa-solid fa-user"></i>
			개인정보 수정
		</a>
	</div>
	
	<div class="row mb-40">
		<a class="btn btn-negative w-100" href="exit">
			<i class="fa-solid fa-user-xmark"></i>
			회원 탈퇴
		</a>
		<hr>
	</div> 
	</div>
</div>

<%-- <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/footer.jsp"></jsp:include>
 --%>
 <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

