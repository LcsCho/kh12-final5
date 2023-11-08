<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록 페이지</title>
</head>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

</script>

<body>

	<button type="button" name="sortType" value="findByDateDesc">최신순</button>
	<button type="button" name="sortType" value="findByDateAsc">오래된순</button>
	<button type="button" name="sortType" value="findByLikeDesc">좋아요순</button>
	<button type="button" name="sortType" value="findByRatingDesc">높은평점순</button>
	<button type="button" name="sortType" value="findByRatingAsc">낮은평점순</button>

	<br>
	<c:forEach items="${reviewList}" var="review">
		사진 : ${review.imageNo} <br>
		닉네임 : ${review.memberNickname} <br>
		평점 : ${review.ratingScore} <br>
		내용 : ${review.reviewContent} <br>
		좋아요 : ${review.reviewLikeCount}
		<hr>
	</c:forEach>
	
</body>
</html>