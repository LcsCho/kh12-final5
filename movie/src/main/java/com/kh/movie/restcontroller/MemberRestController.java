package com.kh.movie.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.movie.dao.MemberDao;

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
}
