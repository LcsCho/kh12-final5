package com.kh.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.ReviewListDao;
import com.kh.movie.vo.ReviewListVO;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private ReviewListDao reviewListDao;
	
	//리뷰 목록
	@RequestMapping("/review/list")
	public String reviewList(@RequestParam int movieNo, Model model) {
		ReviewListVO reviewListVO = (ReviewListVO) reviewListDao.findByDateDesc(movieNo);
		model.addAttribute("review", reviewListVO);
		return "movie/review/list?movieNo=" + movieNo;
	}

}
