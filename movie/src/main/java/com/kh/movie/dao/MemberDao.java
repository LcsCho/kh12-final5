package com.kh.movie.dao;

import com.kh.movie.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto login(MemberDto memberDto);
	int getCount();
	void updateMemberInfo(MemberDto inputDto);
	void delete(String memberId);

	//회원 아이디로 회원 닉네임 검색
	String findNicknameById(String memberId);
}
