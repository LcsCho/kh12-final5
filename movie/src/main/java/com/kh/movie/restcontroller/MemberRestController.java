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
import org.springframework.web.bind.annotation.RequestParam;
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
	
	//아이디 체크(이메일주소)
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) { //아이디가 없으면
			return "Y";
		}
		else { //아이디가 있으면
			return "N";
		}	
	}
	
	//닉네임 체크
	@PostMapping("/nicknameCheck")
	public String snicknameCheck(@RequestParam String memberNickname) {
		MemberDto memberDto = memberDao.selectOneByNickname(memberNickname);
		if(memberDto == null) { 
			return "Y";
		}
		else {
			return "N";
		}
	}

	//회원 등급별 인원 수 데이터 반환 매핑
}
