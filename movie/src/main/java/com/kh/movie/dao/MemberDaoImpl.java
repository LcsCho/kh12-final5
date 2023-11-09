package com.kh.movie.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MemberDto;

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
	public void updateMemberInfo(MemberDto inputDto) {
		
	}

	@Override
	public void delete(String memberId) {
		
	}

}
