package com.kh.movie.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.movie.vo.ReviewLikeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ReviewLikeDaoImpl implements ReviewLikeDao{

	@Autowired
	private SqlSession sqlSession;
	
	//좋아요 설정
	@Override
	public void insert(int reviewNo, String memberNickname) {
		Map<String, Object> parameters = new HashMap<>();
        parameters.put("reviewNo", reviewNo);
        parameters.put("memberNickname", memberNickname);
		sqlSession.insert("reviewLike.save", parameters);
	}
	
	//좋아요 해제
	@Override
	public void delete(int reviewNo, String memberNickname) {
		Map<String, Object> parameters = new HashMap<>();
        parameters.put("reviewNo", reviewNo);
        parameters.put("memberNickname", memberNickname);
		sqlSession.delete("reviewLike.delete", parameters);
	}
	
	//좋아요 체크 여부
	@Override
	public String findReviewLike(int reviewNo, String memberNickname) {
		Map<String, Object> parameters = new HashMap<>();
        parameters.put("reviewNo", reviewNo);
        parameters.put("memberNickname", memberNickname);
        return sqlSession.selectOne("reviewLike.findReviewLike", parameters);
	}
	
}
