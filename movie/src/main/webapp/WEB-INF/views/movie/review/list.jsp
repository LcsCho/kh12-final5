<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
</head>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function(){ 
	var params = new URLSearchParams(location.search);
    var movieNo = params.get("movieNo");
	
	$(document).ready(function () {
        $(".ByDateDesc").click();
    });
	
	//좋아요 체크
	function loadReviewLike(movieNo){
	    $.ajax({
	        url: "http://localhost:8080/rest/review/list/findReviewLike?movieNo=" + movieNo,
	        method: "post",
	        data: {
	            movieNo : movieNo,
	        },
	        success: function(response){
	        	console.log(response);
	        	
	        	//for (let i = 0; i < response.length; i++) {
	                var check = response[i].check;
	                
	                console.log(check);

	                if (check == "Y") {
	                    $(".review-list .fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid");
	                } else {
	                    $(".review-list .fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular");
	                }
	            //}
	        }
	    });
	}
	
	//최신순 조회
	$(".ByDateDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByDateDesc?movieNo=" + movieNo,
			method: "post",
			data: {
				movieNo : movieNo,
				sortType: "findByDateDesc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var ratingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;
					var reviewNo = response[i].reviewNo;
					
					$(".review-list").append(
							'<div data-reviewNo="' + reviewNo + '">' +
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + ratingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
								 '<button class="likeButton" data-reviewNo="' + reviewNo + '"><i class="fa-regular fa-thumbs-up"></i><label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'</div>' +
							'</div>'
					);
					
					$(".review-list [data-reviewNo='" + reviewNo + "'] .likeButton").click(function () {
			            var clickedReviewNo = $(this).data("reviewno");
			            
			            console.log(reviewNo);
			            
			            $.ajax({
			                url: "http://localhost:8080/rest/review/list/likeAction?reviewNo=" + reviewNo,
			                method: "post",
			                data: {
			                    movieNo: movieNo,
			                    reviewNo: reviewNo
			                },
			                success: function (response) {
			                    if (response.check) {
			                        $(".review-list [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up")
			                            .removeClass("fa-regular fa-solid")
			                            .addClass("fa-regular");
			                    } else {
			                        $(".review-list [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up")
			                            .removeClass("fa-regular fa-solid")
			                            .addClass("fa-solid");
			                    }
			                    $(".review-list [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up")
			                        .next("label.thumbs-up")
			                        .text(response.count);
			                }
			            });
			    	});
			    	loadReviewLike(movieNo);
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
				movieNo : movieNo,
				sortType: "ByDateAsc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var ratingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;
					var reviewNo = response[i].reviewNo;
					
					$(".review-list").append(
							'<div data-reviewNo="' + reviewNo + '">' +
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + ratingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
								 '<button class="likeButton" data-reviewNo="' + reviewNo + '"><i class="fa-regular fa-thumbs-up"></i><label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'</div>' +
							'</div>'
					);
				}
			}
		});
		loadReviewLike(movieNo);
	});
	
	//좋아요순 조회
	$(".ByLikeDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByLikeDesc?movieNo=" + movieNo,
			method: "post",
			data: {
				movieNo : movieNo,
				sortType: "ByLikeDesc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var ratingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;
					var reviewNo = response[i].reviewNo;
					
					$(".review-list").append(
							'<div data-reviewNo="' + reviewNo + '">' +
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + ratingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
								 '<button class="likeButton" data-reviewNo="' + reviewNo + '"><i class="fa-regular fa-thumbs-up"></i><label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'</div>' +
							'</div>'
					);
				}
			}
		});
		loadReviewLike(movieNo);
	});
	
	//평점높은순 조회
	$(".ByRatingDesc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByRatingDesc?movieNo=" + movieNo,
			method: "post",
			data: {
				movieNo : movieNo,
				sortType: "ByRatingDesc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var ratingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;
					var reviewNo = response[i].reviewNo;
					
					$(".review-list").append(
							'<div data-reviewNo="' + reviewNo + '">' +
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + ratingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
								 '<button class="likeButton" data-reviewNo="' + reviewNo + '"><i class="fa-regular fa-thumbs-up"></i><label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'</div>' +
							'</div>'
					);
				}
			}
		});
		loadReviewLike(movieNo);
	});
	
	//평점낮은순 조회
	$(".ByRatingAsc").click(function(){
		$.ajax({
			url: "http://localhost:8080/rest/review/list/findByRatingAsc?movieNo=" + movieNo,
			method: "post",
			data: {
				movieNo : movieNo,
				sortType: "ByRatingAsc"
			},
			success: function(response) {
			    $(".review-list").empty();

			    for (var i = 0; i < response.length; i++) {
					var memberNickname = response[i].memberNickname;
					var ratingScore = response[i].ratingScore;
					var reviewContent = response[i].reviewContent;
					var reviewLikeCount = response[i].reviewLikeCount;
					var reviewNo = response[i].reviewNo;
					
					$(".review-list").append(
							'<div data-reviewNo="' + reviewNo + '">' +
							'<div>' + 
								'<div>' + 
									memberNickname + ' | ' + '<i class="fa-solid fa-star"></i>' + ratingScore + 
								'</div>' +
								'<div>' + 
									reviewContent + 
								'</div>' +
								'<div>' +
								 '<button class="likeButton" data-reviewNo="' + reviewNo + '"><i class="fa-regular fa-thumbs-up"></i><label class="thumbs-up">' + reviewLikeCount + '</label></button>' +
									'<button class="commentButton"><i class="fa-regular fa-comment"></i> <label class="comment">' + 0 + '</label></button>' +
								'</div>' +
							'</div>'
					);
				}
			}
		});
		loadReviewLike(movieNo);
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>