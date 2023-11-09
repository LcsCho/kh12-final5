package com.kh.movie.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.service.EmailService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailService emailService;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
	
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) throws MessagingException, IOException {
		memberDao.insert(memberDto);
		emailService.sendCelebration(memberDto.getMemberId());
		return "redirect:joinFinish";
	}
	@GetMapping("/joinFinish")
	public String joinFinish() {
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
			return "redirect:login?success";
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
	
	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto inputDto, HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		
		MemberDto findDto = memberDao.selectOne(memberId);
			memberDao.updateMemberInfo(inputDto);//입력받아 정보 변경 처리
			return "redirect:changeFinish";
	}
	
	@RequestMapping("/changeFinish")
	public String changeFinish() {
		return "member/changeFinish";
	}
}
