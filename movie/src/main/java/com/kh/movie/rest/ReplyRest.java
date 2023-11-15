package com.kh.movie.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.ReviewDetailDao;
import com.kh.movie.dto.ReplyDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRest {
	
	@Autowired
	private ReviewDetailDao reviewDetailDao;
	
	//댓글 조회
//	@PostMapping("/findAll")
//	public List<ReplyDto> findAll(int reviewNo){
//		return reviewDetailDao.findAll(reviewNo);
//	}
}
