package com.kh.movie.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.RatingDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.RatingDto;
import com.kh.movie.dto.ReviewDto;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "평점 관리", description = "평점 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rest/rating")
public class RatingRestController {
	
	@Autowired
	private RatingDao ratingDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@GetMapping("/ratingCount")
	public int count() {
		return ratingDao.getCount();
	}
	//등록
	@PostMapping("/{movieNo}")
	public void insert(@RequestBody RatingDto ratingDto, @PathVariable int movieNo, HttpSession session) {
		log.debug("movieNo={}",movieNo);
		String memberId= (String) session.getAttribute("name");
		int ratingNo =ratingDao.sequence();
		ratingDto.setMovieNo(movieNo);
		ratingDto.setMemberId(memberId);
		ratingDto.setRatingNo(ratingNo);
		ratingDao.insert(ratingDto);
	}
	//삭제
	@DeleteMapping("/{ratingNo}")
	public ResponseEntity<String>delete(@PathVariable int ratingNo){
			RatingDto ratingDto = ratingDao.findByRatingNo(ratingNo);
			log.debug("ratingDto={}",ratingDto);
			ReviewDto reviewDto = reviewDao.findReviewByMemberId(ratingDto.getMemberId(), ratingDto.getMovieNo());
			log.debug("reviewDto={}",reviewDto);
		boolean result = ratingDao.delete(ratingNo);
		if(result) {
			if(reviewDto != null) {
				reviewDao.delete(reviewDto.getReviewNo());
				return ResponseEntity.ok().build();
			}
			return ResponseEntity.ok().build();
		}
		else {
			return ResponseEntity.notFound().build();
		}
	}
	//수정
	@PutMapping("/{ratingNo}")
	public ResponseEntity<String> edit(
			@PathVariable int ratingNo,@RequestParam float ratingScore){
		boolean result =ratingDao.update(ratingNo,ratingScore);
		if(result) return ResponseEntity.ok().build();
		else {
			return ResponseEntity.notFound().build();
		}
		
	}
	//상세
	@GetMapping("/{movieNo}")
	public RatingDto find(@PathVariable int movieNo,HttpSession session){
		String memberId=(String) session.getAttribute("name");
		
		return ratingDao.findDtoByMovieNoAndMemberId(movieNo, memberId);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
