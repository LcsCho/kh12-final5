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

document.addEventListener("DOMContentLoaded", function() {
    // 최대 5개의 체크박스만 선택되도록 제한
    const checkboxes = document.querySelectorAll('.check-item');
    let checkedCount = 0;

    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
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
    });

    // "건너뛰기" 버튼을 클릭했을 때 확인 메시지 및 처리
    const skipButton = document.querySelector('button[type="button"]');
    skipButton.addEventListener('click', function() {
        const confirmation = confirm("건너 뛸 시, 선호장르 맞춤 정보는 받을 수 없습니다. 건너뛰시겠습니까?");
        if (confirmation) {
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = false;
            });
            alert("건너뛰기가 완료되었습니다.");
        }
    });
});

</script>

<script>

// 선택완료 버튼 클릭 시 데이터 전송하는 코드
$(".btn.btn-save").click(function() {
    // 선택된 선호 장르 가져오기
    var  selectedGenres = [];
    $(".check-item:checked").each(function() {
        selectedGenres.push($(this).val());
    });

    // 회원 닉네임 가져오기 (예시: 서버에서 세션을 통해 제공되는 회원 닉네임 사용)
    var memberNickname = getMemberNickname();

    // 서버로 데이터 전송
    $.ajax({
        url: "http://localhost:8080/preferGenre/",
        method: "post",
        data: {
            memberNickname : memberNickname,
            genreName: selectedGenres
        },
        success: function(response) {
            console.log("데이터가 성공적으로 저장되었습니다.");
        },
        error: function(error) {
            console.error("데이터 저장 중 오류가 발생했습니다.", error);
        }
    });
});

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
            <input type="checkbox" class="check-item"> 코미디
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 로맨스 코미디
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 추리 / 미스터리
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 액션
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> SF
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 판타지
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 애니메이션
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 범죄 / 공포 / 스릴러
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 음악 / 뮤지컬
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 드라마 / 다큐멘터리
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 전쟁
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 사극
        </div>
	<div class="row left">
            <input type="checkbox" class="check-item"> 스포츠
        </div>
	
	<div class="row pt-30 mt-20">
		<button type="submit" class=" btn btn-save">선택완료</button>
	</div>
	
	<!-- 건너뛰기 누르면 자동으로 null값 - 안내 팝업 띄우기 -->
	<div class="row pt-30 mt-10">
		<button type="button">건너뛰기 ></button>
		</div>
</div>