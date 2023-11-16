package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.ReviewDao;
import com.kh.movie.vo.AdminReviewListVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "리뷰 관리", description = "리뷰 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/review")
public class ReviewRestController {

	@Autowired
	private ReviewDao reviewDao;
	
	@GetMapping("/adminReviewList")
	public List<AdminReviewListVO> adminReviewList() {
		return reviewDao.selectAdminReviewList();
	}
	
	@DeleteMapping("/{reviewNo}")
	public ResponseEntity<String> deleteByReviewNo(@PathVariable int reviewNo) {
		boolean result = reviewDao.delete(reviewNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
}
