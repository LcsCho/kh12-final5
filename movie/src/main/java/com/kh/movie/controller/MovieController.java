package com.kh.movie.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.MovieGenreDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dao.ReplyDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.dto.MovieGenreDto;
import com.kh.movie.dto.MovieSimpleInfoDto;
import com.kh.movie.dto.RatingDto;
import com.kh.movie.dto.ReplyDto;
import com.kh.movie.dto.ReviewDto;
import com.kh.movie.vo.ActorDetailVO;
import com.kh.movie.vo.MovieDetailVO;
import com.kh.movie.vo.MovieListVO;
import com.kh.movie.vo.MovieRatingAvgVO;
import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private MovieDao movieDao;
	
	@Autowired
	private MovieGenreDao movieGenreDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//리뷰 목록
	@GetMapping("/review/list")
	public String reviewList(@RequestParam int movieNo, Model model) {
		int ratingCount = ratingDao.getCount();
		model.addAttribute("ratingCount", ratingCount);
		
		//리뷰 목록 조회
		model.addAttribute("movieNo", movieNo);
		
		
	    
	    //영화 정보 조회
		List<MovieSimpleInfoDto> movieSimpleInfoList = reviewDao.findAll(movieNo);
	    if (!movieSimpleInfoList.isEmpty()) {
	        model.addAttribute("movieSimpleInfo", movieSimpleInfoList.get(0));
	    }
		
	    return "movie/review/list";
	}
	
	//리뷰 목록(+댓글)
	@GetMapping("/review/detail")
	public String reviewDetail(@RequestParam int movieNo,
												@RequestParam int reviewNo, Model model) {
		int ratingCount = ratingDao.getCount();
		model.addAttribute("ratingCount", ratingCount);
		
		//영화 정보 조회
		List<MovieSimpleInfoDto> movieSimpleInfoList = reviewDao.findAll(movieNo);
	    if (!movieSimpleInfoList.isEmpty()) {
	        model.addAttribute("movieSimpleInfo", movieSimpleInfoList.get(0));
	    }
	    
	    //리뷰 상세 조회
		ReviewListVO reviewListVO = reviewDao.findByReviewNo(reviewNo);
		if (reviewListVO != null) {
		    model.addAttribute("review", reviewListVO);
		}
		
		//댓글 조회
		List<ReplyDto> replyList = replyDao.findAll(reviewNo);
		if (!replyList.isEmpty()) {
			model.addAttribute("reply", replyList.get(0));
		}
	    
	    return "movie/review/detail";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int movieNo, HttpSession session, Model model) {
		MovieDto movieDto = movieDao.findByMovieNo(movieNo);
//		String memberId = (String) session.getAttribute("name");
		List<MovieGenreDto> movieGenreList = movieGenreDao.selectListByMovieNo(movieNo);
		List<ReviewDto> reviewList = reviewDao.selectList(movieNo);
		List<MovieListVO> movieList = movieDao.findAllMovieList();
		int ratingCount = ratingDao.getCount();
		
		// 영화의 평점 평균을 구하는 코드
		if (ratingDao.getRatingAvg(movieNo) != null) {
			MovieRatingAvgVO movieRatingVO = ratingDao.getRatingAvg(movieNo);
			float ratingAvg = movieRatingVO.getRatingAvg();
			model.addAttribute("ratingAvg", ratingAvg);
		}
		
		// 영화의 포스터와 갤러리를 구하는 코드
		if (movieDao.getImgs(movieNo) != null) {
			List<MovieDetailVO> movieDetailList = movieDao.getImgs(movieNo);
			int mainImgNo = 0;
			for (MovieDetailVO movieDetail : movieDetailList) {
				mainImgNo = movieDetail.getMainImgNo();
			}
			model.addAttribute("mainImgNo", mainImgNo);
			model.addAttribute("movieDetailList", movieDetailList);
		}
		
		// 영화번호의 배우를 구하는 코드
		if (movieDao.getActor(movieNo) != null) {
			List<ActorDetailVO> actorDetailList = movieDao.getActor(movieNo);
			model.addAttribute("actorDetailList", actorDetailList);
		}
		// model
		model.addAttribute("movieDto", movieDto);
		model.addAttribute("movieGenreList", movieGenreList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("movieList", movieList);
		model.addAttribute("ratingCount", ratingCount);
		return "movie/detail";
	}
	
	//리뷰 상세 페이지에서 리뷰(+평점) 삭제
	@RequestMapping("/deleteReview")
	public String deleteReview(@RequestParam int reviewNo) {
		ReviewListVO reviewListVO = reviewDao.findByReviewNo(reviewNo);
		int movieNo = reviewListVO.getMovieNo();
		boolean result = reviewDao.delete(reviewNo);
		if(result) {
			return "redirect:review/list?movieNo=" + movieNo;
		}else {
			return "redirect:에러페이지";
		}
	}
}
