<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="/css/star.css">

<!-- swiper cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<style>
body {
   padding-top: 30px;
}
.review-item {
        border: 1px solid #ccc;
        background-color: rgb(179, 57, 57, 0.2);
		padding: 10px;
        margin-bottom: 10px;
        border-radius: 10px;
        width: 10em;
        height: 10em;
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
.btn-primary {
    background-color: rgb(179, 57, 57);;
    color:white;
    border-color: rgb(179, 57, 57);
    font-size: 16px;
}
.btn-primary:hover {
    background-color: rgb(179, 57, 57, 0.8);
    color: white;
    border-color: rgb(179, 57, 57, 0.8);
    font-size: 16px;
}
.btn-primary:active {
    background-color: rgb(179, 57, 57);
    color: white;
    border-color: rgb(179, 57, 57);
    font-size: 16px;
}
.btn-danger,
.btn-danger:hover{
    background-color: white;
    color:rgb(179, 57, 57);
    border-color: rgb(179, 57, 57);
    border-width: 2px;
    font-size: 16px;
}
.btn-danger:active{
    background-color: white;
    color:rgb(179, 57, 57, 0.5);
    border-color: rgb(179, 57, 57, 0.5);
    border-width: 2px;
    font-size: 16px;
}
.btn-success,
.btn-success:hover{
    background-color: rgb(179, 57, 57);
    color:white;
    border-color: rgb(179, 57, 57);
    border-width: 2px;
    font-size: 16px;
}
.btn-success:active{
    background-color: rgb(179, 57, 57, 0.5);
    color:white;
    border-color: rgb(179, 57, 57, 0.5);
    border-width: 2px;
    font-size: 16px;
}
.img-thumbnail{
    	width: 35px;
    	height: 35px;
    	border-radius: 30px;
}
.ellipsis {
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
}
h4 {
 	font-style bold: 
}
.custom-next {
	right: 0;
	/*원하는 위치로 조정 (예: 오른쪽 끝에 배치)  */
	left: auto;
	top: 60%;
	/*예: 50% 위로 이동 */
	transform: translateY(-50%);
	/*세로 중앙 정렬을 위한 추가 설정 */
	color: #fff; /* 버튼 텍스트 색상 */
	border-radius: 5px; /* 버튼 테두리 모양 설정 */
}

.custom-prev {
	left: 0;
	/*원하는 위치로 조정 (예: 왼쪽 끝에 배치) */
	right: auto;
	top: 60%;
	/*예: 50% 위로 이동  */
	transform: translateY(-50%);
	/*세로 중앙 정렬을 위한 추가 설정  */
	/* 		 color: #fff; /* 버튼 텍스트 색상 */ */
	border-radius: 5px; /* 버튼 테두리 모양 설정 */
}
.message-list{
	height:65vh;
	overflow-y: scroll;
	padding-bottom: 5px; 
}
::-webkit-scrollbar{
   	width: 3px; /* 스크롤바 너비 */
   	background-color:black;
}
::-webkit-scrollbar-thumb {
	background: var(--bs-secondary); /* 스크롤바 색상 */
}
.swiper-container {
	width: 100%;
	padding-top: 50px; /* 이전 버튼과 다음 버튼이 겹치지 않도록 상단 패딩 추가 */
}
.swiper-button-next,
.swiper-button-prev {
	top: 50%; /* 버튼을 세로 중앙에 배치 */
	transform: translateY(-50%); /* 세로 중앙에 정렬하기 위한 변형 */
}
.swiper-button-next {
	right: 0; /* 다음 버튼을 오른쪽에 배치 */
	color: rgb(179, 57, 57);
}
.swiper-button-prev {
	left: 0; /* 이전 버튼을 왼쪽에 배치 */
	color: rgb(179, 57, 57);
}
.swiper-slide {
/*		width: auto !important; */
	padding: 0 5px;
} 
.swiper-wrapper {
/* 	display: flex; */
	gap: 3px;
	justify-content: flex-start; /* 왼쪽 정렬 */
	margin-left: -10px; /* 첫 번째 슬라이드와 왼쪽 여백 조절 */
 }
 .swiper-slide img {
	width: 100%;
	height: auto;
}
:root {
	--swiper-theme-color: #B33939 !important;
}
a {
	color: rgb(179, 57, 57);
}
/* .swiper { */
/*             overflow: hidden; /* 여기에 추가 */ */
/*         } */
</style>



<script>
   //영화 찜기능
   $(function() {
      var params = new URLSearchParams(location.search);
      var movieNo = params.get("movieNo");

      $.ajax({
         url : "/rest/movieWish/check",
         method : "post",
         data : {
            movieNo : movieNo
         },
         success : function(response) {
            if (response.check) {
               $(".fa-bookmark").removeClass("fa-solid fa-regular")
                     .addClass("fa-solid");
            } else {
               $(".fa-bookmark").removeClass("fa-solid fa-regular")
                     .addClass("fa-regular");
            }
         }
      });

      $(".fa-bookmark").click(
            function() {
               $.ajax({
                  url : "/rest/movieWish/action",
                  method : "post",
                  data : {
                     movieNo : movieNo
                  },
                  success : function(response) {
                     if (response.check) {
                        $(".fa-bookmark").removeClass(
                              "fa-solid fa-regular").addClass(
                              "fa-solid");
                     } else {
                        $(".fa-bookmark").removeClass(
                              "fa-solid fa-regular").addClass(
                              "fa-regular");
                     }
                  }
               });
            });
   });
</script>

<script>
    $(document).ready(function () {
        var params = new URLSearchParams(location.search);
        var movieNo = params.get("movieNo");
//         console.log("movieNo=" + movieNo);
        
        // 서버에서 현재 사용자의 평점을 가져오는 AJAX 요청
        $.ajax({
            url: '/rest/rating/'+movieNo,
            method: 'GET',
            data: { 
                movieNo: movieNo
            },
            success: function (response) {
//                console.log(response);
                // 서버에서 받아온 평점을 선택한 상태로 만들기
                var selectedRating = response.ratingScore;
                //float형태로 변형
                var numericRating = parseFloat(selectedRating);
                //.을 넣기위해 변형해서
                var escapedRating = numericRating.toString().replace('.', '\\.');
                $('input[name=rating][value=' + escapedRating  + ']').prop('checked', true);
                $('#selectedRating').text('선택된 평점: ' + selectedRating);
            },
            error: function (error) {
                console.error('Error getting rating:', error);
            }
        });

        $(".rate input").on("click", function() {
            var params = new URLSearchParams(location.search);
            var movieNo = params.get("movieNo");

            var selectedRating = $('input[name=rating]:checked').val();
            var numericRating = parseFloat(selectedRating);

            // 기존 별점을 확인하는 Ajax 요청
            $.ajax({
                url: '/rest/rating/' + movieNo,
                method: 'GET',
                success: function(response) {
//                    console.log(typeof response.ratingScore);
                    // 기존 별점이 존재한다면 수정
                    if (Object.keys(response).length > 0) {

                       
                        // 이미 매긴 별점과 동일한 경우 삭제 처리
//                         console.log(response.ratingScore=== parseFloat(selectedRating));
                        if (parseFloat(response.ratingScore) === parseFloat(selectedRating)) {//selectedRating은 String이라 변환
                           var confirmDelete = confirm("별점 삭제시 본인이 작성한 리뷰도 함께 삭제됩니다. \n정말 별점을 삭제하시겠습니까?");
                            if (confirmDelete) {
                                // 사용자가 확인한 경우에만 삭제 처리
                                $.ajax({
                                    url: '/rest/rating/' + response.ratingNo,
                                    method: 'DELETE',
                                    success: function(deleteResponse) {
//                                         console.log('평점이 성공적으로 삭제되었습니다.');
                                        $('.rate input').prop('checked', false);//삭제했으면 별점 비어있는 형태로 만들기
                                        location.reload();
                              
                                    },
                                    error: function(deleteError) {
                                        console.error('평점 삭제 중 오류가 발생했습니다:', deleteError);
                                    }
                                });
                            } else {
                                // 사용자가 취소한 경우 등록된 별점을 선택한 상태로 변경
                                var numericRating = parseFloat(response.ratingScore);
                                var escapedRating = numericRating.toString().replace('.', '\\.');
                                $('input[name=rating][value=' + escapedRating + ']').prop('checked', true);
                            }
                        } else {
                            // 이미 매긴 별점과 동일하지 않은 경우 수정 처리
                            $.ajax({
                                url: '/rest/rating/' + response.ratingNo,
                                method: 'PUT',
                                data: {
                                    ratingScore: selectedRating
                                },
                                success: function(updateResponse) {
                                    console.log('평점이 성공적으로 수정되었습니다.');
                                    // 추가적인 UI 업데이트 로직 작성
                                },
                                error: function(updateError) {
                                    console.error('평점 수정 중 오류가 발생했습니다:', updateError);
                                }
                            });
                        }
                    } else {
                        // 기존 별점이 없다면 바로 등록을 수행하는 Ajax 요청
                        $.ajax({
                            url: '/rest/rating/' + movieNo,
                            method: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({
                                movieNo: movieNo,
                                ratingScore: selectedRating
                            }),
                            success: function(registerResponse) {
                                console.log('평점이 성공적으로 등록되었습니다.');
                                // 추가적인 UI 업데이트 로직 작성
                            },
                            error: function(registerError) {
                                console.error('평점 등록 중 오류가 발생했습니다:', registerError);
                            }
                        });
                    }
                },
                error: function(error) {
                    console.error('기존 평점 조회 중 오류가 발생했습니다:', error);
                }
            });
        });
    });
</script>

<script>
$(function () {
   
    // 리뷰 작성(등록)
    $(".writeReview").click(function(e){
        // 리뷰작성 버튼 숨기기
        $(this).hide();
      
        var selectedRating = $('input[name=rating]:checked').val();
        
        // 리뷰 버튼 창 가져오기
        var reviewWriteContainer = $(this).closest(".review-write-container");

        // 영화 번호 가져오기
        var params = new URLSearchParams(location.search);
        var movieNo = params.get("movieNo");

        // 리뷰 작성 창 띄우기
        var writeTemplate = $("#review-write-template").html();
        var writeHtmlTemplate = $.parseHTML(writeTemplate);
        var reviewContent = $(writeHtmlTemplate).find(".form-control");

        // 작성 취소
        $(writeHtmlTemplate).find(".write-cancel").click(function(){
            reviewWriteContainer.show();
            $(writeHtmlTemplate).remove();
        });

        // 작성(등록)
        $(writeHtmlTemplate).find(".write-success").click(function(e){
            e.preventDefault();

            var params = new URLSearchParams(location.search);
            var movieNo = params.get("movieNo");
            
            console.log(selectedRating);
            
            var reviewContent = $("#review-content").val(); // .val() 추가
         
            if (selectedRating != null) {
               $.ajax({
                   url: "http://localhost:8080/rest/review/list/writeReview?movieNo=" + movieNo,
                   method: "post",
                   data: {
                       movieNo: movieNo,
                       reviewContent: reviewContent // reviewContent.val()로 변경
                   },
                   success: function(response){
                      console.log(response);
                      
                       reviewWriteContainer.show();
                       $(writeHtmlTemplate).remove(); // 변수명 수정
                       window.alert("리뷰가 작성되었습니다!");
                       location.reload();
                   },
                   error: function(error) {
                       window.alert("이미 리뷰를 등록하셨습니다.");
                       reviewWriteContainer.show();
                      $(writeHtmlTemplate).remove();
                   },
               });
           } else {
               handleError("별점을 먼저 등록해주세요");
               reviewWriteContainer.show();
               $(writeHtmlTemplate).remove();
           }
            
           function handleError(errorMessage) {
               window.alert(errorMessage);
           }
        });

        reviewWriteContainer.hide().after(writeHtmlTemplate);
        $(this).show();
    });
});
</script>

<script>
$(document).ready(function(){
   var params = new URLSearchParams(location.search);
    var movieNo = params.get("movieNo");
    
   //좋아요 체크
   loadReviewLike(movieNo);
   
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
                   
                   var $likeButton = $(".likeButton[data-reviewNo='" + reviewNo + "']");
                   var $likeIcon = $likeButton.find(".fa-thumbs-up");
                   
                   var hrefInfo = "review/detail?movieNo=" + movieNo + "&reviewNo=" + reviewNo;
                   var $commentButton = $(".commentButton[data-reviewNo='" + reviewNo + "']");
                   $commentButton.attr("href", hrefInfo);
                   
                   console.log(hrefInfo);
   
                   if (liked) {
                       $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-solid");
                   } else {
                       $likeIcon.removeClass("fa-regular fa-solid").addClass("fa-regular");
                   }
                   $likeButton.find(".reviewLikeCount").text(response[i].count);
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
             
            var $likeButton = $(".likeButton[data-reviewno='" + reviewNo + "']");

            if (response.check) {
               $likeButton.find(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-regular");
               $likeButton.find(".reviewLikeCount").text(response.count);
            } else {
               $likeButton.find(".fa-thumbs-up").removeClass("fa-regular fa-solid").addClass("fa-solid");
               $likeButton.find(".reviewLikeCount").text(response.count);
            }
            
         },
         error : function() {
            window.alert("로그인 후 이용 가능합니다.");
         }
      });
   }
  
   $(".review-container").on("click", ".likeButton", function () {
      var clickedReviewNo = $(this).data("reviewno");
      reviewLike(clickedReviewNo);
   });
});


