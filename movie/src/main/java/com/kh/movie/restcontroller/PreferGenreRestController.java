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

import com.kh.movie.dao.PreferGenreDao;
import com.kh.movie.dto.PreferGenreDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "선호장르 관리", description = "선호장르 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/preferGenre")
public class PreferGenreRestController {
	
	@Autowired
	private PreferGenreDao preferGenreDao;
	
	//전체 조회
	@GetMapping("/")
	public List<PreferGenreDto> list() {
		return preferGenreDao.selectList();
	}
	
	//등록
	@PostMapping("/")
	public void insert(@RequestBody PreferGenreDto preferGenreDto) {
		preferGenreDao.insert(preferGenreDto);
	}
	
	//삭제
	@DeleteMapping("/memberNickname/{memberNickname}/genreName/{genreName}")
	public ResponseEntity<String> delete(@PathVariable String memberNickname, @PathVariable String genreName) {
		boolean result = preferGenreDao.delete(memberNickname, genreName);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	//닉네임으로 리스트 조회
	@GetMapping("/memberNickname/{memberNickname}")
	public ResponseEntity<List<PreferGenreDto>> findByMemberNickname(@PathVariable String memberNickname){
		List<PreferGenreDto> list = preferGenreDao.selectListByMemberNickname(memberNickname);
		if(list != null) return ResponseEntity.ok().body(list);
		else return ResponseEntity.notFound().build();
	}
}
