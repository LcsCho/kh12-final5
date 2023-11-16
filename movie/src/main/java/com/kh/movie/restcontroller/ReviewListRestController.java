package com.kh.movie.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dao.ReviewLikeDao;
import com.kh.movie.dto.ReviewLikeDto;
import com.kh.movie.vo.ReviewLikeVO;
import com.kh.movie.vo.ReviewListVO;

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
	
	//좋아요 여부
//	@RequestMapping("/like/check")
//	public ReviewLikeVO likeCount(@ModelAttribute ReviewLikeDto reviewLikeDto, HttpSession session, int movieNo) {
//	    String memberId = (String)session.getAttribute("name");
//	    
//	    //회원 아이디로 회원 닉네임을 찾은 후 Dto에 저장
//		String memberNickname = memberDao.findNicknameById(memberId);
//		reviewLikeDto.setMemberNickname(memberNickname);
//		
//		//영화 번호로 리뷰 번호를 찾아 Dto에 저장
//		int reviewNo = reviewDao.findReviewNoByMovie(movieNo);
//		reviewLikeDto.setReviewNo(reviewNo);
//	    
//	    
//	    //좋아요 여부 확인, 좋아요 갯수 확인
//	    boolean isCheck = reviewLikeDao.check(reviewLikeDto);
//	    int count = reviewLikeDao.count(reviewLikeDto.getReviewNo());
//	    
//	    ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
//	    reviewLikeVO.setCheck(isCheck);
//	    reviewLikeVO.setCount(count);
//	    
//	    return reviewLikeVO;
//	}
	
	//좋아요
//	@RequestMapping("/like/action")
//	public ReviewLikeVO likeAction(@ModelAttribute ReviewLikeDto reviewLikeDto, HttpSession session, int movieNo) {
//		String memberId = (String)session.getAttribute("name");
//	    
//	    //회원 아이디로 회원 닉네임을 찾은 후 Dto에 저장
//		String memberNickname = memberDao.findNicknameById(memberId);
//	    reviewLikeDto.setMemberNickname(memberNickname);
//	    
//	    //영화 번호로 리뷰 번호를 찾아 Dto에 저장
//	    int reviewNo = reviewDao.findReviewNoByMovie(movieNo);
//	    reviewLikeDto.setReviewNo(reviewNo);
//	    
//	    boolean isCheck = reviewLikeDao.check(reviewLikeDto);
//	    if(isCheck) {//좋아요가 되어 있다면
//	    	reviewLikeDao.delete(reviewLikeDto);//체크해제
//	    }else {//아니라면
//	    	reviewLikeDao.insert(reviewLikeDto);//체크
//	    }
//	    int count = reviewLikeDao.count(reviewLikeDto.getReviewNo());
//	    
//	    ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
//	    reviewLikeVO.setCheck(isCheck);
//	    reviewLikeVO.setCount(count);
//	    
//	    return reviewLikeVO;
//	}
}