</script>

<script id="review-write-template" type="text/template">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<textarea class="form-control" id="review-content" name="reviewContent" rows="10" style="height: 150px; resize: none;"></textarea>
			</div>
			<div class="col-sm-8 offset-sm-2 col-md-8 col-md-2 col-lg-8 offset-lg-2 mt-2">
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-danger write-cancel">취소</button>
					<button type="submit" class="btn btn-success ms-2 write-success">등록</button>
				</div>
			</div>
		</div>
	</div>
</script>


	<!-- Movie Details Section -->
	<div class="container mt-4">
		<div class="row">
			<!-- Movie Poster -->
			<div class="col-md-4 text-center">
				<div>
					<img src="/rest/image/${mainImgNo}" class="img-thumbnail"
						style="width: 215px; height: 300px">
				</div>
				<div>
					<!-- Rating Section -->
	<%-- 				<c:choose> --%>
						<c:if test="${ratingAvg != null}">
							<h4 class="mt-4">평점 평균: ${ratingAvg}</h4>
						</c:if>
	<%-- 					<c:otherwise> --%>
	<!-- 						<h4 class="mt-4">평점 평균: 0.0</h4> -->
	<%-- 					</c:otherwise> --%>
	<%-- 				</c:choose> --%>
					<c:if test="${sessionScope.name != null }">
					<fieldset class="rate">
					    <input type="radio" id="rating10" name="rating" value="5"><label for="rating10" title="5점"></label>
					    <input type="radio" id="rating9" name="rating" value="4.5"><label class="half" for="rating9" title="4.5점"></label>
					    <input type="radio" id="rating8" name="rating" value="4"><label for="rating8" title="4점"></label>
					    <input type="radio" id="rating7" name="rating" value="3.5"><label class="half" for="rating7" title="3.5점"></label>
					    <input type="radio" id="rating6" name="rating" value="3"><label for="rating6" title="3점"></label>
					    <input type="radio" id="rating5" name="rating" value="2.5"><label class="half" for="rating5" title="2.5점"></label>
					    <input type="radio" id="rating4" name="rating" value="2"><label for="rating4" title="2점"></label>
					    <input type="radio" id="rating3" name="rating" value="1.5"><label class="half" for="rating3" title="1.5점"></label>
					    <input type="radio" id="rating2" name="rating" value="1"><label for="rating2" title="1점"></label>
					    <input type="radio" id="rating1" name="rating" value="0.5"><label class="half" for="rating1" title="0.5점"></label>
					
					</fieldset>
					</c:if>
				</div>
			</div>
			<!-- Movie Information -->
			<div class="col-md-8">
				<h2 class="mb-3" style="font-weight: bold;">${movieDto.movieName}
					<c:if test="${sessionScope.name != null}">
					<i class="fa-regular fa-bookmark"></i>
					</c:if>
				</h2>
				<p>
					<strong>영화감독: </strong> ${movieDto.movieDirector}
				</p>
				<p>
					<strong>출시년도: </strong>
					<fmt:formatDate value="${movieDto.movieReleaseDate}" pattern="yyyy" />
				</p>
				<p>
					<strong>영화 장르: </strong>
					<c:forEach var="movieGenreDto" items="${movieGenreList}"
						varStatus="loopStatus">
	                   	${movieGenreDto.genreName} 
	                   <c:if test="${not loopStatus.last}">/</c:if>
					</c:forEach>
				</p>
				<p>
					<strong>영화제작 국가: </strong> ${movieDto.movieNation}
				</p>
				<p>
					<strong>영화 상영시간: </strong> ${movieDto.movieTime} 분
				</p>
				<p>
					<strong>영화 등급: </strong> ${movieDto.movieLevel}
				</p>
				<p>
					<strong>영화 줄거리: </strong> ${movieDto.movieContent}
				</p>
			</div>
			
			<!-- 리뷰 작성란 -->
			<c:if test="${sessionScope.name != null }">
			<div class="row content-end review-write-container">
			    <div class="col d-flex justify-content-end">
			        <button type="button" class="btn btn-primary writeReview">
			            리뷰작성 <i class="fa-solid fa-pen" style="color: #fff;"></i>
			        </button>
			    </div>
			</div>
			</c:if>
			
			<!-- Still Cut Section -->
