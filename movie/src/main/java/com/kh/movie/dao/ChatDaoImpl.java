package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ChatDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(ChatDto chatDto) {
		sqlSession.insert("chat.add", chatDto);
	}

	@Override
	public List<ChatDto> selectList() {
		return sqlSession.selectList("chat.findAll");
	}
}
