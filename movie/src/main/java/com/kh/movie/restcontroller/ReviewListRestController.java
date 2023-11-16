package com.kh.movie.restcontroller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dao.ReviewLikeDao;
import com.kh.movie.dto.ReviewLikeDto;
import com.kh.movie.vo.ReviewLikeVO;
import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
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
			
//		//좋아요 설정
//		@PostMapping("/likeAction")
//		public ReviewLikeVO likeAction(@RequestParam int reviewNo, HttpSession session,
//																		@ModelAttribute ReviewLikeDto reviewLikeDto){
//			//memberId로 memberNickname 가져오기
//			String memberId = (String) session.getAttribute("name");
//			String memberNickname = memberDao.findNicknameById(memberId);
//			
//			String check = reviewLikeDao.findReviewLike(reviewNo, memberNickname);
//			if(check == "Y") {
//				reviewLikeDao.delete(reviewLikeDto);//좋아요 해제
//			}else {
//				reviewLikeDao.insert(reviewLikeDto);//좋아요 설정
//			}
//			
//			int count = reviewDao.findReviewLikeCount(reviewNo);
//			String isCheck = reviewLikeDao.findReviewLike(reviewNo, memberNickname);
//			
//			ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
//			reviewLikeVO.setCheck(isCheck);
//			reviewLikeVO.setCount(count);
//			
//			return reviewLikeVO;
//		}
	
	//좋아요 조회(좋아요 체크 여부, 좋아요 개수)
	@PostMapping("/findReviewLike")
	public List<ReviewLikeVO> findReviewLike(@RequestParam int movieNo, HttpSession session){
	    // memberId로 memberNickname 가져오기
	    String memberId = (String) session.getAttribute("name");
	    String memberNickname = memberDao.findNicknameById(memberId);

	    // 영화에 달린 리뷰 번호 가져오기
	    List<ReviewListVO> reviewNos = reviewDao.findReviewNoByMovie(movieNo);
	    log.debug("reviewNos = {}", reviewNos);//29,31

	    List<ReviewLikeVO> reviewLikeVOList = new ArrayList<>();
	    log.debug("reviewLikeVOList = {}", reviewLikeVOList);

	    return reviewLikeVOList;
	}
}
