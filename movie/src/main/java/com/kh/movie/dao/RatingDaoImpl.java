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
	public int getCount() {
		return sqlSession.selectOne("rating.count");
	}

	@Override
	public int sequence() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insert(RatingDto ratingDto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean delete(int ratingNo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<RatingDto> selectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RatingDto findByRatingNo(int ratingNo) {
		// TODO Auto-generated method stub
		return null;
	}
}
