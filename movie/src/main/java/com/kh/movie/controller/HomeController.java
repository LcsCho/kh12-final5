package com.kh.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.RatingDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	private RatingDao ratingDao;
	
	@RequestMapping("/")
	public String main(Model model) {
		int ratingCount = ratingDao.getCount();
		model.addAttribute("ratingCount", ratingCount);
		return "main";
	}

}
