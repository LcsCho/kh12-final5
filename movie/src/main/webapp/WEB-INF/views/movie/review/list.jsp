<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
</head>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function(){ 
	var params = new URLSearchParams(location.search);
    var movieNo = params.get("movieNo");
	
	$(document).ready(function () {
        // 페이지가 로드될 때 최신순 조회 함수 호출
        $(".ByDateDesc").click();
    });
	
	//최신순 조회
	$(".ByDateDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByDateDesc?movieNo=" + movieNo,
			method: "post",
			data: {
				data:{movieNo : movieNo},
			},
			success: function(response){
				$(".review-list").empty();

			   for (var i = 0; i < response.length; i++) {
			       var review = response[i];
			       var reviewItem = '<div class="review-item">' +
			           '<span class="reviewNo">' + review.reviewNo + '</span><br>' +
			           '<span class="memberNickname">' + review.memberNickname + '</span><br>' +
			           '<span class="ratingScore">' + review.ratingScore + '</span><br>' +
			           '<span class="reviewContent">' + review.reviewContent + '</span><br>' +
			           '<span class="reviewLikeCount">' + review.reviewLikeCount + '</span>' +
			           '<hr>' +
			           '</div>';

			       $(".review-list").append(reviewItem);
			   }
			}
		});
	});
	
	//오래된순 조회
	$(".ByDateAsc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByDateAsc?movieNo=" + movieNo,
			method: "post",
			data: {
				imageNo : "review.reviewNo",
				memberNickname : "review.memberNickname",
				ratingScore : "review.ratingScore",
				reviewCount : "review.reviewContent",
				reviewLikeCount : "review.reviewLikeCount",
				sortType: "ByDateAsc"
			},
			success: function(response){
				$(".review-list").empty();

			   for (var i = 0; i < response.length; i++) {
			       var review = response[i];
			       var reviewItem = '<div class="review-item">' +
			           '<span class="reviewNo">' + review.reviewNo + '</span><br>' +
			           '<span class="memberNickname">' + review.memberNickname + '</span><br>' +
			           '<span class="ratingScore">' + review.ratingScore + '</span><br>' +
			           '<span class="reviewContent">' + review.reviewContent + '</span><br>' +
			           '<span class="reviewLikeCount">' + review.reviewLikeCount + '</span>' +
			           '<hr>' +
			           '</div>';

			       $(".review-list").append(reviewItem);
			   }
			}
		});
	});
	
	//좋아요순 조회
	$(".ByLikeDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByLikeDesc?movieNo=" + movieNo,
			method: "post",
			data: {
				imageNo : "review.reviewNo",
				memberNickname : "review.memberNickname",
				ratingScore : "review.ratingScore",
				reviewCount : "review.reviewContent",
				reviewLikeCount : "review.reviewLikeCount",
				sortType: "ByLikeDesc"
			},
			success: function(response){
				$(".review-list").empty();

			   for (var i = 0; i < response.length; i++) {
			       var review = response[i];
			       var reviewItem = '<div class="review-item">' +
			           '<span class="reviewNo">' + review.reviewNo + '</span><br>' +
			           '<span class="memberNickname">' + review.memberNickname + '</span><br>' +
			           '<span class="ratingScore">' + review.ratingScore + '</span><br>' +
			           '<span class="reviewContent">' + review.reviewContent + '</span><br>' +
			           '<span class="reviewLikeCount">' + review.reviewLikeCount + '</span>' +
			           '<hr>' +
			           '</div>';

			       $(".review-list").append(reviewItem);
			   }
			}
		});
	});
	
	//평점높은순 조회
	$(".ByRatingDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByRatingDesc?movieNo=" + movieNo,
			method: "post",
			data: {
				imageNo : "review.reviewNo",
				memberNickname : "review.memberNickname",
				ratingScore : "review.ratingScore",
				reviewCount : "review.reviewContent",
				reviewLikeCount : "review.reviewLikeCount",
				sortType: "ByRatingDesc"
			},
			success: function(response){
				$(".review-list").empty();

			   for (var i = 0; i < response.length; i++) {
			       var review = response[i];
			       var reviewItem = '<div class="review-item">' +
			           '<span class="reviewNo">' + review.reviewNo + '</span><br>' +
			           '<span class="memberNickname">' + review.memberNickname + '</span><br>' +
			           '<span class="ratingScore">' + review.ratingScore + '</span><br>' +
			           '<span class="reviewContent">' + review.reviewContent + '</span><br>' +
			           '<span class="reviewLikeCount">' + review.reviewLikeCount + '</span>' +
			           '<hr>' +
			           '</div>';

			       $(".review-list").append(reviewItem);
			   }
			}
		});
	});
	
	//평점낮은순 조회
	$(".ByRatingAsc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByRatingAsc?movieNo=" + movieNo,
			method: "post",
			data: {
				imageNo : "review.reviewNo",
				memberNickname : "review.memberNickname",
				ratingScore : "review.ratingScore",
				reviewCount : "review.reviewContent",
				reviewLikeCount : "review.reviewLikeCount",
				sortType: "ByRatingAsc"
			},
			success: function(response){
				$(".review-list").empty();

			   for (var i = 0; i < response.length; i++) {
			       var review = response[i];
			       var reviewItem = '<div class="review-item">' +
			           '<span class="reviewNo">' + review.reviewNo + '</span><br>' +
			           '<span class="memberNickname">' + review.memberNickname + '</span><br>' +
			           '<span class="ratingScore">' + review.ratingScore + '</span><br>' +
			           '<span class="reviewContent">' + review.reviewContent + '</span><br>' +
			           '<span class="reviewLikeCount">' + review.reviewLikeCount + '</span>' +
			           '<hr>' +
			           '</div>';

			       $(".review-list").append(reviewItem);
			   }
			}
		});
	});
	
});
</script>

<body>
                        
	<div>
		이미지 : ${movieSimpleInfo.imageNo} <br>
		영화번호 : ${movieSimpleInfo.movieNo} <br>
		제목 : ${movieSimpleInfo.movieName} <br>
		제작연도 : ${movieSimpleInfo.movieReleaseYear} <br>
		장르 : ${movieSimpleInfo.genreName} <br>
		국가 : ${movieSimpleInfo.movieNation} <br>
		러닝타임 : ${movieSimpleInfo.movieTime} <br>
		관람연령 : ${movieSimpleInfo.movieLevel} <br>
	</div>
    
    <br><br>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
	<div>
		<div>
		  <button type="button" class="ByDateDesc">최신순</button>
		  <button type="button" class="ByDateAsc">오래된순</button>
		  <button type="button" class="ByLikeDesc">좋아요순</button>
		  <button type="button" class="ByRatingDesc">높은평점순</button>
		  <button type="button" class="ByRatingAsc">낮은평점순</button>
		</div>
		<div class="review-list"></div>
	</div>

</body>
</html>