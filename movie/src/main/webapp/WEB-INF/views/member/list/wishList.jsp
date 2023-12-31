<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>

    	var isFirstLoad = true;        

    $(document).ready(function () {
	
        // AJAX 요청 완료 후에 영화 목록을 가져와서 표시
        loadMovieList();
        // 클릭 이벤트를 추가
        $('.fa-gear').on('click', function () {
            // 아이콘을 토글하여 보이기/숨기기
            $('.fa-circle-xmark').toggle();
        });

        // 이벤트 핸들러 추가
        $('#movies-container').on('click', '.fa-circle-xmark', function () {
            // 확인 대화 상자 표시
            var result = confirm("정말로 해당 영화에 대한 찜을 삭제하시겠습니까?");
            var movieNo = $(this).attr('data-movieNo');
//             console.log('movieNo:', movieNo);

            // 확인을 선택한 경우
            if (result) {
                deleteMovie(movieNo);
            }
        });
        
    });

    function loadMovieList() {
        $.ajax({
            url: '${pageContext.request.contextPath}/rest/member/wishList',
            method: 'GET',
            success: function (data) {
                var moviesContainer = $('#movies-container');
                moviesContainer.empty();

                $.each(data, function (index, movieVO) {
                    var formattedDate = new Date(movieVO.movieReleaseDate).getFullYear();
                    var movieNo = parseInt(movieVO.movieNo);
                    var imageNo = parseInt(movieVO.imageNo);

                    var movieHtml = '<div class="col-sm-6 col-md-4 col-lg-3" style="width: 250px;">' +
                    '<div style="position: relative;">' +
                    '<a href="${pageContext.request.contextPath}/movie/detail?movieNo=' + movieNo + '" style="display: inline-block; position: relative;">' +
                    '<div style="position: relative;">' +
                    '<img src="${pageContext.request.contextPath}/rest/image/' + imageNo + '" class="img-thumbnail" style="width: 215px; height: 300px;">' +
                    '</div>' +
                    '</a>' +
                    
                    // 새로운 div 태그로 fa-circle-xmark 아이콘을 감싸기
				    '<div class="xmark-container">' +
				        '<i class="fa-regular fa-circle-xmark fa-xl" style="position: absolute; top: 20px; right: 20px; color: black;" data-movieNo="' + movieNo + '"></i>' +
				    '</div>' +
                    '<div class="col">' +
                        '<a href="${pageContext.request.contextPath}/movie/detail?movieNo=' + movieNo + '">' +
                            movieVO.movieName +
                        '</a>' +
                    '</div>' +
                    '<div class="col">' +
                        formattedDate + ' / ' + movieVO.movieNation +
                    '</div>';

                // 조건부로 HTML을 추가
                if (movieVO.ratingAvg != 0) {
                    movieHtml += '<div class="col">' +
                        '평균 <i class="fa-solid fa-star"></i> ' + movieVO.ratingAvg + '점' +
                    '</div>';
                }

                movieHtml += '</div>';

                    moviesContainer.append(movieHtml);
                 
                //처음 로드 시에만 실행
                if(isFirstLoad){
                 // 각각의 xmark를 숨김
                    $('.fa-circle-xmark').hide();
                }
                });
				  isFirstLoad = false;//초기화 상태 변경        
            },
            error: function (error) {
                // 에러 처리
                console.error('데이터 가져오기 오류:', error);
            }
        });
             	
    }

    function deleteMovie(movieNo) {
        $.ajax({
            url: '${pageContext.request.contextPath}/rest/member/wishDelete',
            method: 'delete',
            data: { movieNo: movieNo },
            success: function (response) {
                // 삭제 성공 시에 추가적인 처리를 수행할 수 있습니다.
                console.log('영화 삭제 성공:', response);

                // 삭제 성공 후에 영화 목록을 다시 로드
                loadMovieList();
            },
            error: function (error) {
                // 에러 처리
                console.error('영화 삭제 오류:', error);
            }
        });
    }
</script>
<style>
h3 {
	color: rgb(179, 57, 57);
}

.fa-gear, 
.fa-circle-xmark {
    cursor: pointer;
}
</style>

<!-- swiper cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<div class="container-fluid">
    <!-- 전체 페이지 폭 관리 -->
    <div class="row">
        <div class="col-md-10 offset-md-1">
			<div class="row mt-5 p-3">
				<div class="col d-flex justify-content-between align-items-center">
					<h3 class="mb-0">찜 목록</h3>
					<i class="fa-solid fa-gear fa-2xl"></i>
				</div>
			</div>
            <div class="row" id="movies-container">
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>