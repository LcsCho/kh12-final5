package com.kh.movie.controller;

import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.movie.dao.GenreDao;
import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.PreferGenreDao;
import com.kh.movie.dto.GenreDto;
import com.kh.movie.dto.MemberDto;
import com.kh.movie.dto.PreferGenreDto;
import com.kh.movie.service.EmailService;

import lombok.extern.slf4j.Slf4j;
//import com.kh.movie.service.EmailService;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private GenreDao genreDao;
	
	@Autowired
	private PreferGenreDao preferGenreDao;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
	
		return "member/join";         
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto, HttpSession session)throws MessagingException, IOException{
		memberDao.insert(memberDto);
		
		emailService.sendCelebration(memberDto.getMemberId());
		session.setAttribute("memberId", memberDto.getMemberId());
		return "redirect:/member/joinFinish";
	}
	

 	@GetMapping("/joinFinish")
	public String joinFinish(Model model, HttpSession session) {
 		String memberId = (String) session.getAttribute("memberId");
		List<GenreDto> list = genreDao.selectList();
		model.addAttribute("list", list);
		model.addAttribute("memberId", memberId);
		return "member/joinFinish";
	}
	
 	@PostMapping("/joinFinish")
	public String joinFinish(@RequestParam(value = "selectedGenres", required = false) List<String> selectedGenres, 
										HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberDao.selectOne(memberId);
		// 선택한 장르를 DB에 저장
	    for (String genreName : selectedGenres) {
	        PreferGenreDto preferGenreDto = new PreferGenreDto();
	        preferGenreDto.setMemberNickname(memberDto.getMemberNickname());
	        preferGenreDto.setGenreName(genreName);
	        preferGenreDao.insert(preferGenreDto);
	    }
		session.removeAttribute("memberId");
		return "redirect:/";
	}
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto inputDto, 
										HttpSession session) {
		//[1] 사용자가 입력한 아이디로 데이터베이스에서 정보를 조회
		MemberDto findDto = memberDao.selectOne(inputDto.getMemberId());
		//[2] 1번에서 정보가 있다면 비밀번호를 검사(없으면 차단)
		if(findDto == null) {
			return "redirect:login?error";//redirect는 무조건 GetMapping으로 간다
		}
		
		//boolean isCorrectPw = 입력한비밀번호와 DB비밀번호가 같나?
//		boolean isCorrectPw = inputDto.getMemberPw().equals(findDto.getMemberPw());
		boolean isCorrectPw = encoder.matches(inputDto.getMemberPw(), findDto.getMemberPw());
		
		//[3] 비밀번호가 일치하면 메인페이지로 이동
		if(isCorrectPw ) {
			//세션에 아이디+등급 저장
			session.setAttribute("name", findDto.getMemberId());
			session.setAttribute("level", findDto.getMemberLevel());
			//로그인시간 갱신
			memberDao.updateMemberLastLogin(inputDto.getMemberId());			
			//메인페이지로 이동
			return "redirect:change";
			}			
			
		//[4] 비밀번호가 일치하지 않으면 로그인페이지로 이동
		else {
			return "redirect:login?error";
		}
	}
	
//	@PostMapping("/login")
//	public String login(@ModelAttribute MemberDto memberDto) {
//		MemberDto target = memberDao.login(memberDto);
//		log.debug("dto = {}",memberDto);
//		if(target == null) {
//			return "redirect:login?error";
//		}
//		else { //정보 설정 후 메인 또는 기존 페이지로 이동
//			return "redirect:change";
//			
//		}
//	}
	
	//로그아웃
	@RequestMapping("/logout") //로그아웃하려면 로그인된 걸 remove 해주어야 함 - 로그아웃 시,세션값(name) 날라감
	public String logout(HttpSession session) {
		session.removeAttribute("name");
		return "redirect:/main";
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
			//마지막 정보 수정 시각 갱신
			memberDao.lastUpdate(inputDto.getMemberId());			
			return "redirect:changeFinish";
	}
	
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
	
		//log.debug("{}", memberDto.getMemberPw());
		//비밀번호와 암호화된 비밀번호를 비교하여 일치한다면
		if( memberDto != null && encoder.matches(memberPw, memberDto.getMemberPw())) {
			memberDao.delete(memberId);//삭제
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
	
	//마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		//[1]세션에서 사용자의 아이디를 꺼낸다
		// -세션은 값을 Object로 저장한다(아무거나 넣어야 하니까)
		String memberId = (String)session.getAttribute("name");
		//[2]가져온 아이디로 회원정보를 조회한다
		MemberDto memberDto = memberDao.selectOne(memberId);
		//[3]조회한 정보를 모델에 첨부한다
		model.addAttribute("memberDto", memberDto);
		//[5]이 회원의 프로필 이미지 번호를 첨부한다
//		model.addAttribute("profile", memberDao.findProfile(memberId));
		
		
		return "member/mypage";	
	}
	
}
