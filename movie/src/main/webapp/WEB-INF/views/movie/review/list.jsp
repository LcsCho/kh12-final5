<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .card{
        background-color: rgb(179, 57, 57, 0.2);
    }
    .btn-link{
        color: rgb(179, 57, 57);
        font-size: 18px;
    }
    .btn-link:hover{
        background-color: rgb(179, 57, 57, 0.1);
        color: rgb(179, 57, 57);
        font-size: 18px;
    }
    .btn-link:active{
        background-color: rgb(179, 57, 57, 0.1);
        color: rgb(179, 57, 57);
        font-size: 18px;
    }
    .userImage{
        width: 45px;
        border-radius: 30px;
    }
    .btn-info{
    	background-color: white;
        color: black;
        font-size: 18px;
        font-weight: bold;
        border-color: rgb(179, 57, 57);
        border-width: 2px;
    }
    .btn-info:hover{
    	background-color: rgb(179, 57, 57);
        color: white;
        font-size: 18px;
        font-weight: bold;
        border-color: rgb(179, 57, 57);
        border-width: 2px;
    }
    .btn-info:active{
    	background-color: rgb(179, 57, 57);
        color: white;
        font-size: 18px;
        font-weight: bold;
        border-color: rgb(179, 57, 57);
        border-width: 2px;
    }
    .btn-info.active{
    	background-color: rgb(179, 57, 57);
        color: white;
        font-size: 18px;
        font-weight: bold;
        border-color: rgb(179, 57, 57);
        border-width: 2px;
    }
    .img-thumbnail{
    	width: 50px;
    	height: 50px;
    }
</style>

<script>
$(function () {
    var params = new URLSearchParams(location.search);
    var movieNo = params.get("movieNo");
    
  	//페이지 로딩 시 최신순 조회(+버튼 이벤트)
    $(document).ready(function () {
    	$(".ByDateDesc").click();
    });
  
  //선택된 버튼 이벤트
    function changeButton(clickedButton) {
	    var activeButton = $(".btn-info").filter(function() {
	        return $(this).hasClass('active');
	    });
	
	    if (activeButton) {
	        activeButton.removeClass('active');
	    }
	
	    $(clickedButton).addClass('active');
	}
	
    //좋아요 체크
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
		
    //좋아요 설정/해제
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
            },
            error : function() {
				window.alert("로그인 후 이용 가능합니다.");
			}
        });
    }
    
    $(".review-list").on("click", ".likeButton", function () {
        var clickedReviewNo = $(this).data("reviewno");
        loadReviewLike(movieNo);
        reviewLike(clickedReviewNo);
    });

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
				    $(htmlTemplate).find(".card").attr("data-reviewno", review.reviewNo);
				    
	                var reviewNo = review.reviewNo;
	                
	                var hrefInfo = "detail?movieNo=" + movieNo + "&reviewNo=" + reviewNo;
	                $(htmlTemplate).find(".commentButton").attr("href", hrefInfo);

	                var imageNo = review.imageNo;
	                
	                var imageHref = "/rest/image/" + imageNo;
	                $(htmlTemplate).find(".userImage").attr("src", imageHref);
	                
	                console.log(imageHref);
	                
				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);
				    $(htmlTemplate).find(".replyButton .replyCount").text(review.reviewReplyCount);

				    $(".review-list").append(htmlTemplate);
				}
				loadReviewLike(movieNo);
            }
        });
    	changeButton(this);
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

				    $(htmlTemplate).find(".likeButton").attr("data-reviewno", review.reviewNo);
				    $(htmlTemplate).find(".card").attr("data-reviewno", review.reviewNo);
				    
	                var reviewNo = review.reviewNo;
	                
	                var hrefInfo = "detail?movieNo=" + movieNo + "&reviewNo=" + reviewNo;
	                $(htmlTemplate).find(".commentButton").attr("href", hrefInfo);

	                var imageNo = review.imageNo;
	                
	                var imageHref = "/rest/image/" + imageNo;
	                $(htmlTemplate).find(".userImage").attr("src", imageHref);
	                
	                console.log(imageHref);
	                
				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);
				    $(htmlTemplate).find(".replyButton .replyCount").text(review.reviewReplyCount);

				    $(".review-list").append(htmlTemplate);
				}
				loadReviewLike(movieNo);
            }
		});
		changeButton(this);
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

				    $(htmlTemplate).find(".likeButton").attr("data-reviewno", review.reviewNo);
				    $(htmlTemplate).find(".card").attr("data-reviewno", review.reviewNo);
				    
	                var reviewNo = review.reviewNo;
	                
	                var hrefInfo = "detail?movieNo=" + movieNo + "&reviewNo=" + reviewNo;
	                $(htmlTemplate).find(".commentButton").attr("href", hrefInfo);

	                var imageNo = review.imageNo;
	                
	                var imageHref = "/rest/image/" + imageNo;
	                $(htmlTemplate).find(".userImage").attr("src", imageHref);
	                
	                console.log(imageHref);
	                
				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);
				    $(htmlTemplate).find(".replyButton .replyCount").text(review.reviewReplyCount);

				    $(".review-list").append(htmlTemplate);
				}
				loadReviewLike(movieNo);
            }
		});
		changeButton(this);
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

				    $(htmlTemplate).find(".likeButton").attr("data-reviewno", review.reviewNo);
				    $(htmlTemplate).find(".card").attr("data-reviewno", review.reviewNo);
				    
	                var reviewNo = review.reviewNo;
	                
	                var hrefInfo = "detail?movieNo=" + movieNo + "&reviewNo=" + reviewNo;
	                $(htmlTemplate).find(".commentButton").attr("href", hrefInfo);

	                var imageNo = review.imageNo;
	                
	                var imageHref = "/rest/image/" + imageNo;
	                $(htmlTemplate).find(".userImage").attr("src", imageHref);
	                
	                console.log(imageHref);
	                
				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);
				    $(htmlTemplate).find(".replyButton .replyCount").text(review.reviewReplyCount);

				    $(".review-list").append(htmlTemplate);
				}
				loadReviewLike(movieNo);
            }
		});
		changeButton(this);
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

				    $(htmlTemplate).find(".likeButton").attr("data-reviewno", review.reviewNo);
				    $(htmlTemplate).find(".card").attr("data-reviewno", review.reviewNo);
				    
	                var reviewNo = review.reviewNo;
	                
	                var hrefInfo = "detail?movieNo=" + movieNo + "&reviewNo=" + reviewNo;
	                $(htmlTemplate).find(".commentButton").attr("href", hrefInfo);

	                var imageNo = review.imageNo;
	                
	                var imageHref = "/rest/image/" + imageNo;
	                $(htmlTemplate).find(".userImage").attr("src", imageHref);
	                
	                console.log(imageHref);
	                
				    $(htmlTemplate).find(".reviewNo").text(review.reviewNo);
				    $(htmlTemplate).find(".memberNickname").text(review.memberNickname);
				    $(htmlTemplate).find(".ratingScore").text(review.ratingScore);
				    $(htmlTemplate).find(".reviewContent").text(review.reviewContent);
				    $(htmlTemplate).find(".likeButton .likeCount").text(review.reviewLikeCount);
				    $(htmlTemplate).find(".replyButton .replyCount").text(review.reviewReplyCount);

				    $(".review-list").append(htmlTemplate);
				}
				loadReviewLike(movieNo);
            }
		});
		changeButton(this);
	});

});
</script>

