<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지(+댓글)</title>
</head>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function(){
		var params = new URLSearchParams(location.search);
	    var reviewNo = params.get("reviewNo");
	    
	    $.ajax({
	    	url: "http://localhost:8080/rest/reply/findAll?reviewNo=" + reviewNo,
	    	method: "post",
	    	data: {
	    		memberNickname : "reply.memberNickname",
	    		replyDate: "reply.replyDate",
	    		replyContent : "reply.replyContent"
	    	},
	    	success: function(response){
	    		$(".reply-list").empty();
	    		
	    		for (var i = 0; i < response.length; i++) {
	    			var reply = response[i];
	    			
	    			
	    			var replyItem = 
	    				'<div class="reply-item">' +
	    				'<span class="memberNickname">' + reply.memberNickname + '</span><br>' +
	    				'<span class="replyDate">' + reply.replyDate + '</span><br>' +
	    				'<span class="replyContent">' + reply.replyContent + '</span>' + 
	    				'<hr>' +
			           '</div>';
	    			
			    	$(".reply-list").append(replyItem);
	    		}
	    	}
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
		닉네임 : ${review.memberNickname} <br>
		평점 : ${review.ratingScore} <br>
		내용 : ${review.reviewContent} <br>
		좋아요 : ${review.reviewLikeCount} <br>
	</div>
	
	<br><br>
	
	<div class="reply-list"></div>
	
</body>
</html>