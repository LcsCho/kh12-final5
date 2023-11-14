<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 상세페이지</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Your custom styles go here -->
    <style>
        /* Add your custom styles here */
        body {
            padding-top: 56px;
        }
    </style>
<script>
$(function(){
	var params = new URLSearchParams(location.search);
	var movieNo = params.get("movieNo");

	$.ajax({
		url:"/movieWish/check",
		method:"post",
		data:{movieNo : movieNo},
		success:function(response) {
			if(response.check) {
				$(".fa-bookmark").removeClass("fa-solid fa-regular").addClass("fa-solid");
			}
			else{
				$(".fa-bookmark").removeClass("fa-solid fa-regular").addClass("fa-regular");
			}
		}
	});
	
	$(".fa-bookmark").click(function(){
		$.ajax({
			url:"/movieWish/action",
			method:"post",
			data: {movieNo : movieNo},
			success:function(response){
				if(response.check) {
					$(".fa-bookmark").removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{
					$(".fa-bookmark").removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
			}
		});
	});
});
</script>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">영화 상세페이지</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- Add your navigation links here -->
            </div>
        </div>
    </nav>

    <!-- Movie Details Section -->
    <div class="container mt-4">
        <div class="row">
            <!-- Movie Poster -->                                                                                                                                                                                                                                                                                                                                                                        
            <div class="col-md-4">
                <img src="https://via.placeholder.com/300" alt="Movie Poster" class="img-fluid">
            </div>
            <!-- Movie Information -->
            <div class="col-md-8">
                <h2>${movieDto.movieName} <i class="fa-regular fa-bookmark"></i></h2>
                <p><strong>출시년도:</strong> <fmt:formatDate value="${movieDto.movieReleaseDate}" pattern="yyyy" /></p>
                <p><strong>영화 장르:</strong>
                <c:forEach var="movieGenreDto" items="${list}" varStatus="loopStatus">
	                   	${movieGenreDto.genreName}
	                   <c:if test="${not loopStatus.last}">/</c:if>
	                   </c:forEach></p>
                <p><strong>영화제작 국가:</strong> ${movieDto.movieNation}</p>
                <p><strong>영화 상영시간:</strong> ${movieDto.movieTime} 분</p>
                <p><strong>영화 등급:</strong> ${movieDto.movieLevel}</p>
                <p><strong>영화 줄거리:</strong> ${movieDto.movieContent}</p>

                <!-- Review Section -->
                <h3 class="mt-4">후기</h3>

                <!-- Rating Section -->
                <h3 class="mt-4">별점</h3>

                <!-- Cast Section -->
                <h3 class="mt-4">출연자</h3>

                <!-- Still Cut Section -->
                <h3 class="mt-4">영화 스틸컷</h3>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>