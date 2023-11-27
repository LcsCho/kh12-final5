<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
$(function(){

    $(document).ready(function () {
        // 페이지 로드 시 리뷰 목록을 가져와서 표시
        loadReviewList();
        loadReviewLikeList();
    });

    function loadReviewLikeList() {//이게 따봉이랑 댓글 값 가져오는 구문입니다
    	console.log("갱신이 됐어요!");	
        $.ajax({
            url: '/rest/member/reviewLikeList',
            method: 'post',
            success: function (response) {
				for(var i = 0; i< response.length; i++){
					var reviewNo = response[i].reviewNo;
					var check =response[i].check;
					var liked = check == "Y";
					
					var htmlTemplate = $("#review-template").html();
					var $template = $(htmlTemplate);
					var $likeButton = $template.find('.likeButton[data-reviewNo="' + reviewNo + '"]');
					if (liked) {
                        $(".review-container [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid");
                    } else {
                        $(".review-container [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular");
                    }
                    $(".review-container [data-reviewNo='" + reviewNo + "'] .fa-thumbs-up").next("label.thumbs-up").text(response.reviewLikeCount);
	
				}

            },
            error: function (error) {
                console.error('리뷰 좋아요 목록 가져오기 오류:', error);
            }
        });
    }
    
    function reviewLike(reviewNo){//내가 따봉 눌렀을 때 처리 되는놈
    	$.ajax({
    		url: "http://localhost:8080/rest/review/list/likeAction?reviewNo=" + reviewNo,
    		method:"post",
    		data:{
    			reviewNo: reviewNo
    		},
    		success : function(response){
    			console.log("count=" + response.count);
    			var $likeButton =$(".review-container .likeButton [data-reviewNo='" + reviewNo + "']");
    			console.log("???" + response.check);
                if (response.check=="Y") {
                	console.log("성공~");
                    $likeButton.find(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular");
                    $likeButton.find(".likeCount").val(response.count);
                } else {
                	console.log("실패~");
                    $likeButton.find(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid");
                    $likeButton.find(".likeCount").val(response.count);
                }
                loadReviewLikeList();
    		},	
    		error:function(){
    			window.alert("오류!");
    		}
    		
    	});
    }
    
    function loadReviewList(){ //그냥 리스트 띄우는 놈
    	$.ajax({
    		url:'/rest/member/reviewList',
    		method:'get',
    		success: function(response){
    			
                response.forEach(function (review) {
                    appendReview(review);
                });
    		}
    	
    		
    		
    	});
    }
    
    
    
    $(".review-container").on("click", ".likeButton", function () {
        var clickedReviewNo = $(this).data("reviewno");
        console.log("click! = "+clickedReviewNo);
        reviewLike(clickedReviewNo);
    });    
    

    function appendReview(review) {
        // 리뷰를 동적으로 생성하여 화면에 추가
        var template = $('#review-template').html();
        var $reviewCard = $(template);
        // 리뷰 데이터를 템플릿에 적용     
        $reviewCard.find('.userImage').attr('src', '/rest/image/' + review.imageNo);
        $reviewCard.find('.memberNickname').text(review.memberNickname);
        $reviewCard.find('.ratingScore').text(review.ratingScore);
        $reviewCard.find('.reviewContent').text(review.reviewContent);
        $reviewCard.find('.replyCount').text(review.reviewReplyCount);
        $reviewCard.find('.likeButton').attr('data-reviewno', review.reviewNo);
        $reviewCard.find('.likeCount').text(review.reviewLikeCount);
        // 리뷰 카드를 화면에 추가
        $('.review-container').append($reviewCard);


    }
    
    
})
</script>
<script id="review-template" type="text/template">
	<div class="card mt-3">
		<div class="card-body">
			<div>
				<img class="userImage">
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
					<a class="commnetButton">					
						<button type="button" class="btn btn-link replyButton">
							<i class="fa-regular fa-comment"><span class="replyCount"></span></i>
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>
</script>

<div class="row">
	<div class="review-container"></div>
</div>
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
</style>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>