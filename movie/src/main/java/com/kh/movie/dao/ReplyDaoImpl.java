package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ReplyDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReplyDaoImpl implements ReplyDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequene() {
		return sqlSession.selectOne("reply.sequence");
	}
	
	//등록
	@Override
	public void insert(ReplyDto replyDto) {
		sqlSession.insert("reply.save", replyDto);
	}
	
	//삭제
	@Override
	public boolean delete(int replyNo) {
		return sqlSession.delete("reply.delete", replyNo) > 0;
	}
	
	//댓글 목록 조회
	@Override
	public List<ReplyDto> findAll(int reviewNo){
		return sqlSession.selectList("reply.findAll", reviewNo);
	}
	
	//댓글 상세 조회
	@Override
	public ReplyDto findByReplyNo(int replyNo) {
		return sqlSession.selectOne("reply.fingByReplyNo", replyNo);
	}
}
