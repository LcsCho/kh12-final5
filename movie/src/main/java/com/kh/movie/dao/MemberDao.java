package com.kh.movie.dao;

import com.kh.movie.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto login(MemberDto memberDto);
	
	void updateMemberInfo(MemberDto inputDto);
	void delete(String memberId);


}
