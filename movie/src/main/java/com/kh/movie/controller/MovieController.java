package com.kh.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
	//리뷰 목록
	@GetMapping("/review/list")
	public String reviewList() {
		return "movie/review/list";
	}

}
