package com.kh.movie.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.dto.ReviewLikeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReviewLikeDaoImpl implements ReviewLikeDao{

	@Autowired
	private SqlSession sqlSession;
	
	//좋아요 설정
	@Override
	public void insert(ReviewLikeDto reviewLikeDto) {
		sqlSession.insert("reviewLike.save", reviewLikeDto);
	}
	
	//좋아요 해제
	@Override
	public void delete(ReviewLikeDto reviewLikeDto) {
		sqlSession.delete("reviewLike.delete", reviewLikeDto);
	}
	
	//좋아요 체크 여부
	@Override
	public String findReviewLike(int reivewNo, String memberNickname) {
		Map<String, Object> parameters = new HashMap<>();
        parameters.put("reviewNo", reivewNo);
        parameters.put("memberNickname", memberNickname);
        return sqlSession.selectOne("findReviewLike", parameters);
	}
	
}
