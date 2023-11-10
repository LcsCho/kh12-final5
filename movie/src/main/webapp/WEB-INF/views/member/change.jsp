<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <form class="change-form" action="change" method="post"autocomplete="off" >
	    <div class="container w-600" >

            <div class="row left pb-20">
                <h2 >개인 정보 수정</h2>
            </div>
            <hr>

                <div class="row flex-container pt-20">
                    
                    <div class="row w-75 pr-30">
                        <input type="hidden" name="memberId" value="${memberDto.memberId}"
                            class="form-input w-100" readonly>
                    </div>
                </div>
         
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>닉네임</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="text" name="memberNickname" value="${memberDto.memberNickname}" 
                         class="form-input w-100" >
                    </div>
                </div>

                
                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>생년월일</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="date" name="memberBirth" value="${memberDto.memberBirth}"
                        class="form-input w-100">
                    </div>
                </div>

                <div class="row flex-container">
                    <div class="row w-25 left">
                        <label>휴대폰</label>
                    </div>
                    <div class="row w-75 pr-30">
                        <input type="tel" name="memberContact" value="${memberDto.memberContact}"
                                class="form-input w-100">
                    </div>
                </div>
              
                <div class="row float-container right pr-30" >
	                        <button class="btn" type="submit">                         
	                            회원정보수정
	                        </button>
	                       
                </div>
        </div> 
    </form>
    