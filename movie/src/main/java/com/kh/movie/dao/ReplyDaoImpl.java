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
	
	//댓글 조회
	@Override
	public List<ReplyDto> findAll(int reviewNo){
		return sqlSession.selectList("reply.findAll", reviewNo);
	}
}
