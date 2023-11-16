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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieGenreDao;
import com.kh.movie.dto.MovieGenreDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "영화장르 관리", description = "영화장르 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/movieGenre")
public class MovieGenreRestController {
	
	@Autowired
	private MovieGenreDao movieGenreDao;
	
	//전체 조회
	@GetMapping("/") 
	public List<MovieGenreDto> list() {
		return movieGenreDao.selectList();
	}
	
	//등록
	@PostMapping("/") 
	public void insert(@RequestBody MovieGenreDto movieGenreDto) {
		movieGenreDao.insert(movieGenreDto);
	}
	
	//삭제
	@DeleteMapping("/movieNo/{movieNo}/genreName/{genreName}") 
	public ResponseEntity<String> delete(@PathVariable int movieNo, @PathVariable String genreName) {
		boolean result = movieGenreDao.delete(movieNo, genreName);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	//영화번호로 리스트 조회
	@GetMapping("/movieNo/{movieNo}")
	public ResponseEntity<List<MovieGenreDto>> findByMovieNo(@PathVariable int movieNo){
		List<MovieGenreDto> list = movieGenreDao.selectListByMovieNo(movieNo);
		if(list != null) return ResponseEntity.ok().body(list);
		else return ResponseEntity.notFound().build();
	}
	
	//수정
	@PatchMapping("/movieNo/{movieNo}/genreName/{genreName}")
	public ResponseEntity<String> editUnit(@PathVariable int movieNo, 
															@PathVariable String genreName,
															@RequestBody MovieGenreDto movieGenreDto){
		if(movieGenreDto.isEmpty()) {
			return ResponseEntity.badRequest().build();
		}
		boolean result = movieGenreDao.editUnit(movieNo, genreName, movieGenreDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
}	
