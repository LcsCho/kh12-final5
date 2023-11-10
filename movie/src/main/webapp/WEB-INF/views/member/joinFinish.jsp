<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 	 <!--css 파일을 불러오는 코드-->
 
 	 <!-- 내가 만든 css 파일 -->
     <link rel="stylesheet" type="text/css" href="./css/reset.css">
     <link rel="stylesheet" type="text/css" href="./css/commons.css">
     <!-- <link rel="stylesheet" type="text/css" href="./css/test.css"> -->

<style>

</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>

$(document).ready(function () {
    // 최대 5개의 체크박스만 선택되도록 제한
    const checkboxes = $('.check-item');
    let checkedCount = 0;

    checkboxes.change(function () {
      if (this.checked) {
        checkedCount += 1;
        if (checkedCount > 5) {
          this.checked = false;
          checkedCount -= 1;
          alert('최대 5개까지만 선택할 수 있습니다.');
        }
      } else {
        checkedCount -= 1;
      }
    });

    // "건너뛰기" 버튼을 클릭했을 때 확인 메시지 및 처리
    const skipButton = $('button[type="button"]');
    skipButton.click(function () {
      const confirmation = confirm("건너 뛸 시, 선호장르 맞춤 정보는 받을 수 없습니다. 건너뛰시겠습니까?");
      if (confirmation) {
        checkboxes.prop('checked', false);
        alert("건너뛰기가 완료되었습니다.");
      }
    });
  });

</script>

<script>

<script>
$(document).ready(function () {
  // ... (앞서 작성한 코드는 그대로 유지)

  // "선택완료" 버튼을 클릭했을 때 서버로 데이터 전송
  const submitButton = $('.btn-save');
  submitButton.click(function () {
    // 선택된 장르 가져오기
    const selectedGenres = [];
    $('.check-item:checked').each(function () {
      selectedGenres.push($(this).val());
    });

    // AJAX를 사용하여 서버로 데이터 전송
    $.ajax({
      type: 'POST',
      url: '/preferGenre/save', // PreferGenreController의 엔드포인트 URL
      contentType: 'application/json', // 전송하는 데이터의 형식
      data: {
    	  memberNickname : memberNickname
    	  genreName: selectedGenres
    	  }, // 전송할 데이터
      success: function (response) {
        // 성공 시 처리
        alert('선택한 장르가 저장되었습니다.');
      },
      error: function (error) {
        // 오류 시 처리
        console.error('에러 발생:', error);
      },
    });
  });
});
</script>


</script>


          
<div class="container w-600">
	<div class="row pt-20">
		<h2>회원가입 완료</h2>
	</div>
	
	<div class="row pt-20">
		<h3>선호장르 선택 후<br>
		 맞춤 정보를 받아보세요!</h3>
	</div>
	
	<!-- 장르 체크박스 (최대 5개만 가능) -->
	<div class="row left">
           <c:forEach var="genreDto" items="${list}" varStatus="status">
       		<input type="checkbox" class="check-item" value="${genreDto.genreName}">${genreDto.genreName} <br>
          </c:forEach>
        </div>
	
	<div class="row pt-30 mt-20">
		<button type="submit" class=" btn btn-save">선택완료</button>
	</div>
	
	<!-- 건너뛰기 누르면 자동으로 null값 - 안내 팝업 띄우기 -->
	<div class="row pt-30 mt-10">
		<button type="button">건너뛰기 ></button>
		</div>
</div>