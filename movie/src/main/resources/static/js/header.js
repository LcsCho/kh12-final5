$(function () {
    // 상태 객체
    var status = {
        memberId: false,
        memberPw: false,
        pwCheck: false,
        ok: function () {
            return this.memberId && this.memberPw && this.pwCheck;
        },
    };
    
      // 아이디 검사
    $("#email").blur(function (e) {
        var regex = /^[a-z0-9]+@[a-z]+\.(com|co\.kr|net)$/;
        var isValid = regex.test($(this).val());
        var feedbackWrapper = $(this).closest('.col-3').next().find('.feedback');

        if (isValid) {
            $(e.target).removeClass("is-valid is-invalid").addClass("is-valid");
            feedbackWrapper.find('.valid-feedback').text("이메일이 확인되었습니다").show();
            feedbackWrapper.find('.invalid-feedback').hide();
            status.memberId = true;
        } else {
            $(e.target).removeClass("is-valid is-invalid").addClass("is-invalid");
            feedbackWrapper.find('.invalid-feedback').text("이메일 주소가 올바르지 않습니다").show();
            feedbackWrapper.find('.valid-feedback').hide();
            status.memberId = false;
        }
    });

//
//    // 아이디 검사
//    $("#email").blur(function (e) {
//        var regex = /^[a-z0-9]+@[a-z]+\.(com|co\.kr|net)$/;
//        var isValid = regex.test($(this).val());
//        var feedbackWrapper = $(this).closest('.mb-3').find('.feedback');
//        //var emailButton = $("#emailButton");
//
//        if (isValid) {
//            $.ajax({
//                url: "http://localhost:8080/member/idCheck",
//                method: "post",
//                data: { memberId: $(e.target).val() },
//                success: function (response) {
//                    $(e.target).removeClass("is-valid is-invalid");
//                    if (response == "N") {
//                        $(e.target).addClass("is-valid");
//                        feedbackWrapper.find('.valid-feedback').text("이메일이 확인되었습니다").show();
//                        feedbackWrapper.find('.invalid-feedback').hide();
//                        status.memberId = true;
//                        //emailButton.disabled = false;
//                    } else {
//                        $(e.target).addClass("is-invalid");
//                        feedbackWrapper.find('.invalid-feedback').text("정확하지 않은 이메일입니다").show();
//                        feedbackWrapper.find('.valid-feedback').hide();
//                        status.memberId = false;
//                        //emailButton.disabled = true;
//                    }
//                    	
//                },
//                error: function () {
//                    alert("서버와의 통신이 원활하지 않습니다");
//                }
//            });
//        } else {
//            $(e.target).removeClass("is-valid is-invalid");
//            $(e.target).addClass("is-invalid");
//            feedbackWrapper.find('.invalid-feedback').text("이메일 주소가 올바르지 않습니다").show();
//            feedbackWrapper.find('.valid-feedback').hide();
//            status.memberId = false;
//            
//            
//        }
//    });

    $("[name=newPassword]").blur(function () {
        var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,60}$/;
        var isValid = regex.test($(this).val());
        $(this).removeClass("is-valid is-invalid");
        $(this).addClass(isValid ? "is-valid" : "is-invalid");
        status.memberPw = isValid;

        // 비밀번호 확인창에 강제로 blur 이벤트를 발생시킨다(트리거)
        //$("#confirmPw").blur();
    });

    // 비밀번호 확인 검사
    $("[name=confirmPassword]").blur(function () {
        var originPw = $("[name=newPassword]").val();
        var checkPw = $(this).val();
        
        $(this).removeClass("is-valid is-invalid");
        if (originPw.length === 0) { // 미입력이면
            $(this).addClass("is-invalid").siblings('.invalid-feedback').text("비밀번호를 먼저 작성하세요");
            status.pwCheck = false;
        } else if (originPw === checkPw) { // 일치하면
            $(this).addClass("is-valid").siblings('.valid-feedback').text("비밀번호가 일치합니다");
            status.pwCheck = true;
        } else { // 비밀번호 불일치
            $(this).addClass("is-invalid").siblings('.invalid-feedback').text("비밀번호가 일치하지 않습니다");
            status.pwCheck = false;
        }
    });
});
