package com.kh.movie.dao;

import com.kh.movie.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto login(MemberDto memberDto);
	int getCount();
	void updateMemberInfo(MemberDto inputDto);
	boolean delete(String memberId);

}
