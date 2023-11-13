<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
</head>

<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

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
				sortType: "ByDateAsc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var memberRatingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;

					$(".review-list").append(
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + memberRatingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
									'<button class="likeButton"><i class="fa-regular fa-thumbs-up"></i> <label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'<div>' +
							'<div>'
					);
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
				sortType: "ByDateAsc"
			},
		    success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var memberRatingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;

					$(".review-list").append(
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + memberRatingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
									'<button class="likeButton"><i class="fa-regular fa-thumbs-up"></i> <label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'<div>' +
							'<div>'
					);
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
				sortType: "ByLikeDesc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var memberRatingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;

					$(".review-list").append(
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + memberRatingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
									'<button class="likeButton"><i class="fa-regular fa-thumbs-up"></i> <label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'<div>' +
							'<div>'
					);
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
				sortType: "ByRatingDesc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var memberRatingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;

					$(".review-list").append(
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + memberRatingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
									'<button class="likeButton"><i class="fa-regular fa-thumbs-up"></i> <label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'<div>' +
							'<div>'
					);
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
				sortType: "ByRatingAsc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var memberRatingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;

					$(".review-list").append(
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + memberRatingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
									'<button class="likeButton"><i class="fa-regular fa-thumbs-up"></i> <label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'<div>' +
							'<div>'
					);
				}
			}
		});
	});
	
	//좋아요 체크
	$.ajax({
		url: "http://localhost:8080/rest/review/list/like/check?reviewNo=" + reviewNo,
		method: "post",
		data: { reviewNo: reviewNo },
		success:function(response){
			if(response.check){
				$(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid")
			}else{
				$(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular")
			}
			$(".fa-thumbs-up").next("label.thumbs-up").text(response.count);
		}
	});
	
	//좋아요 설정
	$(".likeButton").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/like/action?reviewNo=" + reviewNo,
			method: "post",
			data: { reviewNo: reviewNo },
			success: function(response){
				if(response.check){
					$(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid")
				}else{
					$(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular")
				}
				$(".fa-thumbs-up").next("label.thumbs-up").text(response.count);
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
	</div>
	
	<div>
		<div class="review-list"></div>
	</div>

</body>
</html>