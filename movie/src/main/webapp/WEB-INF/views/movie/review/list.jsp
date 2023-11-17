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
$(function () {
    var params = new URLSearchParams(location.search);
    var movieNo = params.get("movieNo");

    $(document).ready(function () {
        $(".ByDateDesc").click();
    });

    function loadReviewLike(movieNo) {
        $.ajax({
            url: "http://localhost:8080/rest/review/list/findReviewLike?movieNo=" + movieNo,
            method: "post",
            data: {
                movieNo: movieNo,
            },
            success: function (response) {
                for (var i = 0; i < response.length; i++) {
                    var reviewNo = response[i].reviewNo;
                    var check = response[i].check;
                    var liked = check == "Y";

                    var htmlTemplate = $("#review-template").html();
                    var $template = $(htmlTemplate);
                    var $likeButton = $template.find('.likeButton[data-reviewNo="' + reviewNo + '"]');
                    
                    if (liked) {
                        $(".review-list [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid");
                    } else {
                        $(".review-list [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular");
                    }
                    $(".review-list [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up").next("label.thumbs-up").text(response.reviewLikeCount);
                }
            }
        });
    }
		
    
    function reviewLike(reviewNo) {
        $.ajax({
            url: "http://localhost:8080/rest/review/list/likeAction?reviewNo=" + reviewNo,
            method: "post",
            data: {
                movieNo: movieNo,
                reviewNo: reviewNo
            },
            success: function (response) {
            	loadReviewLike(movieNo);
            	
                var $likeButton = $(".review-list .likeButton[data-reviewNo='" + reviewNo + "']");

                if (response.check) {
                    $likeButton.find(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular");
                    $likeButton.find(".likeCount").text(response.count);
                } else {
                    $likeButton.find(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid");
                    $likeButton.find(".likeCount").text(response.count);
                }
                
                loadReviewLike(movieNo);
            }
        });
    }

    // 최신순 조회
    $(".ByDateDesc").click(function () {
        $.ajax({
            url: "http://localhost:8080/rest/review/list/findByDateDesc?movieNo=" + movieNo,
            method: "post",
            data: {
                movieNo: movieNo,
                sortType: "findByDateDesc"
            },
            success: function (response) {

            	$(".review-list").empty();
				
				for (var i = 0; i < response.length; i++) {
				    var review = response[i];

				    var template = $("#review-template").html();
				    var htmlTemplate = $.parseHTML(template);

				    $(htmlTemplate).find(".likeButton").attr("data-reviewno", review.reviewNo);

				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);

				    $(".review-list").append(htmlTemplate);
				    
				}
				$(".review-list").on("click", ".likeButton", function () {
			        var clickedReviewNo = $(this).data("reviewno");
			        loadReviewLike(movieNo);
			        reviewLike(clickedReviewNo);
			    });

				loadReviewLike(movieNo);
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
			success: function (response) {
            	
				$(".review-list").empty();
				
				for (var i = 0; i < response.length; i++) {
				    var review = response[i];

				    var template = $("#review-template").html();
				    var htmlTemplate = $.parseHTML(template);

				    $(htmlTemplate).find(".likeButton").attr("data-reviewNo", review.reviewNo);

				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);

				    $(".review-list").append(htmlTemplate);
				}

				loadReviewLike(movieNo);
            }
		});
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
			success: function (response) {
            	
				$(".review-list").empty();
				
				for (var i = 0; i < response.length; i++) {
				    var review = response[i];

				    var template = $("#review-template").html();
				    var htmlTemplate = $.parseHTML(template);

				    $(htmlTemplate).find(".likeButton").attr("data-reviewNo", review.reviewNo);

				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);

				    $(".review-list").append(htmlTemplate);
				}

				loadReviewLike(movieNo);
            }
		});
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
			success: function (response) {
            	
				$(".review-list").empty();
				
				for (var i = 0; i < response.length; i++) {
				    var review = response[i];

				    var template = $("#review-template").html();
				    var htmlTemplate = $.parseHTML(template);

				    $(htmlTemplate).find(".likeButton").attr("data-reviewNo", review.reviewNo);

				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);

				    $(".review-list").append(htmlTemplate);
				}

				loadReviewLike(movieNo);
            }
		});
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
			success: function (response) {
            	
				$(".review-list").empty();
				
				for (var i = 0; i < response.length; i++) {
				    var review = response[i];

				    var template = $("#review-template").html();
				    var htmlTemplate = $.parseHTML(template);

				    $(htmlTemplate).find(".likeButton").attr("data-reviewNo", review.reviewNo);

				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);

				    $(".review-list").append(htmlTemplate);
				}

				loadReviewLike(movieNo);
            }
		});
	});
	
	;
	
});
</script>
<script id="review-template" type="text/template">
		<div><span class="memberNickname"></span></div>
    	<div><i class="fa-solid fa-star"></i><span class="ratingScore"></span></div>
    	<div><span class="reviewContent"></span></div>
    	<div>
        	<button class="likeButton" data-reviewNo="">
				<i class="fa-solid fa-thumbs-up">
					<span class="likeCount"></span>
				</i></button>
       		<button><i class="fa-regular fa-comment"></i></button>
    	</div>
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>