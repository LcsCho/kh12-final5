<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-fluid">
        <!-- 전체 페이지 폭 관리 -->
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <hr>
                <!-- 제목 -->
                <div class="row mt-5">
                    <div class="col">
                        <h3>평점순</h3>
                    </div>	
                </div>


                <!-- 이미지 -->
                <div class="row">
                    	<c:forEach var="movieListVO" items="${movieList}">
                    <div class="col-sm-6 col-md-4 col-lg-3 p-3">
                    	<div>
                    		<a href="/movie/detail?movieNo=${movieListVO.movieNo}">
                        		<img src="/image/${movieListVO.imageNo}" class="img-thumbnail"  style="width: 215px; height: 300px">
                        	</a>
                        </div>
                        <div class="col" style="width: 215px;">
	                        <a href="/movie/detail?movieNo=${movieListVO.movieNo}">
	                        	${movieListVO.movieName}
                        	</a>
                        </div>
                        <div class="col" style="width: 215px;">
                        	<fmt:formatDate value="${movieListVO.movieReleaseDate}" pattern="yyyy" /> / ${movieListVO.movieNation}
                        </div>
                        <c:if test="${movieListVO.ratingAvg != 0}">
	                        <div class="col" style="width: 215px;">
	                        	평균 <i class="fa-solid fa-star"></i> ${movieListVO.ratingAvg}점 
	                        </div>
                        </c:if>
                    </div>
                        </c:forEach>
                </div>

            </div>
        </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
