<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%-- <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/template/header.jsp"></jsp:include>
 --%>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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

