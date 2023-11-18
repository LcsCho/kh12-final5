package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.RatingDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class RatingDaoImpl implements RatingDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("rating.sequence");
	}

	@Override
	public void insert(RatingDto ratingDto) {
		sqlSession.insert("rating.add", ratingDto);
	}

	@Override
	public boolean delete(int ratingNo) {
		return sqlSession.delete("rating.delete", ratingNo) > 0;
	}

	@Override
	public List<RatingDto> selectList() {
		return sqlSession.selectList("rating.findAll");
	}

	@Override
	public RatingDto findByRatingNo(int ratingNo) {
		return sqlSession.selectOne("rating.findByRatingNo", ratingNo);
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("rating.count");
	}

}
