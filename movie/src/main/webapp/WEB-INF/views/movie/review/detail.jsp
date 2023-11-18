<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지(+댓글)</title>
</head>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function(){
		var params = new URLSearchParams(location.search);
	    var reviewNo = params.get("reviewNo");
	    console.log(reviewNo);
	    
	    $.ajax({
	    	url: "http://localhost:8080/rest/reply/findAll?reviewNo=" + reviewNo,
	    	method: "post",
	    	data: {
				reviewNo : reviewNo
	    	},
	    	success: function(response){
	    		console.log(response);
	    		
	    		$(".reply-list").empty();
	    		
	    		for (var i = 0; i < response.length; i++) {
	    			var reply = response[i];
	    			
	    			var template = $("#reply-template").html();
	    			var htmlTemplate = $.parseHTML(template);
	    			
					$(htmlTemplate).find(".memberNickname").text(reply.memberNickname);
					$(htmlTemplate).find(".replyDate").text(reply.replyDate);
					$(htmlTemplate).find(".reviewContent").text(reply.replyContent);
					
					$(".reply-list").append(htmlTemplate);
	    		}
	    	}
	    });
	});
</script>
<script id="reply-template" type="text/template">
		<div><span class="memberNickname"></span></div>
    	<div><span class="replyDate"></span></div>
    	<div><span class="replyContent"></span></div>
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
		닉네임 : ${review.memberNickname} <br>
		평점 : ${review.ratingScore} <br>
		내용 : ${review.reviewContent} <br>
		좋아요 : ${review.reviewLikeCount} <br>
	</div>
	
	<br><br>
	
	<div class="reply-list"></div>
	
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>