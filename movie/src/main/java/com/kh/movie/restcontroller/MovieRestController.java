package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieDao;
import com.kh.movie.dto.MovieDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "영화 관리", description = "영화 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/movie")
public class MovieRestController {
	
	@Autowired
	private MovieDao movieDao;
	
	@GetMapping("/")
	public List<MovieDto> list() {
		return movieDao.selectList();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody MovieDto movieDto) {
		movieDao.insert(movieDto);
	}
	
	@DeleteMapping("/{movieNo}")
	public ResponseEntity<String> delete(@PathVariable int movieNo) {
		boolean result = movieDao.delete(movieNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	@GetMapping("/{movieName}")
	public List<MovieDto> find(@PathVariable String movieName) {
		return movieDao.selectList(movieName);
	}
	
	@PutMapping("/{movieNo}")
	public ResponseEntity<String> edit(@RequestBody MovieDto movieDto, @PathVariable int movieNo) {
		boolean result = movieDao.edit(movieNo, movieDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@PatchMapping("/{movieNo}")
	public ResponseEntity<String> editUnit(@RequestBody MovieDto movieDto, @PathVariable int movieNo) {
		if (movieDto.isEmpty()) return ResponseEntity.badRequest().build();
		boolean result = movieDao.editUnit(movieNo, movieDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
			
	

}
