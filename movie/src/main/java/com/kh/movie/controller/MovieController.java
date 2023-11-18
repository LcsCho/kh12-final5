package com.kh.movie.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.MovieGenreDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dao.ReplyDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.MovieDto;
import com.kh.movie.dto.MovieGenreDto;
import com.kh.movie.dto.MovieSimpleInfoDto;
import com.kh.movie.dto.ReplyDto;
import com.kh.movie.dto.ReviewDto;
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
	
	//리뷰 목록
	@GetMapping("/review/list")
	public String reviewList(@RequestParam int movieNo, Model model) {
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
		
		//영화 정보 조회
		List<MovieSimpleInfoDto> movieSimpleInfoList = reviewDao.findAll(movieNo);
	    if (!movieSimpleInfoList.isEmpty()) {
	        model.addAttribute("movieSimpleInfo", movieSimpleInfoList.get(0));
	    }
	    
	    //리뷰 상세 조회
		List<ReviewListVO> reviewListVO = reviewDao.findByReviewNo(reviewNo);
		if (reviewListVO != null && !reviewListVO.isEmpty()) {
		    model.addAttribute("review", reviewListVO.get(0));
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
		List<MovieGenreDto> movieGenreList = movieGenreDao.selectListByMovieNo(movieNo);
		List<ReviewDto> reviewList = reviewDao.selectList(movieNo);
		int ratingCount = ratingDao.getCount();
		model.addAttribute("movieDto", movieDto);
		model.addAttribute("movieGenreList", movieGenreList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("ratingCount", ratingCount);
		return "movie/detail";
	}
	

}
