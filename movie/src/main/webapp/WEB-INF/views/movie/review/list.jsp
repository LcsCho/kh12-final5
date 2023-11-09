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
	
	//최신순 조회
	$(".ByDateDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByDateDesc",
			method: "post",
			data: {
				imageNo : "review.reviewNo",
				memberNickname : "review.memberNickname",
				ratingScore : "review.ratingScore",
				reviewCount : "review.reviewContent",
				reviewLikeCount : "review.reviewLikeCount",
				sortType: "findByDateDesc"
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
			url: "http://localhost:8080/rest/review/list/findByDateAsc",
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
			url: "http://localhost:8080/rest/review/list/findByLikeDesc",
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
			url: "http://localhost:8080/rest/review/list/findByRatingDesc",
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
			url: "http://localhost:8080/rest/review/list/findByRatingAsc",
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
		<div>
		  <button type="button" class="ByDateDesc">최신순</button>
		  <button type="button" class="ByDateAsc">오래된순</button>
		  <button type="button" class="ByLikeDesc">좋아요순</button>
		  <button type="button" class="ByRatingDesc">높은평점순</button>
		  <button type="button" class="ByRatingAsc">낮은평점순</button>
		</div>
		<div class="review-list">
		
		</div>
	</div>

</body>
</html>