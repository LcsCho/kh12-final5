package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto login(MemberDto memberDto);
	int getCount();
  
	//회원 아이디로 회원 닉네임 검색
	String findNicknameById(String memberId);
	boolean updateMemberInfo(MemberDto inputDto);
	
	List<MemberDto> selectList();
	boolean editUnit(MemberDto memberDto, String memberLevel);
	boolean delete(String memberId);
	
	boolean updateMemberLastLogin(String memberId);
	boolean lastUpdate(String memberId);
	MemberDto selectOneByNickname(String memberNickname);
}
