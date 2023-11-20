package com.kh.movie.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;
import com.kh.movie.dao.ReplyDao;
import com.kh.movie.dto.ReplyDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	public List<ReplyDto> findAll(@RequestParam int reviewNo){
		return replyDao.findAll(reviewNo);
	}
	
	//댓글 등록
	@PostMapping("/insert")
	public void insert(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		int replyNo = replyDao.sequene();
		replyDto.setReplyNo(replyNo);
		
		String memberId = (String) session.getAttribute("name");
		String memberNickname = memberDao.findNicknameById(memberId);
		replyDto.setMemberNickname(memberNickname);
		
		replyDao.insert(replyDto);
	}
	
	//댓글 삭제
	@PostMapping("/delete")
	public void delete(@RequestParam int replyNo) {
		ReplyDto replyDto = replyDao.findByReplyNo(replyNo);
		replyDao.delete(replyNo);
	}
	
}
