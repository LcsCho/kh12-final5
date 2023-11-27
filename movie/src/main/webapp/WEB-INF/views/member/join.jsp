<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="/js/join.js"></script>
<style>
.btn-danger{
background-color:#B33939;
}
</style>


<script>
$(function(){
    //처음 로딩아이콘 숨김
    $(".btn-send").find(".fa-spinner").hide();
    $(".cert-wrapper").hide();
    $(".btn-cert").hide();
    $(".btn-memberJoin").prop("disabled", true);//가입버튼 처음에 비활성화

    //인증번호 보내기 버튼을 누르면
    //서버로 비동기 통신을 보내 인증 메일 발송 요청
    $(".btn-send").click(function(){
    	//var email = $("[name=memberId]").val();
    	//console.log("버튼 클릭됨");
        var memberEmail = $("#memberEmail").val();
        if(memberEmail.length == 0){
        	
        	return;
        }

        $(".btn-send").prop("disabled", true);
        $(".btn-send").find(".fa-spinner").show();
        $(".btn-send").find("span").text("발송중");
        $.ajax({
            url:"http://localhost:8080/rest/cert/send",
            method:"post",
            data:{certEmail: memberEmail},
            success:function(){
                $(".btn-send").prop("disabled", false);
                $(".btn-send").find(".fa-spinner").hide();
                $(".cert-wrapper").hide();
                $(".btn-send").find("span").text("재발송");
                 // window.alert("이메일 확인하세요!");

                 $(".cert-wrapper").show();
                 $(".btn-cert").show();
                 window.memberEmail = memberEmail;
             },
          });
        });
					
				
    			
                //확인 버튼을 누르면 이메일과 인증번호를 서버로 전달하여 검사
                $(".btn-cert").click(function () {
                    console.log("버튼클릭");
                    // var email = $("[name=memberEmail]").val();
                    var memberEmail = window.memberEmail;
                    var no = $("#cert-input").val();
                    if (memberEmail.length == 0 || no.length == 0) return;
                    
                    $.ajax({
                        url: "http://localhost:8080/rest/cert/check",
                        method: "post",
                        data: {
                            certEmail: memberEmail,
                            certNo: no
                        },
                        success: function (response) {
                            console.log(response);
                            if (response.result) { //인증성공
                                $("#cert-input").removeClass("is-valid is-invalid")
                                    .addClass("is-valid");
                                $(".btn-cert").prop("disabled", true);
                                //console.log("이메일 인증 완료");

                                // 이메일 인증이 성공하면 인증번호 입력창과 버튼을 숨김
                                $(".btn-send").find("span").text("인증완료!");
                                $(".btn-send").prop("disabled", true);
                                $(".btn-memberJoin").prop("disabled", false);//인증 성공 후 가입버튼 활성화
                                $(".cert-wrapper").hide();
                                $(".btn-cert").hide();
                            }
                            else {
                                $("#cert-input").removeClass("is-valid is-invalid")
                                    .addClass("is-invalid");
                                alert(response.error);
                            }
                        },
                    });
                });
            });

        </script>

        <div class="row my-5 py-5" style="min-height: 400px;">
            <div class="col-md-4 offset-md-4 col-sm-10 offset-sm-1">

                <form class="join-form" action="join" method="post" autocomplete="off">

                    <!-- 제목 -->
                    <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                            <h3 class="text-center">회원 가입</h3>
                            <br>
                            <hr>
                        </div>
                    </div>
					<!-- 아이디 입력창 -->
                    <div class="row">
                        <div class="col-8">
                            <div class="form-floating">
                                <input type="email" id="memberEmail" class="form-control" placeholder=""
                                    name="memberId">
                                <label>아이디(이메일)</label>
                            </div>
                        </div>
                        <div class="col-4 d-flex align-items-center">
                            <button type="button" class="btn-send btn btn-danger btn-lg form-control" style="font-size:14px; height:54px;">
                                <i class="fa-solid fa-spinner fa-spin"></i>
                                <span>인증</span>
                            </button>
                        </div>
                    </div>
					<!-- 인증번호 입력창 -->
                    <div class="row mt-2">
                        <div class="col-8">
                            <div class="form-floating cert-wrapper">
                                <input type="text" id="cert-input" class="form-control" placeholder="">
                                <label>인증번호 6자리</label>
                           </div>
                     </div>
                             <div class="col-4 d-flex align-items-center">
                                <button type="button" class="btn-cert btn btn-danger btn-lg form-control" style="font-size:14px; height:54px;">
                                <span>확인</span>
                            </button>
                           </div>
                            <div class="feedback">
					            <div class="valid-feedback"></div>
					            <div class="invalid-feedback"></div>
        				</div>
                    </div>
				
                    <!-- 비밀번호 입력창-->
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-floating">
                                <input type="password" name="memberPw" class="form-control" placeholder=""
                                    id="memberPassWord">
                                <label>비밀번호
                                </label>
                                <div class="valid-feedback">올바른 형식입니다</div>
                                <div class="invalid-feedback">형식이 올바르지 않습니다</div>
                            </div>
                        </div>
                    </div>


                    <!-- 비밀번호 확인 입력창 -->
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-floating">
                                <input type="password" id="password-check" class="form-control" placeholder="">
                                <label>비밀번호 확인</label>
                                <div class="valid-feedback"></div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <!-- 닉네임 -->
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-floating">
                                <input type="text" class="form-control" placeholder="" name="memberNickname">
                                <label>닉네임
                                </label>
                                <div class="valid-feedback"></div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <!-- 연락처 입력창 -->
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-floating">
                                <input type="text" class="form-control" placeholder="" name="memberContact">
                                <label>연락처</label>
                                <div class="valid-feedback">사용 가능한 전화번호입니다</div>
                                <div class="invalid-feedback">형식이 올바르지 않습니다</div>
                            </div>
                        </div>
                    </div>


                    <!-- 생년월일 입력창 -->
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-floating">
                                <input type="date" name="memberBirth" class="form-control">
                                <label>생년월일</label>
                                <div class="invalid-feedback">잘못된 날짜 형식입니다</div>
                            </div>
                        </div>
                    </div>

                    <!-- 성별 선택 -->
                    <div class="row mt-4">
                        <div class="col">
                            <input type="radio" name="memberGender" value="남자" class="form-radio w-70" checked> 남자
                            <input type="radio" name="memberGender" value="여자" class="form-radio w-70"> 여자
                        </div>
                    </div>


                    <!-- 가입 버튼 -->
                    <div class="row mt-4">
                        <div class="col">
                            <button type="submit" class="btn btn-danger btn-lg btn-memberJoin w-100">
                                회원가입
                            </button>
                        </div>
                    </div>
				</div>

                </form>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>