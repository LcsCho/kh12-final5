package com.kh.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.MovieDao;
import com.kh.movie.dao.RatingDao;
import com.kh.movie.dto.MovieDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	private MovieDao movieDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@RequestMapping("/")
	public String main(Model model) {
		List<MovieDto> movieList = movieDao.selectList();
		model.addAttribute("movieList", movieList);
		int ratingCount = ratingDao.getCount();
		model.addAttribute("ratingCount", ratingCount);
		return "main";
	}

}
