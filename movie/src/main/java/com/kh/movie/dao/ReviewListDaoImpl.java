package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.vo.ReviewListVO;

@Repository
public class ReviewListDaoImpl implements ReviewListDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ReviewListDao reviewListDao;

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
