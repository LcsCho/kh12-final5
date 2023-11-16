package com.kh.movie.rest;

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
import com.kh.movie.dao.ReviewLikeDao;
import com.kh.movie.dao.ReviewListDao;
import com.kh.movie.dto.ReviewLikeDto;
import com.kh.movie.vo.ReviewLikeVO;
import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/review/list")
public class ReviewListRest {
	
	@Autowired
	private ReviewListDao reviewListDao;
	
	@Autowired
	private ReviewLikeDao reviewLikeDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//최신순 조회
	@PostMapping("/findByDateDesc")
	public List<ReviewListVO> findByDateDesc(@RequestParam int movieNo) {
		return reviewListDao.findByDateDesc(movieNo);
	}
	
	//오래된순 조회
	@PostMapping("/findByDateAsc")
	public List<ReviewListVO> findByDateAsc(@RequestParam int movieNo) {
		return reviewListDao.findByDateAsc(movieNo);
	}
	
	//좋아요순 조회
	@PostMapping("/findByLikeDesc")
	public List<ReviewListVO> findByLikeDesc(@RequestParam int movieNo) {
		return reviewListDao.findByLikeDesc(movieNo);
	}
	
	//평점높은순
	@PostMapping("/findByRatingDesc")
	public List<ReviewListVO> findByRatingDesc(@RequestParam int movieNo) {
		return reviewListDao.findByRatingDesc(movieNo);
	}
	
	//평점낮은순
	@PostMapping("/findByRatingAsc")
	public List<ReviewListVO> findByRatingAsc(@RequestParam int movieNo) {
		return reviewListDao.findByRatingAsc(movieNo);
	}
	
	//좋아요 조회(좋아요 체크 여부, 좋아요 개수)
	@PostMapping("/findReviewLike")
	public List<ReviewLikeVO> findReviewLike(@RequestParam int movieNo, HttpSession session){
		//memberId로 memberNickname 가져오기
		String memberId = (String) session.getAttribute("name");
		String memberNickname = memberDao.findNicknameById(memberId);
		
		//영화에 달린 리뷰 번호 가져오기
		List<ReviewListVO> reviewNos = reviewListDao.findReviewNoByMovie(movieNo);
		log.debug("reviewNos = {}", reviewNos);
		log.debug("reviewNos.get(0) = {}", reviewNos.get(0));
		log.debug("reviewNos.get(1) = {}", reviewNos.get(1));
		
		List<ReviewLikeVO> reviewLikeVOList = new ArrayList();
		
		 for (int i=0; i < reviewNos.size(); i++) {
	            ReviewListVO reviewNo = reviewNos.get(i);
	            String reviewLike = reviewLikeDao.findReviewLike(i, memberNickname);
	            
//	            reviewLikeVOList.add(reviewLikeVO);
//	            log.debug("reviewLikeVO ={}",reviewLikeVO);
	        }
//		log.debug("reviewLikeVOList ={}",reviewLikeVOList);
	    return reviewLikeVOList;
	}
	
	//좋아요 설정
	@PostMapping("/likeAction")
	public ReviewLikeVO likeAction(@RequestParam int reviewNo, HttpSession session,
																	@ModelAttribute ReviewLikeDto reviewLikeDto){
		//memberId로 memberNickname 가져오기
		String memberId = (String) session.getAttribute("name");
		String memberNickname = memberDao.findNicknameById(memberId);
		
		String check = reviewLikeDao.findReviewLike(reviewNo, memberNickname);
		if(check == "Y") {
			reviewLikeDao.delete(reviewLikeDto);//좋아요 해제
		}else {
			reviewLikeDao.insert(reviewLikeDto);//좋아요 설정
		}
		
		int count = reviewListDao.findReviewLikeCount(reviewNo);
		String isCheck = reviewLikeDao.findReviewLike(reviewNo, memberNickname);
		
		ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
		reviewLikeVO.setCheck(isCheck);
		reviewLikeVO.setCount(count);
		
		return reviewLikeVO;
	}
	
}
