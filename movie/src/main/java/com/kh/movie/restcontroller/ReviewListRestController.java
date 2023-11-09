package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.ReviewListDao;
import com.kh.movie.vo.ReviewListVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/review/list")
public class ReviewListRestController {
	
	@Autowired
	private ReviewListDao reviewListDao;
	
	//최신순 조회
	@PostMapping("/findByDateDesc")
	public List<ReviewListVO> findByDateDesc() {
		return reviewListDao.findByDateDesc();
	}
	
	//오래된순 조회
	@PostMapping("/findByDateAsc")
	public List<ReviewListVO> findByDateAsc() {
		return reviewListDao.findByDateAsc();
	}
	
	//좋아요순 조회
	@PostMapping("/findByLikeDesc")
	public List<ReviewListVO> findByLikeDesc() {
		return reviewListDao.findByLikeDesc();
	}
	
	//평점높은순
	@PostMapping("/findByRatingDesc")
	public List<ReviewListVO> findByRatingDesc() {
		return reviewListDao.findByRatingDesc();
	}
	
	//평점낮은순
	@PostMapping("/findByRatingAsc")
	public List<ReviewListVO> findByRatingAsc() {
		return reviewListDao.findByRatingAsc();
	}
}
