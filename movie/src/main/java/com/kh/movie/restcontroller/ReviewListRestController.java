package com.kh.movie.restcontroller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dao.ReviewLikeDao;
import com.kh.movie.dto.ReviewDto;
import com.kh.movie.vo.ReviewLikeVO;
import com.kh.movie.vo.ReviewListVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "리뷰 리스트 관리", description = "리뷰 리스트 관리를 위한 컨트롤러")
@RestController
@RequestMapping("/rest/review/list")
public class ReviewListRestController {
   
   @Autowired
   private ReviewDao reviewDao;
   
   @Autowired
   private ReviewLikeDao reviewLikeDao;
   
   @Autowired
   private MemberDao memberDao;
   
   //최신순 조회
   @PostMapping("/findByDateDesc")
   public List<ReviewListVO> findByDateDesc(int movieNo) {
      return reviewDao.findByDateDesc(movieNo);
   }
   
   //오래된순 조회
   @PostMapping("/findByDateAsc")
   public List<ReviewListVO> findByDateAsc(int movieNo) {
      return reviewDao.findByDateAsc(movieNo);
   }
   
   //좋아요순 조회
   @PostMapping("/findByLikeDesc")
   public List<ReviewListVO> findByLikeDesc(int movieNo) {
      return reviewDao.findByLikeDesc(movieNo);
   }
   
   //평점높은순
   @PostMapping("/findByRatingDesc")
   public List<ReviewListVO> findByRatingDesc(int movieNo) {
      return reviewDao.findByRatingDesc(movieNo);
   }
   
   //평점낮은순
   @PostMapping("/findByRatingAsc")
   public List<ReviewListVO> findByRatingAsc(int movieNo) {
      return reviewDao.findByRatingAsc(movieNo);
   }

   //좋아요 조회(좋아요 체크 여부, 좋아요 개수)
   @PostMapping("/findReviewLike")
   public List<ReviewLikeVO> findReviewLike(@RequestParam int movieNo, HttpSession session){
       // memberId로 memberNickname 가져오기
       String memberId = (String) session.getAttribute("name");
       String memberNickname = memberDao.findNicknameById(memberId);
       
       // 영화에 달린 리뷰 번호 가져오기
       List<ReviewListVO> reviewNos = reviewDao.findReviewNoByMovie(movieNo);
       
       List<ReviewLikeVO> reviewLikeVOList = new ArrayList<>();
          for (ReviewListVO review : reviewNos) {
          int reviewNo = review.getReviewNo();
          String reviewLike = reviewLikeDao.findReviewLike(reviewNo, memberNickname);

          ReviewLikeVO reviewLikeVO = ReviewLikeVO.builder()
                .check(reviewLike)
                .count(reviewDao.findReviewLikeCount(reviewNo))
                .reviewNo(reviewNo)
                .memberNickname(memberNickname)
                .build();

            reviewLikeVOList.add(reviewLikeVO);
        }
       return reviewLikeVOList;
   }
   
   //좋아요 설정/해제
   @PostMapping("/likeAction")
   public ResponseEntity<String> likeAction(@RequestParam int reviewNo, HttpSession session) {
       // memberId로 memberNickname 가져오기
       String memberId = (String) session.getAttribute("name");
       String memberNickname = memberDao.findNicknameById(memberId);
       
       if(memberId != null) {
          String check = reviewLikeDao.findReviewLike(reviewNo, memberNickname);
          int count = reviewDao.findReviewLikeCount(reviewNo);
          
          ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
          
          if ("Y".equals(check)) {
             reviewLikeDao.delete(reviewNo, memberNickname); // 좋아요 해제
             reviewLikeVO.setCheck("N");
             reviewLikeVO.setCount(count - 1);
          } else {
             reviewLikeDao.insert(reviewNo, memberNickname); // 좋아요 설정
             reviewLikeVO.setCheck("Y");
             reviewLikeVO.setCount(count + 1);
          }
          
          reviewLikeVO.setReviewNo(reviewNo);
          reviewLikeVO.setMemberNickname(memberNickname);
          
          return ResponseEntity.ok().build();
       }
       return ResponseEntity.badRequest().body("로그인 후 이용 가능합니다.");
   }
   
   //리뷰 수정
   @PostMapping("/editReview")
   public void edit(@RequestParam int reviewNo, @ModelAttribute ReviewListVO reviewListVO) {
      String reviewContent = reviewListVO.getReviewContent();
      reviewDao.edit(reviewNo, reviewContent);
   }
   
   //리뷰 작성(등록)
   @PostMapping("/writeReview")
   public ResponseEntity<String> write(@RequestParam("movieNo") int movieNo,
                        @RequestParam("reviewContent") String reviewContent,
                        HttpSession session, Model model) {
      String memberId = (String) session.getAttribute("name");
      String memberNickname = memberDao.findNicknameById(memberId);
      ReviewDto findReviewDto = reviewDao.findReviewByMemberId(memberId, movieNo);
      
      if(findReviewDto == null) {
         ReviewDto reviewDto = new ReviewDto();
         int reviewNo = reviewDao.sequence();
         reviewDto.setReviewNo(reviewNo);
         reviewDto.setMovieNo(movieNo);
         reviewDto.setMemberId(memberId);
         reviewDto.setMemberNickname(memberNickname);
         reviewDto.setReviewContent(reviewContent);
         reviewDao.insert(reviewDto);
         return ResponseEntity.ok().build();
      }
      else {
         return ResponseEntity.badRequest().body("이미 리뷰를 작성하셨습니다.");
      }
   }
}