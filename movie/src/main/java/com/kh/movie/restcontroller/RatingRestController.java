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
import com.kh.movie.dto.RatingDto;

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
	//등록
	@PostMapping("/")
	public void insert(@RequestBody RatingDto ratingDto, @RequestParam int movieNo, HttpSession session) {
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
		boolean result = ratingDao.delete(ratingNo);
		if(result) {
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
