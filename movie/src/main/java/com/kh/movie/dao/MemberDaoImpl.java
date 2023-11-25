package com.kh.movie.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MemberDto;
import com.kh.movie.vo.MemberAgeGroupRecommendVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BCryptPasswordEncoder encoder;

	@Override
	public void insert(MemberDto memberDto) {
		//MemberDto에 있는 비밀번호를 암호화 처리 후 등록
		String origin = memberDto.getMemberPw();
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		sqlSession.insert("member.join", memberDto);
		
	}
	
	@Override
	public MemberDto selectOne(String memberId) {
		MemberDto memberDto = sqlSession.selectOne("member.findByMemberId", memberId);
		return memberDto;
	}
	
	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto target = sqlSession.selectOne("member.findByMemberId", memberDto.getMemberId());
		if(target != null) { //아이디가 존재하면
			boolean result = encoder.matches(memberDto.getMemberPw(),target.getMemberPw());
			if(result == true) { //비밀번호 암호화가 맞다고 판정되면
				return target;
			}
		}
		return null;
	}

	@Override
	public int getCount() {
		return sqlSession.selectOne("member.count");
	}
	
	@Override
	public int searchCount(String memberNickname) {
		return sqlSession.selectOne("member.searchCount", memberNickname);
	}
	
	//회원정보수정
	@Override
	public boolean updateMemberInfo(MemberDto inputDto) {
		return sqlSession.update("member.edit", inputDto) > 0;
	}


	@Override
	public boolean delete(String memberId) {
		return sqlSession.delete("member.remove", memberId) > 0;
	}

	@Override
	public List<MemberDto> selectList() {
		return sqlSession.selectList("member.findAll");
	}
	
	@Override
	public List<MemberDto> selectListByPage(int currentPage, int pageSize) {
		int end = currentPage * pageSize;
		int begin = end - (pageSize-1);
		Map params = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("member.selectListByPage", params);
	}
	
//	@Override
//	public List<MemberDto> selectList(String memberNickname) {
//		return sqlSession.selectList("member.adminSearch", memberNickname);
//	}
	
	@Override
	public List<MemberDto> selectSearchList(String memberNickname, int searchCurrentPage, int searchPageSize) {
		int end = searchCurrentPage * searchPageSize;
		int begin = end - (searchPageSize-1);
		Map<String, Object> params = Map.of("memberNickname", memberNickname, "begin", begin, "end", end);
		return sqlSession.selectList("member.adminSearchListByPage", params);
	}
	
	@Override
	public boolean editUnit(MemberDto memberDto, String memberId) {
		Map<String, Object> params = new HashMap<>();
		params.put("dto", memberDto);
		params.put("memberId", memberId);
		return sqlSession.update("member.updateMemberLevel", params) > 0;
	}
	
	//회원 아이디로 회원 닉네임 찾기
	@Override
	public String findNicknameById(String memberId) {
		return sqlSession.selectOne("member.findNicknameById", memberId);
	}

	//마지막 로그인 시각 갱신
	@Override
	public boolean updateMemberLastLogin(String memberId) {
		return sqlSession.update("member.lastLogin", memberId) > 0;
	}

	//마지막 정보수정 시각 갱신
	@Override
	public boolean lastUpdate(String memberId) {
		return sqlSession.update("member.lastUpdate", memberId) > 0;
	}

	//닉네임 체크
	@Override
	public MemberDto selectOneByNickname(String memberNickname) {
		return sqlSession.selectOne("member.nickCheck",memberNickname);
	}

	//비밀번호 재설정
	@Override
	public void updatePassword(MemberDto memberDto) {
		sqlSession.update("member.editByPw", memberDto);
	}
	@Override
	public void insertMemberImage(String memberId, int imageNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("imageNo", imageNo);
		sqlSession.insert("member.insertMemberImage",params);
		
	}

	@Override
	public Integer findMemberImage(String memberId) {
		
		return sqlSession.selectOne("member.findMemberImage",memberId);
	}

	// 회원 나이대 계산
	@Override
	public MemberAgeGroupRecommendVO getAgeGroup(String memberId) {
		return sqlSession.selectOne("member.ageGroup", memberId);
	}


}
