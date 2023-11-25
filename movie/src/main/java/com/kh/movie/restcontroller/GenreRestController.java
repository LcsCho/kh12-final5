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

import com.kh.movie.dao.GenreDao;
import com.kh.movie.dto.GenreDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name ="장르 관리", description = "장르 관리를 위한 컨트롤러")

@CrossOrigin
@RestController
@RequestMapping("/rest/genre")
public class GenreRestController {
	
	@Autowired
	private GenreDao genreDao;
	
	//전체조회
	@GetMapping("/") 
	public List<GenreDto> list(){
		return genreDao.selectList();
	}
	
	//등록
	@PostMapping("/") 
	public void insert(@RequestBody GenreDto genreDto) {
		genreDao.insert(genreDto);
	}
	
	//삭제
	@DeleteMapping("/{genreNo}") 
	public ResponseEntity<String> delete(@PathVariable int genreNo){
		boolean result = genreDao.delete(genreNo);
		if(result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build(); 
	}
	
	//장르번호로 상세 조회
	@GetMapping("/{genreNo}") 
	public ResponseEntity<GenreDto> findByGenreNo(@PathVariable int genreNo) {
		GenreDto genreDto = genreDao.findByGenreNo(genreNo);
		if(genreDto != null) 	return ResponseEntity.ok().body(genreDto);
		else return ResponseEntity.notFound().build();
	}
	
	//전체수정
	@PutMapping("/{genreNo}") 
	public ResponseEntity<String> edit(@PathVariable int genreNo ,
			@RequestBody GenreDto genreDto) {
		boolean result = genreDao.edit(genreNo, genreDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	//개별수정
	@PatchMapping("/{genreNo}") 
	public ResponseEntity<String> editUnit(@PathVariable int genreNo ,
			@RequestBody GenreDto genreDto){
		if(genreDto.isEmpty()) {
			return ResponseEntity.badRequest().build();
		}
		boolean result = genreDao.editUnit(genreNo, genreDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
}
