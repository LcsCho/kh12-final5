<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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

	.message-list{
   		height:65vh;
   		overflow-y: scroll;
    	padding-bottom: 5px; 
   	}
   	::-webkit-scrollbar{
   		width: 3px; /* 스크롤바 너비 */
   		background-color:black;
   	}
   	::-webkit-scrollbar-thumb {
   		background: var(--bs-secondary); /* 스크롤바 색상 */
   	}
	
	 .message-list .message {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 8px;
        margin: 8px 0;
    }

    /* 오른쪽 정렬 스타일 */
	.message.my-message {
	    text-align: right;
	}
	
	/* 왼쪽 정렬 스타일 */
	.message.other-message {
	    text-align: left;
	}
	.swiper-container {
            width: 100%;
            padding-top: 50px; /* 이전 버튼과 다음 버튼이 겹치지 않도록 상단 패딩 추가 */
        }

        .swiper-button-next,
        .swiper-button-prev {
            top: 50%; /* 버튼을 세로 중앙에 배치 */
            transform: translateY(-50%); /* 세로 중앙에 정렬하기 위한 변형 */
        }

        .swiper-button-next {
            right: 0; /* 다음 버튼을 오른쪽에 배치 */
        }

        .swiper-button-prev {
            left: 0; /* 이전 버튼을 왼쪽에 배치 */
        }

        .swiper-slide {
/*             width: auto !important; */
            padding: 0 5px;
        } 

        .swiper-wrapper {
/*             display: flex; */
            gap: 10px;
            justify-content: flex-start; /* 왼쪽 정렬 */
            margin-left: -10px; /* 첫 번째 슬라이드와 왼쪽 여백 조절 */
        }

        .swiper-slide img {
            width: 100%;
            height: auto;
        }
	
</style>

<!-- swiper cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<div class="container-fluid">
	<!-- 전체 페이지 폭 관리 -->
	<div class="row">
		<div class="col-md-10 offset-md-1">
