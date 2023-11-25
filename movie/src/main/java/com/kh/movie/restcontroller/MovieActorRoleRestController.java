package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MovieActorRoleDao;
import com.kh.movie.dto.MovieActorRoleDto;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "영화 배우 역할 관리", description = "영화 배우 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rest/movieActorRole")
public class MovieActorRoleRestController {

	@Autowired
	private MovieActorRoleDao movieActorRoleDao;

	@PostMapping("/")
	public void insert(@RequestBody MovieActorRoleDto movieActorRoleDto) {
		int movieNo = movieActorRoleDao.sequence();
		movieActorRoleDao.insert(movieActorRoleDto);
	}

	@PatchMapping("/movieNo/{movieNo}/actorNo/{actorNo}")
	public ResponseEntity<String> editUnit(@PathVariable int movieNo, @PathVariable int actorNo,
			@RequestBody MovieActorRoleDto movieActorRoleDto) {
		if (movieActorRoleDto.isEmpty()) {
			return ResponseEntity.badRequest().build();
		}
		boolean result = movieActorRoleDao.editUnit(movieNo, actorNo, movieActorRoleDto);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@GetMapping("/movieNo/{movieNo}")
	//public List<MovieActorRoleDto> findByMovieNo(@PathVariable Integer movieNo) {
	public List<MovieActorRoleDto> findByMovieNo(@PathVariable int movieNo) {
		return movieActorRoleDao.findByMovieNo(movieNo);
	}
}
