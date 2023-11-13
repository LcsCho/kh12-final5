package com.kh.movie.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dto.MemberDto;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "회원 관리", description = "회원 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/member")
public class MemberRestController {

	@Autowired
	private MemberDao memberDao;
	
//	@GetMapping("/memberCount/{memberCount}")
//	public int count() {
//		return memberDao.getCount();
//	}
	@GetMapping("/memberCount")
	public int count() {
		return memberDao.getCount();
	}
	
	@PatchMapping("/{memberId}")
	public ResponseEntity<String> editUnit(@PathVariable String memberId,
			@RequestBody MemberDto memberDto) {
		if (memberDto.isEmpty()) return ResponseEntity.badRequest().build();
		boolean result = memberDao.editUnit(memberDto, memberId);
		return result ? ResponseEntity.ok().build() : ResponseEntity.notFound().build();
	}
	
	@GetMapping("/")
	public List<MemberDto> list() {
		return memberDao.selectList();
	}
}