<!-- 			<button type="button" class="btn btn-primary open-modal-btn">채팅방 열기</button> -->
			<!-- Swiper Container -->
			<c:choose>
				<c:when test="${not empty movieList}">
					<!-- 검색결과 -->
					<div class="row mt-5 p-3">
						<div class="col">
							<h3>${movieName}의검색결과</h3>
						</div>
					</div>
					<div class="swiper row">
						<!-- Additional required wrapper -->
						<div class="swiper-wrapper">
							<!-- Slides -->
							<c:forEach var="movieVO" items="${movieList}">
								<div class="swiper-slide">
									<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
										<a href="/movie/detail?movieNo=${movieVO.movieNo}"> <img
											src="/rest/image/${movieVO.imageNo}" class="img-thumbnail"
											style="width: 250px; height: 310px;">
											 <!--<img src="https://picsum.photos/215/300"  -->
											<!--class="img-thumbnail" style="width:250px; height: 310px;"> -->
										</a>
										<div class="col mt-2">
											<a href="/movie/detail?movieNo=${movieVO.movieNo}">
												${movieVO.movieName} </a>
										</div>
										<div class="col">
											<fmt:formatDate value="${movieVO.movieReleaseDate}"
												pattern="yyyy" />
											/ ${movieVO.movieNation}
										</div>
										<c:if test="${movieVO.ratingAvg != 0}">
											<div class="col">
												평균 <i class="fa-solid fa-star"></i> ${movieVO.ratingAvg}점
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- Add Pagination -->
						<!--                 <div class="swiper-pagination"></div> -->
						<!-- Add Navigation -->
						<div class="swiper-button-next custom-next"></div>
						<div class="swiper-button-prev custom-prev"></div>
					</div>
				</c:when>
				<c:when test="${empty movieList && movieList != null}">
					<div class="row mt-5 p-3">
						<div class="col">
							<h3>${movieName}의 검색결과가 없어요!</h3>
							<a href="/">메인으로</a>
						</div>
					</div>
				</c:when>

				<c:otherwise>
					<!-- MVC Top 10 -->
					<div class="row mt-5 p-3">
						<div class="col">
							<h3>MVC Top 10</h3>
						</div>
					</div>
					<div class="swiper row">
						<!-- Additional required wrapper -->
						<div class="swiper-wrapper">
							<!-- Slides -->
							<c:forEach var="mvcTop10RecommendVO"
								items="${mvcTop10RecommendList}">
								<div class="swiper-slide">
									<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
										<a href="/movie/detail?movieNo=${mvcTop10RecommendVO.movieNo}">
											<img src="/rest/image/${mvcTop10RecommendVO.imageNo}"
											class="img-thumbnail" style="width: 250px; height: 310px;">
											<!--<img src="https://picsum.photos/215/300"  -->
											<!--class="img-thumbnail" style="width:250px; height: 310px;"> -->
										</a>
										<div class="col mt-2">
											<a href="/movie/detail?movieNo=${mvcTop10RecommendVO.movieNo}">
												${mvcTop10RecommendVO.movieName} </a>
										</div>
										<div class="col">
											<fmt:formatDate
												value="${mvcTop10RecommendVO.movieReleaseDate}"
												pattern="yyyy" />
											/ ${mvcTop10RecommendVO.movieNation}
										</div>
										<c:if test="${mvcTop10RecommendVO.ratingAvg != 0}">
											<div class="col">
												평균 <i class="fa-solid fa-star"></i>
												${mvcTop10RecommendVO.ratingAvg}점
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- Add Pagination -->
						<!--                 <div class="swiper-pagination"></div> -->
						<!-- Add Navigation -->
						<div class="swiper-button-next custom-next"></div>
						<div class="swiper-button-prev custom-prev"></div>
					</div>


					<!-- MVC 평론가 Top 10 -->
					<div class="row mt-5 p-3">
						<div class="col">
							<h3>MVC 평론가 Top 10</h3>
						</div>
					</div>
					<div class="swiper row">
						<div class="swiper-wrapper">
							<c:forEach var="mvcCriticTop10RecommendVO"
								items="${mvcCriticTop10RecommendList}">
								<div class="swiper-slide">
									<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
										<div>
											<a
												href="/movie/detail?movieNo=${mvcCriticTop10RecommendVO.movieNo}">
												<img src="/rest/image/${mvcCriticTop10RecommendVO.imageNo}"
												class="img-thumbnail" style="width: 250px; height: 310px">
											</a>
										</div>
										<div class="col">
											<a
												href="/movie/detail?movieNo=${mvcCriticTop10RecommendVO.movieNo}">
												${mvcCriticTop10RecommendVO.movieName} </a>
										</div>
										<div class="col">
											<fmt:formatDate
												value="${mvcCriticTop10RecommendVO.movieReleaseDate}"
												pattern="yyyy" />
											/ ${mvcCriticTop10RecommendVO.movieNation}
										</div>
										<c:if test="${mvcCriticTop10RecommendVO.ratingAvg != 0}">
											<div class="col">
												평균 <i class="fa-solid fa-star"></i>
												${mvcCriticTop10RecommendVO.ratingAvg}점
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="swiper-button-next custom-next"></div>
						<div class="swiper-button-prev custom-prev"></div>
					</div>

					<!-- 오늘의 영화 추천 Top 10 -->
					<div class="row mt-5 p-3">
						<div class="col">
							<h3>오늘의 추천!</h3>
						</div>
					</div>
					<div class="swiper row">
						<div class="swiper-wrapper">
							<c:forEach var="todayMovieVO" items="${todayMovieList}">
								<div class="swiper-slide">
									<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
										<div>
											<a href="/movie/detail?movieNo=${todayMovieVO.movieNo}">
												<img src="/rest/image/${todayMovieVO.imageNo}"
												class="img-thumbnail" style="width: 250px; height: 310px">
											</a>
										</div>
										<div class="col">
											<a href="/movie/detail?movieNo=${todayMovieVO.movieNo}">
												${todayMovieVO.movieName} </a>
										</div>
										<div class="col">
											<fmt:formatDate value="${todayMovieVO.movieReleaseDate}"
												pattern="yyyy" />
											/ ${todayMovieVO.movieNation}
										</div>
										<c:if test="${todayMovieVO.ratingAvg != 0}">
											<div class="col">
												평균 <i class="fa-solid fa-star"></i>
												${todayMovieVO.ratingAvg}점
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="swiper-button-next custom-next"></div>
						<div class="swiper-button-prev custom-prev"></div>
					</div>
					
					
					<div class="row mt-5 pt-5" style="min-height: 400px;">
                    <div class="col">
					
					<!-- 계절별 영화 추천 -->
					<div class="row mt-5 p-3">
						<div class="col">
							<c:choose>
								<c:when test="${currentMonth >= 3 && currentMonth <= 5}">
									<h3>따스한 봄, 마음이 따뜻해지는 영화를 추천드려요!</h3>
								</c:when>
								<c:when test="${currentMonth >= 6 && currentMonth <= 8}">
									<h3>뜨거운의 여름의 열기를 식혀줄 시원한 영화들, 시원한 영화를 추천드려요!</h3>
								</c:when>
								<c:when test="${currentMonth >= 9 && currentMonth <= 11}">
									<h3>가을 감성을 자극할 영화를 추천드려요!</h3>
								</c:when>
								<c:otherwise>
									<h3>추운 겨울, 우리의 마음을 녹여줄 영화를 추천드려요!</h3>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="swiper row">
						<div class="swiper-wrapper">
							<c:forEach var="seasonMovieVO" items="${seasonMovieList}">
								<div class="swiper-slide" style="min-width: 250px;">
									<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
										<div class="row">
											<div class="col">
											<a href="/movie/detail?movieNo=${seasonMovieVO.movieNo}">
												<img src="/rest/image/${seasonMovieVO.imageNo}"
												class="img-thumbnail" style="width: 250px; height: 310px">
											</a>
											</div>
										</div>
										<div class="row">
										<div class="col">
											<a href="/movie/detail?movieNo=${seasonMovieVO.movieNo}">
												${seasonMovieVO.movieName} </a>
										</div>
										</div>
										<div class="row">
										<div class="col">
											<fmt:formatDate value="${seasonMovieVO.movieReleaseDate}"
												pattern="yyyy" />
											/ ${seasonMovieVO.movieNation}
										</div>
										</div>
										<c:if test="${seasonMovieVO.ratingAvg != 0}">
										<div class="row">
											<div class="col">
												평균 <i class="fa-solid fa-star"></i>
												${seasonMovieVO.ratingAvg}점
											</div>
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="swiper-button-next custom-next"></div>
						<div class="swiper-button-prev custom-prev"></div>
					</div>
					
					</div>
                </div>

					<!-- 회원으로 로그인 할 경우만 출력 -->
					<c:if test="${sessionScope.name != null}">

						<!-- 회원별 선호장르 영화 추천 -->
						<c:if
							test="${preferGenreByMemberRecommendList != null and not empty preferGenreByMemberRecommendList}">
							<div class="row mt-5 p-3">
								<div class="col">
									<h3>선호 장르에 대한 영화를 추천해드려요!</h3>
								</div>
							</div>
							<div class="swiper row">
								<div class="swiper-wrapper">
									<c:forEach var="preferGenreByMemberRecommendVO"
										items="${preferGenreByMemberRecommendList}">
										<div class="swiper-slide">
											<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
												<div>
													<a
														href="/movie/detail?movieNo=${preferGenreByMemberRecommendVO.movieNo}">
														<img
														src="/rest/image/${preferGenreByMemberRecommendVO.imageNo}"
														class="img-thumbnail" style="width: 250px; height: 310px">
													</a>
												</div>
												<div class="col">
													<a
														href="/movie/detail?movieNo=${preferGenreByMemberRecommendVO.movieNo}">
														${preferGenreByMemberRecommendVO.movieName} </a>
												</div>
												<div class="col">
													<fmt:formatDate
														value="${preferGenreByMemberRecommendVO.movieReleaseDate}"
														pattern="yyyy" />
													/ ${preferGenreByMemberRecommendVO.movieNation}
												</div>
												<c:if
													test="${preferGenreByMemberRecommendVO.ratingAvg != 0}">
													<div class="col">
														평균 <i class="fa-solid fa-star"></i>
														${preferGenreByMemberRecommendVO.ratingAvg}점
													</div>
												</c:if>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next custom-next"></div>
								<div class="swiper-button-prev custom-prev"></div>
							</div>
						</c:if>

						<!-- 연령별 영화 추천 -->
						<div class="row mt-5 p-3">
							<div class="col">
								<c:choose>
									<c:when test="${ageGroup < 10}">
										<h3>10세 미만의 영화를 추천드려요!</h3>
									</c:when>
									<c:when test="${ageGroup >= 60}">
										<h3>60대 이상의 영화를 추천드려요!</h3>
									</c:when>
									<c:otherwise>
										<h3>${ageGroup}대영화를추천드려요!</h3>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="swiper row">
							<div class="swiper-wrapper">
								<c:forEach var="ageGroupRecommendVO"
									items="${ageGroupRecommendList}">
									<div class="swiper-slide">
										<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
											<div>
												<a
													href="/movie/detail?movieNo=${ageGroupRecommendVO.movieNo}">
													<img src="/rest/image/${ageGroupRecommendVO.imageNo}"
													class="img-thumbnail" style="width: 250px; height: 310px">
												</a>
											</div>
											<div class="col">
												<a
													href="/movie/detail?movieNo=${ageGroupRecommendVO.movieNo}">
													${ageGroupRecommendVO.movieName} </a>
											</div>
											<div class="col">
												<fmt:formatDate
													value="${ageGroupRecommendVO.movieReleaseDate}"
													pattern="yyyy" />
												/ ${ageGroupRecommendVO.movieNation}
											</div>
											<c:if test="${ageGroupRecommendVO.ratingAvg != 0}">
												<div class="col">
													평균 <i class="fa-solid fa-star"></i>
													${ageGroupRecommendVO.ratingAvg}점
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
							<div class="swiper-button-next custom-next"></div>
							<div class="swiper-button-prev custom-prev"></div>
						</div>


						<!-- 성별별 영화 추천 -->
						<div class="row mt-5 p-3">
							<div class="col">
								<c:choose>
									<c:when test="${memberGender == '남자'}">
										<h3>Movie For Man!</h3>
									</c:when>
									<c:otherwise>
										<h3>Movie For Woman!</h3>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="swiper row">
							<div class="swiper-wrapper">
								<c:forEach var="genderRecommendVO"
									items="${genderRecommendList}">
									<div class="swiper-slide">
										<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
											<div>
												<a href="/movie/detail?movieNo=${genderRecommendVO.movieNo}">
													<img src="/rest/image/${genderRecommendVO.imageNo}"
													class="img-thumbnail" style="width: 250px; height: 310px">
												</a>
											</div>
											<div class="col">
												<a href="/movie/detail?movieNo=${genderRecommendVO.movieNo}">
													${genderRecommendVO.movieName} </a>
											</div>
											<div class="col">
												<fmt:formatDate
													value="${genderRecommendVO.movieReleaseDate}"
													pattern="yyyy" />
												/ ${genderRecommendVO.movieNation}
											</div>
											<c:if test="${genderRecommendVO.ratingAvg != 0}">
												<div class="col">
													평균 <i class="fa-solid fa-star"></i>
													${genderRecommendVO.ratingAvg}점
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
							<div class="swiper-button-next custom-next"></div>
							<div class="swiper-button-prev custom-prev"></div>
						</div>

						<!-- 성별 + 나이별 영화 추천 -->
						<div class="row mt-5 p-3">
							<div class="col">
								<c:choose>
									<c:when test="${ageGroup < 10}">
										<c:choose>
											<c:when test="${memberGender == '남자'}">
												<h3>10살 미만의 남성을 위한 영화를 추천드려요!</h3>
											</c:when>
											<c:otherwise>
												<h3>10살 미만의 여성을 위한 영화를 추천드려요!</h3>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${ageGroup >= 60}">
										<c:choose>
											<c:when test="${memberGender == '남자'}">
												<h3>60대 이상의 남성을 위한 영화를 추천드려요!</h3>
											</c:when>
											<c:otherwise>
												<h3>60대 이상의 여성을 위한 영화를 추천드려요!</h3>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${memberGender == '남자'}">
												<h3>${ageGroup}대남성을위한영화를추천드려요!</h3>
											</c:when>
											<c:otherwise>
												<h3>${ageGroup}대여성을위한영화를추천드려요!</h3>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="swiper row">
							<div class="swiper-wrapper">
								<c:forEach var="ageGroupGenderRecommendVO"
									items="${ageGroupGenderRecommendList}">
									<div class="swiper-slide">
										<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
											<div>
												<a
													href="/movie/detail?movieNo=${ageGroupGenderRecommendVO.movieNo}">
													<img src="/rest/image/${ageGroupGenderRecommendVO.imageNo}"
													class="img-thumbnail" style="width: 250px; height: 310px">
												</a>
											</div>
											<div class="col">
												<a
													href="/movie/detail?movieNo=${ageGroupGenderRecommendVO.movieNo}">
													${ageGroupGenderRecommendVO.movieName} </a>
											</div>
											<div class="col">
												<fmt:formatDate
													value="${ageGroupGenderRecommendVO.movieReleaseDate}"
													pattern="yyyy" />
												/ ${ageGroupGenderRecommendVO.movieNation}
											</div>
											<c:if test="${ageGroupGenderRecommendVO.ratingAvg != 0}">
												<div class="col">
													평균 <i class="fa-solid fa-star"></i>
													${ageGroupGenderRecommendVO.ratingAvg}점
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
							<div class="swiper-button-next custom-next"></div>
							<div class="swiper-button-prev custom-prev"></div>
						</div>

						<!-- 찜목록 영화 추천 -->
						<c:if test="${wishMovieList != null and not empty wishMovieList}">
							<div class="row mt-5 p-3">
								<div class="col">
									<h3>찜목록은 어때요?</h3>
								</div>
							</div>
							<div class="swiper row">
								<div class="swiper-wrapper">
									<c:forEach var="wishMovieVO" items="${wishMovieList}">
										<div class="swiper-slide">
											<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
												<div>
													<a href="/movie/detail?movieNo=${wishMovieVO.movieNo}">
														<img src="/rest/image/${wishMovieVO.imageNo}"
														class="img-thumbnail" style="width: 215px; height: 300px">
													</a>
												</div>
												<div class="col">
													<a href="/movie/detail?movieNo=${wishMovieVO.movieNo}">
														${wishMovieVO.movieName} </a>
												</div>
												<div class="col">
													<fmt:formatDate value="${wishMovieVO.movieReleaseDate}"
														pattern="yyyy" />
													/ ${wishMovieVO.movieNation}
												</div>
												<c:if test="${wishMovieVO.ratingAvg != 0}">
													<div class="col">
														평균 <i class="fa-solid fa-star"></i>
														${wishMovieVO.ratingAvg}점
													</div>
												</c:if>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next custom-next"></div>
								<div class="swiper-button-prev custom-prev"></div>
							</div>
						</c:if>

						<!-- 다시보기 추천 -->
						<c:if
							test="${againRecommendList != null and not empty againRecommendList}">
							<div class="row mt-5 p-3">
								<div class="col">
									<h3>봤던 영화 다시 보는건 어떠세요!</h3>
								</div>
							</div>
							<div class="swiper row">
								<div class="swiper-wrapper">
									<c:forEach var="againRecommendVO" items="${againRecommendList}">
										<div class="swiper-slide">
											<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
												<div>
													<a href="/movie/detail?movieNo=${againRecommendVO.movieNo}">
														<img src="/rest/image/${againRecommendVO.imageNo}"
														class="img-thumbnail" style="width: 250px; height: 310px">
													</a>
												</div>
												<div class="col">
													<a href="/movie/detail?movieNo=${againRecommendVO.movieNo}">
														${againRecommendVO.movieName} </a>
												</div>
												<div class="col">
													<fmt:formatDate
														value="${againRecommendVO.movieReleaseDate}"
														pattern="yyyy" />
													/ ${againRecommendVO.movieNation}
												</div>
												<c:if test="${againRecommendVO.ratingAvg != 0}">
													<div class="col">
														평균 <i class="fa-solid fa-star"></i>
														${againRecommendVO.ratingAvg}점
													</div>
												</c:if>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next custom-next"></div>
								<div class="swiper-button-prev custom-prev"></div>
							</div>
						</c:if>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<!-- 채팅 -->
