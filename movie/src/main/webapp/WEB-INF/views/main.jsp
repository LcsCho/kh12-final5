<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid">
	<!-- 전체 페이지 폭 관리 -->
	<div class="row">
		<div class="col-md-10 offset-md-1">
			<hr>
			<!-- 제목 -->
			<!--                 <div class="row mt-5"> -->
			<!--                     <div class="col"> -->
			<!--                         <h3>평점순</h3> -->
			<!--                     </div>	 -->
			<!--                 </div> -->


			<!--                 이미지 -->
			<!--                 <div class="row"> -->
			<%--                     	<c:forEach var="movieListVO" items="${movieList}"> --%>
			<!--                     <div class="col-sm-6 col-md-4 col-lg-3 p-3"> -->
			<!--                     	<div> -->
			<%--                     		<a href="/movie/detail?movieNo=${movieListVO.movieNo}"> --%>
			<%--                         		<img src="/image/${movieListVO.imageNo}" class="img-thumbnail"  style="width: 215px; height: 300px"> --%>
			<!--                         	</a> -->
			<!--                         </div> -->
			<!--                         <div class="col" style="width: 215px;"> -->
			<%-- 	                        <a href="/movie/detail?movieNo=${movieListVO.movieNo}"> --%>
			<%-- 	                        	${movieListVO.movieName} --%>
			<!--                         	</a> -->
			<!--                         </div> -->
			<!--                         <div class="col" style="width: 215px;"> -->
			<%--                         	<fmt:formatDate value="${movieListVO.movieReleaseDate}" pattern="yyyy" /> / ${movieListVO.movieNation} --%>
			<!--                         </div> -->
			<%--                         <c:if test="${movieListVO.ratingAvg != 0}"> --%>
			<!-- 	                        <div class="col" style="width: 215px;"> -->
			<%-- 	                        	평균 <i class="fa-solid fa-star"></i> ${movieListVO.ratingAvg}점  --%>
			<!-- 	                        </div> -->
			<%--                         </c:if> --%>
			<!--                     </div> -->
			<%--                         </c:forEach> --%>
			<!--                 </div> -->

			<!-- MVC Top 10 -->
			<div class="row mt-5">
				<div class="col">
					<h3>MVC Top 10</h3>
				</div>
			</div>
			<div class="row">
				<c:forEach var="mvcTop10RecommendVO"
					items="${mvcTop10RecommendList}">
					<div class="col-sm-6 col-md-4 col-lg-3 p-3">
						<div>
							<a href="/movie/detail?movieNo=${mvcTop10RecommendVO.movieNo}">
								<img src="/image/${mvcTop10RecommendVO.imageNo}"
								class="img-thumbnail" style="width: 215px; height: 300px">
							</a>
						</div>
						<div class="col" style="width: 215px;">
							<a href="/movie/detail?movieNo=${mvcTop10RecommendVO.movieNo}">
								${mvcTop10RecommendVO.movieName} </a>
						</div>
						<div class="col" style="width: 215px;">
							<fmt:formatDate value="${mvcTop10RecommendVO.movieReleaseDate}"
								pattern="yyyy" />
							/ ${mvcTop10RecommendVO.movieNation}
						</div>
						<c:if test="${mvcTop10RecommendVO.ratingAvg != 0}">
							<div class="col" style="width: 215px;">
								평균 <i class="fa-solid fa-star"></i>
								${mvcTop10RecommendVO.ratingAvg}점
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>

			<!-- MVC 평론가 Top 10 -->
			<div class="row mt-5">
				<div class="col">
					<h3>MVC 평론가 Top 10</h3>
				</div>
			</div>
			<div class="row">
				<c:forEach var="mvcCriticTop10RecommendVO"
					items="${mvcCriticTop10RecommendList}">
					<div class="col-sm-6 col-md-4 col-lg-3 p-3">
						<div>
							<a
								href="/movie/detail?movieNo=${mvcCriticTop10RecommendVO.movieNo}">
								<img src="/image/${mvcCriticTop10RecommendVO.imageNo}"
								class="img-thumbnail" style="width: 215px; height: 300px">
							</a>
						</div>
						<div class="col" style="width: 215px;">
							<a
								href="/movie/detail?movieNo=${mvcCriticTop10RecommendVO.movieNo}">
								${mvcCriticTop10RecommendVO.movieName} </a>
						</div>
						<div class="col" style="width: 215px;">
							<fmt:formatDate
								value="${mvcCriticTop10RecommendVO.movieReleaseDate}"
								pattern="yyyy" />
							/ ${mvcCriticTop10RecommendVO.movieNation}
						</div>
						<c:if test="${mvcCriticTop10RecommendVO.ratingAvg != 0}">
							<div class="col" style="width: 215px;">
								평균 <i class="fa-solid fa-star"></i>
								${mvcCriticTop10RecommendVO.ratingAvg}점
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>

			<!-- 회원으로 로그인 할 경우만 출력 -->
			<c:if test="${sessionScope.name != null}">

				<!-- 회원별 선호장르 영화 추천 -->
				<c:if
					test="${preferGenreByMemberRecommendList != null and not empty preferGenreByMemberRecommendList}">
					<div class="row mt-5">
						<div class="col">
							<h3>선호 장르에 대한 영화를 추천해드려요!</h3>
						</div>
					</div>
					<div class="row">
						<c:forEach var="preferGenreByMemberRecommendVO"
							items="${preferGenreByMemberRecommendList}">
							<div class="col-sm-6 col-md-4 col-lg-3 p-3">
								<div>
									<a
										href="/movie/detail?movieNo=${preferGenreByMemberRecommendVO.movieNo}">
										<img src="/image/${preferGenreByMemberRecommendVO.imageNo}"
										class="img-thumbnail" style="width: 215px; height: 300px">
									</a>
								</div>
								<div class="col" style="width: 215px;">
									<a
										href="/movie/detail?movieNo=${preferGenreByMemberRecommendVO.movieNo}">
										${preferGenreByMemberRecommendVO.movieName} </a>
								</div>
								<div class="col" style="width: 215px;">
									<fmt:formatDate
										value="${preferGenreByMemberRecommendVO.movieReleaseDate}"
										pattern="yyyy" />
									/ ${preferGenreByMemberRecommendVO.movieNation}
								</div>
								<c:if test="${preferGenreByMemberRecommendVO.ratingAvg != 0}">
									<div class="col" style="width: 215px;">
										평균 <i class="fa-solid fa-star"></i>
										${preferGenreByMemberRecommendVO.ratingAvg}점
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</c:if>

				<!-- 연령별 영화 추천 -->
				<div class="row mt-5">
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
				<div class="row">
					<c:forEach var="ageGroupRecommendVO"
						items="${ageGroupRecommendList}">
						<div class="col-sm-6 col-md-4 col-lg-3 p-3">
							<div>
								<a href="/movie/detail?movieNo=${ageGroupRecommendVO.movieNo}">
									<img src="/image/${ageGroupRecommendVO.imageNo}"
									class="img-thumbnail" style="width: 215px; height: 300px">
								</a>
							</div>
							<div class="col" style="width: 215px;">
								<a href="/movie/detail?movieNo=${ageGroupRecommendVO.movieNo}">
									${ageGroupRecommendVO.movieName} </a>
							</div>
							<div class="col" style="width: 215px;">
								<fmt:formatDate value="${ageGroupRecommendVO.movieReleaseDate}"
									pattern="yyyy" />
								/ ${ageGroupRecommendVO.movieNation}
							</div>
							<c:if test="${ageGroupRecommendVO.ratingAvg != 0}">
								<div class="col" style="width: 215px;">
									평균 <i class="fa-solid fa-star"></i>
									${ageGroupRecommendVO.ratingAvg}점
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>


				<!-- 성별별 영화 추천 -->
				<div class="row mt-5">
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
				<div class="row">
					<c:forEach var="genderRecommendVO" items="${genderRecommendList}">
						<div class="col-sm-6 col-md-4 col-lg-3 p-3">
							<div>
								<a href="/movie/detail?movieNo=${genderRecommendVO.movieNo}">
									<img src="/image/${genderRecommendVO.imageNo}"
									class="img-thumbnail" style="width: 215px; height: 300px">
								</a>
							</div>
							<div class="col" style="width: 215px;">
								<a href="/movie/detail?movieNo=${genderRecommendVO.movieNo}">
									${genderRecommendVO.movieName} </a>
							</div>
							<div class="col" style="width: 215px;">
								<fmt:formatDate value="${genderRecommendVO.movieReleaseDate}"
									pattern="yyyy" />
								/ ${genderRecommendVO.movieNation}
							</div>
							<c:if test="${genderRecommendVO.ratingAvg != 0}">
								<div class="col" style="width: 215px;">
									평균 <i class="fa-solid fa-star"></i>
									${genderRecommendVO.ratingAvg}점
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>

				<!-- 성별 + 나이별 영화 추천 -->
				<div class="row mt-5">
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
										<h3>${ageGroup}대남성을위한영화를 추천드려요!</h3>
									</c:when>
									<c:otherwise>
										<h3>${ageGroup}대여성을위한영화를 추천드려요!</h3>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="row">
					<c:forEach var="ageGroupGenderRecommendVO"
						items="${ageGroupGenderRecommendList}">
						<div class="col-sm-6 col-md-4 col-lg-3 p-3">
							<div>
								<a
									href="/movie/detail?movieNo=${ageGroupGenderRecommendVO.movieNo}">
									<img src="/image/${ageGroupGenderRecommendVO.imageNo}"
									class="img-thumbnail" style="width: 215px; height: 300px">
								</a>
							</div>
							<div class="col" style="width: 215px;">
								<a
									href="/movie/detail?movieNo=${ageGroupGenderRecommendVO.movieNo}">
									${ageGroupGenderRecommendVO.movieName} </a>
							</div>
							<div class="col" style="width: 215px;">
								<fmt:formatDate
									value="${ageGroupGenderRecommendVO.movieReleaseDate}"
									pattern="yyyy" />
								/ ${ageGroupGenderRecommendVO.movieNation}
							</div>
							<c:if test="${ageGroupGenderRecommendVO.ratingAvg != 0}">
								<div class="col" style="width: 215px;">
									평균 <i class="fa-solid fa-star"></i>
									${ageGroupGenderRecommendVO.ratingAvg}점
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>

				<!-- 찜목록 영화 추천 -->
				<c:if test="${wishMovieList != null and not empty wishMovieList}">
					<div class="row mt-5">
						<div class="col">
							<h3>아직 찜해놓고 안보셨어요!</h3>
						</div>
					</div>
					<div class="row">
						<c:forEach var="wishMovieVO" items="${wishMovieList}">
							<div class="col-sm-6 col-md-4 col-lg-3 p-3">
								<div>
									<a href="/movie/detail?movieNo=${wishMovieVO.movieNo}"> <img
										src="/image/${wishMovieVO.imageNo}" class="img-thumbnail"
										style="width: 215px; height: 300px">
									</a>
								</div>
								<div class="col" style="width: 215px;">
									<a href="/movie/detail?movieNo=${wishMovieVO.movieNo}">
										${wishMovieVO.movieName} </a>
								</div>
								<div class="col" style="width: 215px;">
									<fmt:formatDate value="${wishMovieVO.movieReleaseDate}"
										pattern="yyyy" />
									/ ${wishMovieVO.movieNation}
								</div>
								<c:if test="${wishMovieVO.ratingAvg != 0}">
									<div class="col" style="width: 215px;">
										평균 <i class="fa-solid fa-star"></i> ${wishMovieVO.ratingAvg}점
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</c:if>

		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
