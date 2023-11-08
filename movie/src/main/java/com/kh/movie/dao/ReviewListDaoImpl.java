package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.vo.ReviewListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReviewListDaoImpl implements ReviewListDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<ReviewListVO> findByDateDesc() {
		return sqlSession.selectList("reviewList.findByDateDesc");
	}

	@Override
	public List<ReviewListVO> findByDateAsc() {
		return sqlSession.selectList("reviewList.findByDateAsc");
	}

	@Override
	public List<ReviewListVO> findByLikeDesc() {
		return sqlSession.selectList("reviewList.findByLikeDesc");
	}

	@Override
	public List<ReviewListVO> findByRatingDesc() {
		return sqlSession.selectList("reviewList.findByRatingDesc");
	}

	@Override
	public List<ReviewListVO> findByRatingAesc() {
		return sqlSession.selectList("reviewList.findByRatingAsc");
	}
	
	
}
