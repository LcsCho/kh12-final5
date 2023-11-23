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
import com.kh.movie.dao.MovieWishDao;
import com.kh.movie.dao.PreferGenreDao;
import com.kh.movie.dao.RatingDao;
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
	private MovieWishDao movieWishDao; 
	
	@Autowired
	private RatingDao ratingDao;
	
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
 		String memberId = (String) session.getAttribute("name");
		List<GenreDto> list = genreDao.selectList();
		model.addAttribute("list", list);
		model.addAttribute("name", memberId);
		return "member/joinFinish";
	}
	
 	@PostMapping("/joinFinish")
	public String joinFinish(@RequestParam(value = "selectedGenres", required = false) List<String> selectedGenres, 
										HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		// 선택한 장르를 DB에 저장
	    for (String genreName : selectedGenres) {
	        PreferGenreDto preferGenreDto = new PreferGenreDto();
	        preferGenreDto.setMemberNickname(memberDto.getMemberNickname());
	        preferGenreDto.setGenreName(genreName);
	        preferGenreDao.insert(preferGenreDto);
	    }
		session.removeAttribute("name");
		return "redirect:/";
	}

	
	//로그아웃
	@RequestMapping("/logout") //로그아웃하려면 로그인된 걸 remove 해주어야 함 - 로그아웃 시,세션값(name) 날라감
	public String logout(HttpSession session) {
		session.removeAttribute("name");
		session.removeAttribute("level");
		return "redirect:/";
	}

	
	@RequestMapping("/exitFinish")
	public String exitFinish() {
		return "redirect:/";
	}
	
	//마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		int ratingCount = ratingDao.getCount();
		model.addAttribute("ratingCount", ratingCount);
		
		String memberId = (String)session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		int movieWishCount = movieWishDao.count(memberId);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberImage", memberDao.findMemberImage(memberId));
		model.addAttribute("movieWishCount", movieWishCount);
		
		
		return "member/mypage";	
	}
	
}
