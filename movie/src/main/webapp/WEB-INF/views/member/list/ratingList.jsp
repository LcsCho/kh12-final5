<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
    $(document).ready(function () {
        $.ajax({
            url: '/member/ratingList', 
            method: 'GET',
            success: function (data) {
           
                var moviesContainer = $('#movies-container');
                moviesContainer.empty();

                $.each(data, function (index, ratingMovieVO) {
                	console.log(ratingMovieVO);
                    var formattedDate = new Date(ratingMovieVO.movieReleaseDate).getFullYear();

                    moviesContainer.append(`
                        <div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
                            <div>
                                <a href="/movie/detail?movieNo="+data.movieNo> 
                                    <img src="/image/${ratingMovieVO.imageNo}" class="img-thumbnail" style="width: 215px; height: 300px">
                                </a>
                            </div>
                            <div class="col">
                                <a href="/movie/detail?movieNo=${ratingMovieVO.movieNo}">
                                    ${ratingMovieVO.movieName}
                                </a>
                            </div>
                            <div class="col">
                                ${formattedDate} / ${ratingMovieVO.movieNation}
                            </div>
                            <c:if test="${ratingMovieVO.ratingAvg != 0}">
                                <div class="col">
                                    평균 <i class="fa-solid fa-star"></i> ${ratingMovieVO.ratingAvg}점
                                </div>
                            </c:if>
                        </div>
                    `);
                });
            },
            error: function (error) {
                // Handle the error
                console.error('Error fetching data:', error);
            }
        });
    });
</script>
<style>
.custom-next {
	right: 0;
	/*원하는 위치로 조정 (예: 오른쪽 끝에 배치)  */
	left: auto;
	top: 60%;
	/*예: 50% 위로 이동 */
	transform: translateY(-50%);
	/*세로 중앙 정렬을 위한 추가 설정 */
	color: #fff; /* 버튼 텍스트 색상 */
	border-radius: 5px; /* 버튼 테두리 모양 설정 */
}

.custom-prev {
	left: 0;
	/*원하는 위치로 조정 (예: 왼쪽 끝에 배치) */
	right: auto;
	top: 60%;
	/*예: 50% 위로 이동  */
	transform: translateY(-50%);
	/*세로 중앙 정렬을 위한 추가 설정  */
	/* 		 color: #fff; /* 버튼 텍스트 색상 */ */
	border-radius: 5px; /* 버튼 테두리 모양 설정 */
}

/*     .swiper-button-next:hover, */
/* 	.swiper-button-prev:hover { */
/* 	  background-color: #2980b9; /* hover 시 버튼 배경색 변경 */
/* 	  /* 다른 스타일 속성들 추가 가능 */
h3 {
	color: rgb(179, 57, 57);
}
</style>

<!-- swiper cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<div class="container-fluid">
    <!-- 전체 페이지 폭 관리 -->
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="row mt-5 p-3">
                <div class="col">
                    <h3>평가 목록</h3>
                </div>
            </div>
            <div class="row" id="movies-container">
            </div>
        </div>
    </div>
</div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>