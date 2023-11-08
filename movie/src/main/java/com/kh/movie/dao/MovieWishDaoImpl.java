package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.MovieWishDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MovieWishDaoImpl implements MovieWishDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("movieWish.sequence");
	}

	@Override
	public void insert(MovieWishDto moviewishDto) {
		sqlSession.insert("movieWish.add", moviewishDto);
	}

	@Override
	public boolean delete(int wishNo) {
		return sqlSession.delete("movieWish.delete", wishNo) > 0;
	}

	@Override
	public List<MovieWishDto> selectList() {
		return sqlSession.selectList("movieWish.findAll");
	}

	@Override
	public MovieWishDto selectOne(int wishNo) {
		return sqlSession.selectOne("movieWish.findByWishNo",wishNo);
	}
}
