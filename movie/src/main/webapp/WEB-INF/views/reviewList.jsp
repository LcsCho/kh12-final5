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
function sortReview() {
  // sortType 값 가져오기
  const sortType = document.querySelector("[name='sortType']").value;

  // 리뷰 목록 정렬
  const url = new URL("/review/list/sortBy", window.location);
  url.searchParams.set('sortType', sortType);
  window.location.href = url.toString();
}
</script>

<body>

  <button type="button" name="findByDateDesc" value="findByDateDesc" onclick="sortReview()">최신순</button>
  <button type="button" name="findByDateAsc" value="findByDateAsc" onclick="sortReview()">오래된순</button>
  <button type="button" name="findByLikeDesc" value="findByLikeDesc" onclick="sortReview()">좋아요순</button>
  <button type="button" name="findByRatingDesc" value="findByRatingDesc" onclick="sortReview()">높은평점순</button>
  <button type="button" name="findByRatingAsc" value="findByRatingAsc" onclick="sortReview()">낮은평점순</button>

  <br>

  <c:if test="${reviewList != null}">
    <c:forEach items="${reviewList}" var="review">
      사진 : ${review.imageNo} <br>
      닉네임 : ${review.memberNickname} <br>
      평점 : ${review.ratingScore} <br>
      내용 : ${review.reviewContent} <br>
      좋아요 : ${review.reviewLikeCount}
      <hr>
    </c:forEach>
  </c:if>

</body>
</html>
