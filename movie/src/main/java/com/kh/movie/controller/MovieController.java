package com.kh.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.ReviewListDao;
import com.kh.movie.dto.MovieSimpleInfoDto;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private ReviewListDao reviewListDao;
	
	//리뷰 목록
	@GetMapping("/review/list")
	public String reviewList(@RequestParam int movieNo, Model model) {
	    //리뷰 목록 조회
		model.addAttribute("movieNo", movieNo);
	    
	    //영화 정보 조회
		List<MovieSimpleInfoDto> movieSimpleInfoList = reviewListDao.findAll(movieNo);
	    if (!movieSimpleInfoList.isEmpty()) {
	        model.addAttribute("movieSimpleInfo", movieSimpleInfoList.get(0));
	    }
		
	    return "movie/review/list";
	}
}
