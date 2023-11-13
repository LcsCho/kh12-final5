package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto login(MemberDto memberDto);
	int getCount();
	boolean updateMemberInfo(MemberDto inputDto);
	
	List<MemberDto> selectList();
	boolean editUnit(MemberDto memberDto, String memberLevel);
	boolean delete(String memberId);
	
	boolean updateMemberLastLogin(String memberId);
	boolean lastUpdate(String memberId);
}
