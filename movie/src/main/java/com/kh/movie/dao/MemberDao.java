package com.kh.movie.dao;

import java.util.List;

import com.kh.movie.dto.MemberDto;
import com.kh.movie.vo.MemberAgeGroupRecommendVO;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto login(MemberDto memberDto);
	int getCount();
	int searchCount(String memberNickname);
  
	//회원 아이디로 회원 닉네임 검색
	String findNicknameById(String memberId);
	//연락처 수정
	//boolean updateMemberInfo(String memberId, String memberContact);
	
	List<MemberDto> selectList();
	List<MemberDto> selectListByPage(int currentPage, int pageSize);
//	List<MemberDto> selectList(String memberNickname);
	List<MemberDto> selectSearchList(String memberNickname, int searchCurrentPage, int searchPageSize);
	boolean editUnit(MemberDto memberDto, String memberLevel);
	boolean delete(String memberId);
	
	boolean updateMemberLastLogin(String memberId);
	boolean lastUpdate(String memberId);
	MemberDto selectOneByNickname(String memberNickname);
	void updatePassword(MemberDto memberDto);
	void insertMemberImage(String memberId, int imageNo);
	Integer findMemberImage(String memberId);
	MemberAgeGroupRecommendVO getAgeGroup(String memberId);
	List<MemberDto> selectList(String memberNickname, int searchCurrentPage, int searchPageSize);
}
