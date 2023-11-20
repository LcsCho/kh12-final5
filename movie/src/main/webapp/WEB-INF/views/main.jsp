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
			<!-- Swiper Container -->
			<c:choose>
				<c:when test="${not empty movieList}">
					<!-- 검색결과 -->
					<div class="row mt-5 p-3">
						<div class="col">
							<h3>${movieName}의 검색결과</h3>
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
											src="/image/${movieVO.imageNo}" class="img-thumbnail"
											style="width: 250px; height: 310px;"> <!--  										<img src="https://picsum.photos/215/300"  -->
											<!--                                         class="img-thumbnail" style="width:250px; height: 310px;"> -->
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
							<h3>검색결과가 없어요!</h3>
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
											<img src="/image/${mvcTop10RecommendVO.imageNo}"
											class="img-thumbnail" style="width: 250px; height: 310px;">
											<!--  										<img src="https://picsum.photos/215/300"  -->
											<!--                                         class="img-thumbnail" style="width:250px; height: 310px;"> -->
										</a>
										<div class="col mt-2">
											<a
												href="/movie/detail?movieNo=${mvcTop10RecommendVO.movieNo}">
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
												<img src="/image/${mvcCriticTop10RecommendVO.imageNo}"
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
												<img src="/image/${todayMovieVO.imageNo}"
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
														src="/image/${preferGenreByMemberRecommendVO.imageNo}"
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
													<img src="/image/${ageGroupRecommendVO.imageNo}"
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
													<img src="/image/${genderRecommendVO.imageNo}"
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
													<img src="/image/${ageGroupGenderRecommendVO.imageNo}"
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
									<h3>아직 찜해놓고 안보셨어요!</h3>
								</div>
							</div>
							<div class="swiper row">
								<div class="swiper-wrapper">
									<c:forEach var="wishMovieVO" items="${wishMovieList}">
										<div class="swiper-slide">
											<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">
												<div>
													<a href="/movie/detail?movieNo=${wishMovieVO.movieNo}">
														<img src="/image/${wishMovieVO.imageNo}"
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
														<img src="/image/${againRecommendVO.imageNo}"
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
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<script>
	var swiper = new Swiper('.swiper', {
		slidesPerView : 5,
		slidesPerGroup : 5,
		//         spaceBetween: 5,
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
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>