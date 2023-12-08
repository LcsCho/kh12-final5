<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<style>
h3, pre {
	font-family: sans-serif;
}
.footerTop {
    background-color: rgb(179, 57, 57, 0.9);
    color: #fff;
    padding: 5px 5px;
}
.footerBottom {
    background-color: rgb(179, 57, 57, 0.6);
    color: #fff;
}
</style>

</section>
                    <footer class="mt-5">
                <div class="container-fluid">
                    <div class="row text-center">
                        <div class="col footerTop">
                            <h3 style="color: #fff">지금까지 <span style="font-weight: bold;"> ${sessionScope.ratingCount} </span>개의 평가가 쌓였어요</h3>
                        </div>
                    </div>
                    <div class="row footerBottom pt-3">
                        <div class="col">
                            <pre>서비스 이용약관｜개인정보 처리방침 | 회사 안내

고객센터 | https://www.kh-academy.co.kr/main/main.kh, 1544-9970
광고 문의 | KHacademy@kh.com

주식회사 엠브이씨 | 대표 나사장 | 서울특별시 영등포구 선유동 2로 57 이레빌딩 19층 C강의장
사업자 등록 번호 123-45-678

<img src="${pageContext.request.contextPath}/images/MVClogo.png" width="60">@2023 by MVC, Inc. All rights reserved.</pre>
                        </div>
                    </div>
                </div>
            </footer>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>