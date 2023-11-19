<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 상세페이지</title>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- Your custom styles go here -->
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
	border-radius: 5px;
}
</style>
<script>
	//영화 찜기능
	$(function() {
		var params = new URLSearchParams(location.search);
		var movieNo = params.get("movieNo");

		$.ajax({
			url : "/movieWish/check",
			method : "post",
			data : {
				movieNo : movieNo
			},
			success : function(response) {
				if (response.check) {
					$(".fa-bookmark").removeClass("fa-solid fa-regular")
							.addClass("fa-solid");
				} else {
					$(".fa-bookmark").removeClass("fa-solid fa-regular")
							.addClass("fa-regular");
				}
			}
		});

		$(".fa-bookmark").click(
				function() {
					$.ajax({
						url : "/movieWish/action",
						method : "post",
						data : {
							movieNo : movieNo
						},
						success : function(response) {
							if (response.check) {
								$(".fa-bookmark").removeClass(
										"fa-solid fa-regular").addClass(
										"fa-solid");
							} else {
								$(".fa-bookmark").removeClass(
										"fa-solid fa-regular").addClass(
										"fa-regular");
							}
						}
					});
				});
	});
</script>

<script>
//평점 기능
    $(document).ready(function () {
    	var params = new URLSearchParams(location.search);
    	var movieNo = params.get("movieNo");
        // 별 아이콘 클릭 이벤트
        $('#ratingStars i').on('click', function () {
            var rating = $(this).data('rating');
            $('#selectedRating').text('선택된 평점: ' + rating);

           // 여기에 Ajax 요청을 보내서 서버에 평점을 저장하는 로직을 추가할 수 있습니다.
            $.ajax({
                url: '/saveRating',
                method: 'POST',
                data: { 
                	rating: rating, 
                	movieNo: movieNo
                },
                success: function (response) {
                    // 성공적으로 처리된 경우 추가적인 로직을 작성할 수 있습니다.
                },
                error: function (error) {
                    console.error('Error saving rating:', error);
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
				<img src="/image/${mainImgNo}" class="img-thumbnail"
					style="width: 215px; height: 300px">
				<!-- Rating Section -->
				<c:choose>
					<c:when test="${ratingAvg != null}">
						<h4 class="mt-4">평점 평균: ${ratingAvg}</h4>
					</c:when>
					<c:otherwise>
						<h4 class="mt-4">평점 평균: 0.0</h4>
					</c:otherwise>
				</c:choose>
				<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
					class="fa-regular fa-star-half-stroke"></i><i
					class="fa-regular fa-star"></i><i class="fa-regular fa-star"></i>
			</div>
			<!-- Movie Information -->
			<div class="col-md-8">
				<h2>${movieDto.movieName}
					<i class="fa-regular fa-bookmark"></i>
				</h2>
				<p>
					<strong>영화감독: </strong> ${movieDto.movieDirector}
				</p>
				<p>
					<strong>출시년도: </strong>
					<fmt:formatDate value="${movieDto.movieReleaseDate}" pattern="yyyy" />
				</p>
				<p>
					<strong>영화 장르: </strong>
					<c:forEach var="movieGenreDto" items="${movieGenreList}"
						varStatus="loopStatus">
	                   	${movieGenreDto.genreName} 
	                   <c:if test="${not loopStatus.last}">/</c:if>
					</c:forEach>
				</p>
				<p>
					<strong>영화제작 국가: </strong> ${movieDto.movieNation}
				</p>
				<p>
					<strong>영화 상영시간: </strong> ${movieDto.movieTime} 분
				</p>
				<p>
					<strong>영화 등급: </strong> ${movieDto.movieLevel}
				</p>
				<p>
					<strong>영화 줄거리: </strong> ${movieDto.movieContent}
				</p>

			</div>
			<!-- Still Cut Section -->
			<h4 class="mt-3">영화 갤러리</h4>
			<c:if test="${movieDetailList != null}">
				<c:forEach var="movieDetailVO" items="${movieDetailList}">
					<div class="col" style="width: 215px;">
						<img src="/image/${movieDetailVO.detailImgNo}"
							class="img-thumbnail" style="width: 215px; height: 300px">
					</div>
				</c:forEach>
			</c:if>

			<!-- Cast Section -->
			<h4 class="mt-3">출연자</h4>
			<c:if test="${actorDetailList != null}">
				<c:forEach var="actorDetailVO" items="${actorDetailList}">

					<div class="col" style="width: 215px;">
						<p>${actorDetailVO.actorName}</p>
						<p>${actorDetailVO.actorRole}</p>
						<img src="/image/${actorDetailVO.actorNo}" class="img-thumbnail"
							style="width: 215px; height: 300px">
					</div>
				</c:forEach>
			</c:if>

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
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>