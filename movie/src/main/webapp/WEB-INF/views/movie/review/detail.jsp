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
</style>

<script>
	$(function(){
		var params = new URLSearchParams(location.search);
	    var reviewNo = params.get("reviewNo");
	    var movieNo = params.get("movieNo");
	    
	    $(document).ready(function () {
			loadReviewLike(movieNo);
		});
	    
	    //댓글 목록
	    $.ajax({
	    	url: "http://localhost:8080/rest/reply/findAll?reviewNo=" + reviewNo,
	    	method: "post",
	    	data: {
				reviewNo : reviewNo
	    	},
	    	success: function(response){
	    		$(".reply-list").empty();
	    		
	    		for (var i = 0; i < response.length; i++) {
	    			var reply = response[i];
	    			
	    			var template = $("#reply-template").html();
	    			var htmlTemplate = $.parseHTML(template);
	    			
	    			$(htmlTemplate).find(".fa-x").attr("data-replyno", reply.replyNo);
	    			
					$(htmlTemplate).find(".memberNickname").text(reply.memberNickname);
					$(htmlTemplate).find(".replyDate").text(reply.replyDate);
					$(htmlTemplate).find(".replyContent").text(reply.replyContent);
					
					$(".reply-list").append(htmlTemplate);
	    		}
	    	}
	    });
	    
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
	                    
	                 	// 해당 리뷰에 대한 좋아요 버튼 선택
	                    var $likeButton = $(".likeButton[data-reviewNo='" + reviewNo + "']");
	                    
	                    // 좋아요 아이콘 선택
	                    var $likeIcon = $likeButton.find(".fa-thumbs-up");

	                    if (liked) {
	                        $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-solid");
	                        $likeButton.find(".likeCount").text(response[i].count);
	                    } else {
	                        $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-regular");
	                        $likeButton.find(".likeCount").text(response[i].count);
	                    }
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
	            	
	            	var $likeButton = $(".likeButton[data-reviewNo='" + reviewNo + "']");
	            	var $likeIcon = $likeButton.find(".fa-thumbs-up");

	            	if (response.check == "Y") {
	            	    $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-solid");
	            	    $(".reviewLikeCount").text(response.count);
	            	} else {
	            	    $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-regular");
	            	    $(".reviewLikeCount").text(response.count);
	            	}
	                
	                loadReviewLike(movieNo);
	            }
	        });
	    }
	    
	    //좋아요 클릭 이벤트
	    $(".likeButton").on("click", function () {
	        var clickedReviewNo = $(this).data("reviewno");
	        reviewLike(clickedReviewNo);
	    });
	    
	    //좋아요 상태 변경
	    function updateReviewLikeUI(reviewNo, count, check) {
	        var $likeButton = $(".likeButton[data-reviewNo='" + reviewNo + "']");
	        var $likeIcon = $likeButton.find(".fa-thumbs-up");
	        var $likeCount = $likeButton.find(".likeCount");

	        if (check == "Y") {
	            $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-solid");
	        } else {
	            $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-regular");
	        }

	        $likeCount.text(count);
	    }

	    // 초기 로드
	    loadReviewLike(movieNo);
	    
	    loadReviewLike(movieNo);
	    
	});
</script>

<script id="reply-template" type="text/template">
	<hr>
	<div class="row">
        <div class="col-8 offset-2">
			
            <div class="row">
                <div class="col-3">
                    <span class="memberNickname"></span>
                </div>
                <div class="col-6">
                    <span class="replyDate"></span>
                </div>
				<div class="col-3 d-flex justify-content-end">
                    <i class="fa-solid fa-x" style="position: relative; top: 10px; right: 20px;"></i>
                </div>
            </div>
            <div class="row mt-3">
                <span class="replyContent"></span>
            </div>
        </div>
    </div>
	<hr>
</script>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-10 offset-md-1 mb-5 mt-5">
	
				<!-- 영화 정보 -->
				<div class="row">
				     <div class="col-2 offset-4 text-right">
				         <img src="./images/chunsik.jpeg" class="img-thumbnail"  style="width: 215px; height: 300px">
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
			
				<!-- 리뷰 정보 -->
				<div class="card mt-3">
					<div class="card-body">
						<div>
							<img src="images/user.png" class="userImage">
							<span class="card-title ms-3" style="font-weight: bold; font-size: 20px;">${review.memberNickname}</span>
							<i class="fa-solid fa-star"></i><span>${review.ratingScore}</span>
							<i class="fa-solid fa-pen-to-square fa-lg eidtReview" style="position: absolute; top: 30px; right: 50px;"></i>
							<i class="fa-solid fa-x fa-lg deleteReview" style="position: absolute; top: 30px; right: 30px;"></i>
						</div>
						<div class="mt-3 pb-3">
							<span class="card-text">${review.reviewContent}</span>
						</div>
						<hr>
						<div class="row text-center">
							<div class="col">
								<button type="button" class="btn btn-primary btn-link likeButton" data-reviewNo="${review.reviewNo}">
									<i class="fa-regular fa-thumbs-up"><span class="reviewLikeCount">${review.reviewLikeCount}</span></i>
								</button>
							</div>
							<div class="col">
								<button type="button" class="btn btn-primary btn-link">
									<i class="fa-regular fa-comment"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 댓글 -->
				<div class="row">
					<div class="reply-list"></div>
				</div>
				
			</div>
        </div>
    </div>
	
</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>