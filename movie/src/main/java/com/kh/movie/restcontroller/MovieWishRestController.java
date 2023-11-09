package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieWishDao;
import com.kh.movie.dto.MovieWishDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "영화찜 관리", description = "영화찜 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/movieWish")
public class MovieWishRestController {
	
	@Autowired
	private MovieWishDao movieWishDao;
	
	@GetMapping("/")
	public List<MovieWishDto> list() {
		return movieWishDao.selectList();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody MovieWishDto movieWishDto) {
		movieWishDao.insert(movieWishDto);
	}
	
	@DeleteMapping("/{wishNo}")
	public ResponseEntity<String> delete(@PathVariable int wishNo) {
		boolean result = movieWishDao.delete(wishNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	@GetMapping("/{wishNo}")
	public ResponseEntity<MovieWishDto> findByWishNo(@PathVariable int wishNo) {
		MovieWishDto movieWishDto = movieWishDao.selectOne(wishNo);
		if(movieWishDto != null) 	return ResponseEntity.ok().body(movieWishDto);
		else return ResponseEntity.notFound().build();
	}
}
