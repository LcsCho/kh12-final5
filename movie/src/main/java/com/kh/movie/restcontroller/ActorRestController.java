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

import com.kh.movie.dao.ActorDao;
import com.kh.movie.dto.ActorDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "배우 관리", description = "배우 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/actor")
public class ActorRestController {
	
	@Autowired
	private ActorDao actorDao;
	
	@GetMapping("/")
	public List<ActorDto> list() {
		return actorDao.selectList();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody ActorDto actorDto) {
		actorDao.insert(actorDto);
	}
	
	@DeleteMapping("/{actorNo}")
	public ResponseEntity<String> delete(@PathVariable int actorNo) {
		boolean result = actorDao.delete(actorNo);
		if (result) return ResponseEntity.status(200).build();
		else return ResponseEntity.status(404).build();
	}
	
	@GetMapping("/{actorName}")
	public List<ActorDto> find(@PathVariable String actorName) {
		return actorDao.selectList(actorName);
	}
	
	@PutMapping("/{actorNo}")
	public ResponseEntity<String> edit(@RequestBody ActorDto actorDto, @PathVariable int actorNo) {
		boolean result = actorDao.edit(actorNo, actorDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@PatchMapping("/{actorNo}")
	public ResponseEntity<String> editUnit(@RequestBody ActorDto actorDto, @PathVariable int actorNo) {
		if (actorDto.isEmpty()) return ResponseEntity.badRequest().build();
		boolean result = actorDao.editUnit(actorNo, actorDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
}
