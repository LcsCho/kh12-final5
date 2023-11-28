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
    i {
        color:rgb(179, 57, 57);
    }
    .btn-success{
        background-color: rgb(179, 57, 57);
        border-color: rgb(179, 57, 57);
        font-size: 16px;
    }
    .btn-success:hover{
        background-color: rgb(179, 57, 57);
        border-color: rgb(179, 57, 57);
        font-size: 16px;
    }
    .btn-success:active{
        background-color: rgb(179, 57, 57);
        border-color: rgb(179, 57, 57);
        font-size: 16px;
    }
    .emptyMessage{
       color: rgb(179, 57, 57);
       font-size : 24px;
       font-style: bold;
       text-align: center;
    }
    .img-thumbnail{
       width: 50px;
       height: 50px;
    }
    .nicknameFont{
    	font-size : 18px;
    	font-weight: bold;
    }
</style>


<script>
   $(function(){
      var params = new URLSearchParams(location.search);
       var reviewNo = params.get("reviewNo");
       var movieNo = params.get("movieNo");
       
       var memberNickname = "${memberNickname}";
//        console.log(memberNickname);

	    //댓글 목록 조회
	    loadReplyList();
		
	    //좋아요 체크
	    loadReviewLike(movieNo);
	
	    //삭제 버튼 이벤트
	    $(document).on("click", ".deleteReply", function (e) {
	        var replyNo = $(this).attr("data-reply-no");
	
	        var confirmDelete = confirm("삭제하시겠습니까?");
	        
	        if (confirmDelete) {
	            $.ajax({
	                url: "http://localhost:8080/rest/reply/delete",
	                method: "post",
	                data: {
	                    replyNo: replyNo
	                },
	                success: function (response) {
	                    loadReplyList();
	                }
	            });
	        }
	    });
	
	    // 댓글 목록
	    function loadReplyList() {
	        $.ajax({
	            url: "http://localhost:8080/rest/reply/findAll?reviewNo=" + reviewNo,
	            method: "post",
	            data: {
	                reviewNo: reviewNo,
	            },
	            success: function (response) {
	                $(".reply-list").empty();
	
	                if (response.length === 0) {
	                	$(".reply-list").append(
	                	        "<div class='row mt-5'>" +
	                	            "<div class='col text-center'>" +
	                	        	"<hr>" +
	                	                "<span class='emptyMessage'>" +
	                	                    "등록된 댓글이 없습니다." +
	                	                "</span>" +
	                	            "<hr>" +
	                	            "</div>" +
	                	        "</div>"
	                	    );
	                } else {
	                	for (var i = 0; i < response.length; i++) {
	                        var reply = response[i];
	                        var writeNickname = response[i].memberNickname;
	                  
	                        var template = $("#reply-template").html();
	                        var htmlTemplate = $.parseHTML(template);
	                        
	                        if(memberNickname != writeNickname){
	                        	var XButton = $(htmlTemplate).find(".fa-x").attr("data-replyno", reply.replyNo);
	                        	XButton.hide();
	                        }

                           $(htmlTemplate).find(".fa-x").attr("data-replyno", reply.replyNo);
                           $(htmlTemplate).find(".deleteReply").attr("data-reply-no", reply.replyNo);

                           $(htmlTemplate).find(".memberNickname").text(writeNickname);
                           $(htmlTemplate).find(".replyDate").text(reply.replyDate);
                           $(htmlTemplate).find(".replyContent").text(reply.replyContent);

                           $(".reply-list").append(htmlTemplate);
                       }
                   }
               }
           });
       }
       
       //댓글 등록
       $(".reply-insert-form").submit(function(e){
          e.preventDefault();
          
          $.ajax({
             url: "http://localhost:8080/rest/reply/insert?reviewNo=" + reviewNo,
             method: "post",
             data: $(e.target).serialize(),
             success: function(response){
                
                $("[name=replyContent]").val("");
                loadReplyList();
             },
               error : function() {
               window.alert("로그인 후 이용 가능합니다.");
            },
          });
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
               },
               error : function() {
               window.alert("로그인 후 이용 가능합니다.");
            },
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
      
      //리뷰 수정
       $(".editReview").click(function(e) {
          
          //리뷰 정보란 찾기(closest:가장 근접한 부모 요소)
         var reviewContainer = $(this).closest(".view-container");
         
          //리뷰 번호, 원본글 가져오기
         var params = new URLSearchParams(location.search);
          var reviewNo = params.get("reviewNo");
         var originContent = reviewContainer.find(".card-text").text().trim();
         
         //리뷰 수정 창 띄우기
         var editTemplate = $("#review-edit-template").html();
         var editHtmlTemplate = $.parseHTML(editTemplate);
         
         //리뷰 수정 창에 회원 프로필 이미지 띄우기
         var imageHref = $(".userImage").html();
          $(editHtmlTemplate).find(".userImage").attr("src", imageHref);
      
         //리뷰 수정 창에 원본글 넣기
         $(editHtmlTemplate).find(".card-text").val(originContent);
         
         //회원 이미지 가져와 수정 창에 넣기
         var userImageSrc = reviewContainer.find(".userImage").attr("src");
          $(editHtmlTemplate).find(".userImage").attr("src", userImageSrc);
         
         //취소 버튼 선택 시 리뷰정보란 띄우고, 수정 창 삭제하기
         $(editHtmlTemplate).find(".btn-cancel").click(function() {
            var confirmDeleteReview = confirm("취소하시겠습니까?");
            
            if (confirmDeleteReview) {
               reviewContainer.show();
               $(editHtmlTemplate).remove();
            }
         });
         
         //전송 버튼 선택
         $(editHtmlTemplate).find(".btn-success").click(function (e) {
             e.preventDefault();
            
             var confirmUpdate = confirm("수정하시겠습니까?");
               
               if (confirmUpdate) {
                   var editedReviewContent = $(editHtmlTemplate).find(".card-text").val();

                   $.ajax({
                       url: "http://localhost:8080/rest/review/list/editReview?reviewNo=" + reviewNo,
                       method: "post",
                       data: {
                           reviewNo: reviewNo,
                           reviewContent: editedReviewContent,
                           movieNo: movieNo
                       },
                       success: function (response) {
                           loadReviewLike(movieNo);

                           reviewContainer.show();
                           $(editHtmlTemplate).remove();
                           location.reload();
                       }
                   });
               }
         });

         reviewContainer.hide().after(editHtmlTemplate);
      });
      
   });
</script>

<script>
    function confirmDelete(reviewNo) {
      var params = new URLSearchParams(location.search);
       var movieNo = params.get("movieNo");
        var confirmDelete = confirm("삭제하시겠습니까?");
        if (confirmDelete) {
            // 사용자가 확인하면, deleteReview URL로 리다이렉트
            window.location.href = "/movie/deleteReview?reviewNo=" + reviewNo + "&movieNo=" + movieNo;
        }
    }
</script>

<script id="reply-template" type="text/template">
		<hr>
		<div class="row">
			<div class="col-8 offset-2">
				<div class="row">
					<div class="col-3">
						<span class="memberNickname nicknameFont"></span>
					</div>
					<div class="col-6">
						<span class="replyDate" style="font-size: 18px;"></span>
					</div>
					<div class="col-3 d-flex justify-content-end">
						<i class="fa-solid fa-x deleteReply" style="position: relative; top: 10px; right: 20px;"></i>
					</div>
				</div>
			</div>
			<div class="row mt-3">
				<div class="col-8 offset-2">
					<span class="replyContent"></span>
				</div>
			</div>
		</div>
		<hr>
    
</script>
<script id="review-edit-template" type="text/template">
   <div class="card mt-3 edit-container">
      <div class="card-body">
         <div>
            <img class="userImage img-thumbnail">
            <span class="card-title ms-3" style="font-weight: bold; font-size: 20px;">${review.memberNickname}</span>
            <i class="fa-solid fa-star"></i><span>${review.ratingScore}</span>
         </div>
            <div class="mt-3 pb-3 review-edit-form">
               <textarea class="card-text" style="width: 100%; height: 100px; resize: none;"></textarea>
            </div>
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
               <button class="btn btn-danger btn-cancel">취소</button>
               <button class="btn btn-success">전송</button>
         <form>
      </div>
   </div>
</script>

<body>
   <div class="container-fluid">
      <div class="row">
         <div class="col-md-10 offset-md-1 mb-5 mt-5">

				<!-- 영화 상세로 이동 -->
				<div class="row">
					<div class="col-3">
						<a href="/movie/detail?movieNo=${movieSimpleInfo.movieNo}">
							<button type="button" class="btn btn-link">
								<i class="fa-solid fa-angle-left"></i>영화 상세
							</button>
						</a>
					</div>
				</div>
				
				<!-- 리뷰 목록으로 이동 -->	
				<div class="row">
					<div class="col-3">
						<a href="list?movieNo=${review.movieNo}">
							<button type="button" class="btn btn-link">
								<i class="fa-solid fa-angle-left"></i>리뷰 목록
							</button>
						</a>
					</div>
				</div>
	
				<!-- 영화 정보 -->
				<div class="row justify-content-center align-items-center">
			        <div class="col-lg-3 col-md-10 col-sm-10 text-center">
			            <img src="/rest/image/movieMain/${movieNo}" style="width: 250px; height: 350px">
			        </div>
			        <div class="col-lg-6 col-md-10 col-sm-10 text-center">
			            <div class="row">
			                <h2 class="mt-5 pt-4">${movieSimpleInfo.movieName}</h2>
			            </div>
			            <div class="row mt-5">
			                <span>${movieSimpleInfo.movieReleaseYear} • ${movieSimpleInfo.genreName} • ${movieSimpleInfo.movieNation}</span>
			            </div>
			            <div class="row">
			                <span>${movieSimpleInfo.movieTime}분 • ${movieSimpleInfo.movieLevel}</span>
			            </div>
			        </div>
			    </div>
			
				<!-- 리뷰 정보 -->
				<div class="card mt-5 view-container">
					<div class="card-body">
						<div>
							<img src="/rest/image/${review.imageNo}" class="userImage">
							<span class="card-title ms-3" style="font-weight: bold; font-size: 20px;">${review.memberNickname}</span>
							<i class="fa-solid fa-star"></i><span>${review.ratingScore}</span>
							
								<!-- 작성자일 경우에만 아이콘 표시 -->
								<c:if test="${memberNickname == review.memberNickname}">
									<i class="fa-solid fa-pen-to-square fa-lg editReview" style="position: absolute; top: 30px; right: 50px;"></i>
									<a href="javascript:void(0);" onclick="confirmDelete(${review.reviewNo});">
    									<i class="fa-solid fa-x fa-lg deleteReview" style="position: absolute; top: 30px; right: 30px;"></i>
									</a>
								</c:if>
								
						</div>
						<div class="mt-3 pb-3">
							<span class="card-text">${review.reviewContent}</span>
						</div>
						<hr>
						<div class="row text-center">
							<div class="col">
								<button type="button" class="btn btn-link likeButton" data-reviewNo="${review.reviewNo}">
									<i class="fa-regular fa-thumbs-up"><span class="reviewLikeCount"> ${review.reviewLikeCount}</span></i>
								</button>
							</div>
							<div class="col">
								<button type="button" class="btn btn-link">
									<i class="fa-regular fa-comment"><span class="reviewReplyCount"> ${review.reviewReplyCount}</span></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 댓글 작성 란 -->
				<div class="container-fluid mt-5">
                    <div class="row">
                        <div class="col-md-8 offset-md-2">
                            <textarea name="replyContent" style="width: 100%; height: 100px; resize: none;"></textarea>
                        </div>
                        <div class="col-sm-8 offset-sm-2 col-md-8 col-md-2 col-lg-8 offset-lg-2 ">
                            <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-success">전송</button>
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