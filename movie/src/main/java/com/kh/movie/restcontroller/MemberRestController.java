package com.kh.movie.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
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

	@PostMapping("/changePw")
    public String changePassword(HttpSession session, String memberPw) {
        String memberId = (String) session.getAttribute("name");

        if (memberId != null && memberPw != null) {
            // 새로운 비밀번호 암호화
            String encryptedPassword = encoder.encode(memberPw);

            // 회원 정보 업데이트
            MemberDto memberDto = new MemberDto();
            memberDto.setMemberId(memberId);
            memberDto.setMemberPw(encryptedPassword);

            memberDao.updatePassword(memberDto); //DB에 비밀번호를 업데이트하는 메서드

            return "redirect:/main"; // 비밀번호 변경 후 이동할 페이지 지정
        } else {
            // 오류 처리
            return "redirect:/error"; // 적절한 오류 페이지로 리다이렉트
        }
    }
}