<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel"
                            aria-hidden="true">
  <div class="modal-dialog">
      <div class="modal-content" style="background-color: #B33939;">
            <div class="modal-header p-2 ms-1">
                <h5 class="modal-title" id="chatModalLabel">실시간 채팅 
                <i class="fa-regular fa-comments"></i></h5>
                <button type="button" class="btn-close me-1" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row p-2">
                    <div class="col p-2" style="background-color :#eccccc; border-radius:10px;">
                        <div class="message-list"></div>
                    </div>
                </div>
	
				<c:if test="${sessionScope.name != null}">
                <div class="row">
                    <div class="col">
                        <div class="input-group">
                            <input type="text" class="form-control message-input"
                                placeholder="메세지 내용 작성">
                            <button type="button" class="btn btn-primary send-btn input-group-append">
                                <i class="fa-regular fa-paper-plane"></i>
                                보내기
                            </button>
                        </div>
                    </div>
                </div>
				</c:if>
				
            </div>
        </div>
    </div>
</div>

<script>
	//스와이퍼 설정
	var swiper = new Swiper('.swiper', {
		slidesPerView : 5,
		slidesPerGroup : 5,
		spaceBetween: 5,
		loop : true,
		navigation : {
			nextEl : '.custom-next', // 커스텀 클래스 지정
			prevEl : '.custom-prev', // 커스텀 클래스 지정
		},
		pagination : {
			el : '.swiper-pagination',
			clickable : true,
		},
		speed : 700,
	});
	
