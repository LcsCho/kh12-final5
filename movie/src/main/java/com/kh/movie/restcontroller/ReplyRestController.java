package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.MovieSimpleInfoDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReviewDao reviewDao;
	
	//댓글 조회
	@PostMapping("/findAll")
	public List<MovieSimpleInfoDto> findAll(int reviewNo){
		return reviewDao.findAll(reviewNo);
	}
}
