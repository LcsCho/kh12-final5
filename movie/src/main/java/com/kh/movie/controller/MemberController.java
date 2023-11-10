package com.kh.movie.controller;

import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.GenreDao;
import com.kh.movie.dao.MemberDao;
import com.kh.movie.dto.GenreDto;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.dto.PreferGenreDto;
import com.kh.movie.service.EmailService;
//import com.kh.movie.service.EmailService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private GenreDao genreDao;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
	
		return "member/join";
	}
	// throws MessagingException, IOException
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto)throws MessagingException, IOException{
		memberDao.insert(memberDto);
		
		emailService.sendCelebration(memberDto.getMemberId());
		return "redirect:joinFinish";
	}
	
	@PostMapping("/joinFinish")
	public String joinFinish(@ModelAttribute PreferGenreDto preferGenreDto) {
		return "member/login";
	}
	
	@GetMapping("/joinFinish")
	public String joinFinish(@ModelAttribute GenreDto genreDto, String memberNickname, Model model) {
		List<GenreDto> list = genreDao.selectList();
		model.addAttribute("list", list);
		return "member/joinFinish";
	}
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto) {
		MemberDto target = memberDao.login(memberDto);
		if(target == null) {
			return "redirect:login?error";
		}
		else { //정보 설정 후 메인 또는 기존 페이지로 이동
			return "redirect:change";
		}
	}
	//개인정보 변경
	@GetMapping("/change")
	public String name(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "member/change";
	}
	
//	@PostMapping("/change")
//	public String change(@ModelAttribute MemberDto inputDto, HttpSession session) {
//		String memberId = (String) session.getAttribute("name");
//		
//		MemberDto findDto = memberDao.selectOne(memberId);
//			memberDao.updateMemberInfo(inputDto);//입력받아 정보 변경 처리
//			return "redirect:changeFinish";
//	}
	
	@RequestMapping("/changeFinish")
	public String changeFinish() {
		return "member/changeFinish";
	}
	
	//회원탈퇴
	@GetMapping("/exit")
	public String exit() {
		return "member/exit";
	}
	
	@PostMapping("/exit")
	public String exit(HttpSession session, @RequestParam String memberPw) {
		String memberId = (String) session.getAttribute("name");
		
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		if(memberDto.getMemberPw().equals(memberPw)) {
			//삭제
			memberDao.delete(memberId);
			//로그아웃
			session.removeAttribute("name");//세션에서 name의 값을 삭제
			return "redirect:exitFinish";//탈퇴완료 페이지로 이동
		}
		else {//비밀번호 불일치 시,
			return "redirect:exit?error";//에러페이지
		}
	}
	
	@RequestMapping("/exitFinish")
	public String exitFinish() {
		return "member/exitFinish";
	}
}