<script id="review-template" type="text/template">
	<div class="card mt-3">
		<div class="card-body">
			<div>
				<img class="userImage img-thumbnail">
				<span class="card-title ms-3 memberNickname" style="font-weight: bold; font-size: 20px;"></span>
				<i class="fa-solid fa-star"></i><span class="ratingScore"></span>
			</div>
			<div class="mt-3 pb-3">
				<span class="card-text reviewContent"></span>
			</div>
			<hr>
			<div class="row text-center">
				<div class="col">
					<button type="button" class="btn btn-link likeButton" data-reviewNo="">
						<i class="fa-regular fa-thumbs-up"><span class="likeCount"></span></i>
					</button>
				</div>
				<div class="col">
					<a class="commentButton">					
						<button type="button" class="btn btn-link replyButton">
							<i class="fa-regular fa-comment"><span class="replyCount"></span></i>
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-10 offset-md-1 mb-5 mt-5">
			
			<div class="row">
				<div class="col-3">
					<a href="/movie/detail?movieNo=${movieSimpleInfo.movieNo}">
						<button type="button" class="btn btn-link">
							<i class="fa-solid fa-angle-left"></i>영화 상세
						</button>
					</a>
				</div>
			</div>
			
			<div class="row">
	            <div class="col-2 offset-4 text-right">
	                <img src="/rest/image/movieMain/${movieNo}" class="img-thumbnail"  style="width: 215px; height: 300px">
	            </div>
	            <div class="col-6 text-right">
	                <div class="row mt-5 pt-5">
	                    <h2 class="mt-5 pt-4">${movieSimpleInfo.movieName}</h2>
	                </div>
	                <div class="row mt-3">
	                    <div class="col-6">
	                        <span>${movieSimpleInfo.movieReleaseYear}</span>
	                        <span> • </span>
	                        <span>${movieSimpleInfo.genreName}</span>
	                        <span> • </span>
	                        <span>${movieSimpleInfo.movieNation}</span>
	                    </div>
	                </div>
	                <div class="row mt-2">
	                    <div class="col-6">
	                        <span>${movieSimpleInfo.movieTime}분</span>
	                        <span> • </span>
	                        <span>${movieSimpleInfo.movieLevel}</span>
	                    </div>
	                </div>
	            </div>
	        </div>

			<div class="row mt-5">
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<button type="button" class="btn btn-info ByDateDesc active">최신순</button>
					<button type="button" class="btn btn-info ByDateAsc">오래된순</button>
					<button type="button" class="btn btn-info ByLikeDesc">좋아요순</button>
					<button type="button" class="btn btn-info ByRatingDesc">높은평점순</button>
					<button type="button" class="btn btn-info ByRatingAsc">낮은평점순</button>
				</div>
			</div>
					
			<div class="row">
				<div class="review-list"></div>
			</div>

		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>