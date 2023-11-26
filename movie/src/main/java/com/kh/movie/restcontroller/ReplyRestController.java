package com.kh.movie.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.ReplyDao;
import com.kh.movie.dao.ReviewDao;
import com.kh.movie.dto.ReplyDto;
import com.kh.movie.vo.ReviewListVO;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Tag(name = "댓글 관리", description = "댓글 관리를 위한 컨트롤러")
@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private MemberDao memberDao;
	
	//댓글 조회
	@PostMapping("/findAll")
	public List<ReplyDto> findAll(@RequestParam int reviewNo, 
												HttpSession session, Model model){
		String memberId = (String) session.getAttribute("name");
		String memberNickname = memberDao.findNicknameById(memberId);
		model.addAttribute("memberNickname", memberNickname);
		
		return replyDao.findAll(reviewNo);
	}
	
	//댓글 등록
	@PostMapping("/insert")
	public void insert(@ModelAttribute ReplyDto replyDto,
								@RequestParam int reviewNo, HttpSession session) {
		int replyNo = replyDao.sequene();
		replyDto.setReplyNo(replyNo);
		
		String memberId = (String) session.getAttribute("name");
		String memberNickname = memberDao.findNicknameById(memberId);
		replyDto.setMemberNickname(memberNickname);
		
		replyDto.setReviewNo(reviewNo);
		
		replyDao.insert(replyDto);
	}
	
	//댓글 삭제
	@PostMapping("/delete")
	public void delete(@RequestParam int replyNo) {
		replyDao.delete(replyNo);
	}
}
