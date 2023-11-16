$(function(){
    //페이지에 버튼이 포함되어 있으므로 DOM 탐색으로 처리
    //[1] 첫페이지만 빼고 다 숨김
     $(".page").hide().first().show();
     $(".btn-prev").first().remove();//이전이 없는 페이지에선 이전버튼 지워라
     $(".btn-next").last().remove();//다음이 없는 페이지에선 다음버튼 지워라

     //[2] 다음버튼을 누르면 버튼이 속한 페이지를 숨기고 뒷페이지 표시
     $(".btn-next").click(function(){
         $(this).parents(".page").hide().next(".page").show();
     });

     //[3] 이전버튼을 누르면 버튼이 속한 페이지를 숨기고 앞페이지를 표시
     $(".btn-prev").click(function(){
         $(this).parents(".page").hide().prev(".page").show();
     });
});