// 	$(function () {
//         $(".open-modal-btn").click(function () {

//             var modal = new bootstrap.Modal(document.querySelector("#chatModal"));
//             modal.show();
//         });
//     });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- 채팅 -->
<script>
	//연결생성
	window.socket = new SockJS("${pageContext.request.contextPath}/ws/sockjs");
	window.socket.onmessage = function(e){
		var data = JSON.parse(e.data);
		
		//사용자가 접속하거나 종료했을 때 서버에서 오는 데이터로 목록을 갱신
		//사용자가 메세지르 보냈을 때 서버에서 이를 전체에게 전달한다
		if (data.content) {
		    var memberId = $("<strong>").text(data.memberId);
		    var content = $("<div>").text(data.content);
		
		    // 화면에 메시지 추가
		    var messageDiv = $("<div>").addClass("border border-secondary rounded p-2 mt-2 message");
		    
		    if (data.memberId === '${sessionScope.name}') {
		        messageDiv.addClass("my-message"); // 로그인 사용자의 메시지
		    } else {
		        messageDiv.addClass("other-message"); // 다른 사용자의 메시지
		    }
		
		    messageDiv.append(content).appendTo(".message-list");

		    // 스크롤바를 맨 아래로 이동
		    $(".message-list").scrollTop($(".message-list")[0].scrollHeight);
}
		
	//메세지를 전송하는 코드
	$(".send-btn").click(function(){
		
		var text = $(".message-input").val();
		if(text.length == 0) return;
			var obj = {
					content:text
			}
			var str = JSON.stringify(obj); //객체를 JSON 문지열로 변환
			window.socket.send(str); //JSON 형식으로 보낼 때
			$(".message-input").val("");
	});
};
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>