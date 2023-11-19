package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.ReplyDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.ReplyDto;
import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	//댓글 조회
	@PostMapping("/findAll")
	public List<ReplyDto> findAll(@RequestParam int reviewNo){
		log.debug("reviewNo = {}", reviewNo);
		return replyDao.findAll(reviewNo);
	}
	
	
	
}
