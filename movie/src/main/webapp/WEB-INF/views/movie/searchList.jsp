<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    body {
        padding-top: 30px;
    }
     .review-container {
         margin-top: 20px;
     }

     .review-item {
         border: 1px solid #ccc;
         padding: 10px;
         margin-bottom: 10px;
         border-radius : 5px;
     }
</style>
<script>
$(function(){
	var params = new URLSearchParams(location.search);
	var movieNo = params.get("movieNo");

	$.ajax({
		url:"/rest/movieWish/check",
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
			url:"/rest/movieWish/action",
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

    <!-- Movie Details Section -->
    <div class="container mt-4">
        <div class="row">
            <!-- Movie Poster -->                                                                                                                                                                                                                                                                                                                                                                        
            <div class="col-md-4 text-center">
                <img src="https://via.placeholder.com/300" alt="Movie Poster" class="img-fluid">
                <!-- Rating Section -->
                <h4 class="mt-4">별점</h4>
                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star-half-stroke"></i><i class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
            </div>
            <!-- Movie Information -->
            <div class="col-md-8">
                <h2>${movieDto.movieName} <i class="fa-regular fa-bookmark"></i></h2>
                <p><strong>출시년도: </strong> <fmt:formatDate value="${movieDto.movieReleaseDate}" pattern="yyyy" /></p>
                <p><strong>영화 장르: </strong>
                <c:forEach var="movieGenreDto" items="${movieGenreList}" varStatus="loopStatus">
	                   	${movieGenreDto.genreName} 
	                   <c:if test="${not loopStatus.last}">/</c:if>
	            </c:forEach></p>
                <p><strong>영화제작 국가: </strong> ${movieDto.movieNation}</p>
                <p><strong>영화 상영시간: </strong> ${movieDto.movieTime} 분</p>
                <p><strong>영화 등급: </strong> ${movieDto.movieLevel}</p>
                <p><strong>영화 줄거리: </strong> ${movieDto.movieContent}</p>
                
            </div>
            
            <!-- Cast Section -->
             <h4 class="mt-3">출연자</h4>
                
            <!-- Still Cut Section -->
             <h4 class="mt-3">영화 스틸컷</h4>
                
            <!-- Review Section -->
          <div class="container">
          <div class="row">
          	<div class="col d-flex">
        		<h4 class="mt-3">리뷰</h4>
        		<div class="ms-auto mt-3">더보기 ></div>
          	</div>
          </div>
        <div class="row row-cols-1 row-cols-md-5 g-4 review-container">
            <c:forEach var="reviewDto" items="${reviewList}">
                <div class="col">
                    <div class="review-item">
                        <strong>${reviewDto.memberNickname}</strong>
                        <p>${reviewDto.reviewContent}</p>
                        <p>좋아요 수: ${reviewDto.reviewLikeCount}</p>
                        <p>댓글수</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
        </div>
    </div>

</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>