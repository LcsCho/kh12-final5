<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<style>

    </style>
    
    <!--jquery CDN-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!--javascript 작성 공간-->
    <script>

    </script>

    <form class="join-form" action="join" method="post" autocomplete="off">

        <div class="container w-600 navy">
            <div class="row">
                <h2 >회원가입</h2>
            </div>
            <div class="row right">
                <span><span class="red">*</span>필수입력사항</span>
            </div>
            <hr class="navy">

                <div class="row flex-container">
                
                    <div class="row w-25 left">
                        <label>아이디<span class="red">*</span></label>
                    </div>


                    <div class="row w-75 pr-30 left">
                        <input type="email" name="memberId" placeholder="예: test@kh.com" class="form-input w-70">
   					</div>
   					
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>비밀번호<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberPw" 
                             placeholder="비밀번호를 입력해주세요"
                            class="form-input w-100">
                        <div class="success-feedback left"></div>
                        <div class="fail-feedback left">영문,숫자,특수문자(!@#$) 반드시 1개 이상 포함 8~16자</div>
                    </div>
                </div>
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>비밀번호 확인<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" id="password-check" placeholder="비밀번호 한 번 더 입력해주세요"
                                    class="form-input w-100">
                        <div class="success-feedback"></div>
                        <div class="fail-feedback left">동일한 비밀번호를 입력하세요</div>
                        <div class="fail2-feedback left">비밀번호를 먼저 작성하세요</div>
                    </div>
                </div>
               
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>닉네임<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberNickname" 
                         class="form-input w-100">
                        <div class="success-feedback"></div>
                        <div class="fail-feedback left"></div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="date" name="memberBirth" 
                        class="form-input w-100">
                        <div class="fail-feedback left">잘못된 날짜를 선택하셨습니다</div>
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>휴대폰<span class="red">*</span></label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" placeholder="01012341234(-없이)"
                                class="form-input w-100">
                        <div class="fail-feedback left">휴대폰 번호를 입력해주세요</div>
                    </div>
                </div>
                  <div class="row flex-container">
                
                    <div class="row w-25 left">
                        <label>성별<span class="red">*</span></label>
                    </div>


                    <div class="row w-75 pr-30 left">
                        <input type="text" name="memberGender" class="form-input w-70">
   					</div>
   					
                </div>
              

                <div class="row pt-10">
                    <button type="submit" class="btn btn-orange">가입하기</button>
                </div>

        </div>
    </form>
