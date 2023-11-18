package com.kh.movie.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.RatingDao;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "평점 관리", description = "평점 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rating")
public class RatingRestController {
	
	@Autowired
	private RatingDao ratingDao;
	
	@GetMapping("/ratingCount")
	public int count() {
		return ratingDao.getCount();
	}
	
	
}
