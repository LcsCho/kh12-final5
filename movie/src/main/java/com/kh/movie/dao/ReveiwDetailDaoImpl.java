package com.kh.movie.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ReplyDto;
import com.kh.movie.vo.ReviewListVO;

@Repository
public class ReveiwDetailDaoImpl implements ReviewDetailDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	//리뷰 상세 조회
	@Override
	public List<ReviewListVO> findByReviewNo(int reviewNo) {
		return sqlSession.selectList("reviewList.findByReviewNo", reviewNo);
	}
	
	//댓글 조회
	@Override
	public List<ReplyDto> findAll(int reviewNo){
		return sqlSession.selectList("reply.findAll", reviewNo);
	}
}
