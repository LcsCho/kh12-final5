package com.kh.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.ReviewListDao;
import com.kh.movie.vo.ReviewListVO;

@Controller
@RequestMapping("/movie")
public class MovieController {
	
	@Autowired
	private ReviewListDao reviewListDao;

	
	
	
	@RequestMapping("/review/list")
	public String reviewList(Model model, 

	                         @RequestParam(value = "sortType", defaultValue = "findByDateDesc") 
	                         String sortType) {
	    List<ReviewListVO> reviewList = reviewListDao.complexSearch(sortType);
	    model.addAttribute("reviewList", reviewList);
	    return "reviewList";

	}

}