<!-- 			<h4 class="mt-3">영화 갤러리</h4> -->
<%-- 			<c:if test="${movieDetailList != null}"> --%>
<!-- 			    <div class="row"> -->
<%-- 			        <c:forEach var="movieDetailVO" items="${movieDetailList}"> --%>
<!-- 			            <div class="col-12 col-md-6 col-lg-4"> -->
<%-- 			                <img src="/rest/image/${movieDetailVO.detailImgNo}" class="img-thumbnail" style="width: 500px; height: 300px"> --%>
<!-- 			            </div> -->
<%-- 			        </c:forEach> --%>
<!-- 			    </div> -->
<%-- 			</c:if> --%>
			
			<div class="row mt-5 p-3">
				<div class="col">
					<h4 class="mt-3">영화 갤러리</h4>
				</div>
			</div>
			<div class="swiper row">
				<div class="swiper-wrapper" >
					<c:if test="${movieDetailList != null}">
		        		<c:forEach var="movieDetailVO" items="${movieDetailList}">
		        			<div class="swiper-slide" style="min-width: 240px; overflow: hidden; ">
		        				<div class="col-sm-6 col-md-4 col-lg-3" style="width: 236px;">	
			                		<img src="/rest/image/${movieDetailVO.detailImgNo}" class="img-thumbnail" style="width: 236px; height: 310px;">
			            		</div>
			            	</div>
		       	 		</c:forEach>
					</c:if>
				</div>
			    <div class="swiper-button-next custom-next"></div>
				<div class="swiper-button-prev custom-prev"></div>
			</div>		

         <!-- Cast Section -->
         <h4 class="mt-5">출연자</h4>
         <c:if test="${actorDetailList != null}">
            <c:forEach var="actorDetailVO" items="${actorDetailList}">

               <div class="col" style="width: 100px;">
                    <img src="/image/actor/${actorDetailVO.actorNo}" class="img-thumbnail"
                       style="width: 100px; height: 120px">
                    <p>${actorDetailVO.actorName} (${actorDetailVO.actorRole})</p>
                 </div>
            </c:forEach>
         </c:if>

			<!-- Review Section -->
			<div class="container mt-5">
				<div class="row">
					<div class="col d-flex">
						<h4 class="mt-3" style="font-weight: bold">리뷰</h4>
						<div class="ms-auto mt-3">
							<a href="review/list?movieNo=${movieDto.movieNo}" class="btn btn-link">
								<button class="btn btn-link">
									더보기 <i class="fa-solid fa-angle-right"></i>
								</button>
							</a>
						</div>
					</div>
				</div>
				
				<div class="row row-cols-1 row-cols-md-5 g-4 review-container">
				    <c:forEach var="reviewDto" items="${reviewList}">
				        <div class="col-lg-3 col-md-3 col-sm">
				            <div class="review-item">
				                <c:choose>
				                    <c:when test="${reviewDto.imageNo != 0}">
				                        <img src="/rest/image/${reviewDto.imageNo}" class="userImage img-thumbnail">
				                    </c:when>
				                    <c:otherwise>
				                        <img src="/images/user.jpg" class="userImage img-thumbnail">
				                    </c:otherwise>
				                </c:choose>
				                <strong>${reviewDto.memberNickname}</strong>
				                <p class="mt-3 ellipsis" style="max-width: 200px;">${reviewDto.reviewContent}</p>
				                <div class="mt-3">
				                    <button type="button" class="btn btn-link likeButton" data-reviewNo="${reviewDto.reviewNo}">
				                        <i class="fa-regular fa-thumbs-up"><span class="reviewLikeCount"></span></i>
				                    </button>
				                    <a class="commentButton" data-reviewNo="${reviewDto.reviewNo}">
				                        <button type="button" class="btn btn-link replyButton" data-reviewNo="${reviewDto.reviewNo}">
				                            <i class="fa-regular fa-comment"><span class="reviewReplyCount">${reviewDto.reviewReplyCount}</span></i>
				                        </button>
				                    </a>
				                </div>
				            </div>
				        </div>
				    </c:forEach>
				</div>
				
			</div>
      </div>
   </div>
   
<script>
	//스와이퍼 설정
	var swiper = new Swiper('.swiper', {
		slidesPerView : 5,
		slidesPerGroup : 5,
		spaceBetween: 5,
		loop : true,
		navigation : {
			nextEl : '.custom-next', // 커스텀 클래스 지정
			prevEl : '.custom-prev', // 커스텀 클래스 지정
		},
		pagination : {
			el : '.swiper-pagination',
			clickable : true,
		},
		   speed: 700,
		    observer: true, // 이 부분을 추가
		    observeParents: true, // 이 부분을 추가
	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>