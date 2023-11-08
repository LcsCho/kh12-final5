package com.kh.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.ReviewListDao;
import com.kh.movie.vo.ReviewListVO;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private ReviewListDao reviewListDao;

	
	
	
	@GetMapping("/review/list")
	public String reviewList(Model model) {
		List<ReviewListVO> reviewList = reviewListDao.findByDateDesc();
		model.addAttribute("reviewList", reviewList);
		return "reviewList";
	}
}
